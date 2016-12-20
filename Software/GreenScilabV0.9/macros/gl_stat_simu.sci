function [MSim,VSim,MSSim,VSSim] = gl_stat_simu(S,N,maxp,Tr,b,bu,c,Nu_Ma,Nu_I,Nu_A,st_j,rt_a) 

// Ouput variables initialisation (not found in input variables)
MSim=[];
VSim=[];
MSSim=[];
VSSim=[];

// Display mode
mode(-1);

// Display warning for floating point exception
//ieee(1);

//this function is to find mean and variance od item in structure

//MSim, covsim, MSSim, VSSim: simulated mean and variance

//M and V for each phy_age
MSim = zeros(N,maxp);
VSim = zeros(N,maxp);
//M and V for total
MSSim = zeros(N,N);
VSSim = zeros(N,N);


//S    =zeros(maxp,N,N,maxp,max(Tr),max(b_o(:))+1);

//%v0 = mtlb_double(Tr);
S2 = zeros(N,N,maxp,max(Tr));
S2 = matrix(S(1,:,:,:,:,1),N,N,maxp,max(Tr));
S3 = zeros(N,maxp,max(Tr));
S3 = matrix(sum(S2,1),N,maxp,max(Tr));

S5 = zeros(N,max(Tr));
S5 = matrix(sum(S3,2),N,max(Tr));


//%%%%%%%%%%%%%%%%%%%%%%simulated mean and covariance  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:N
  for p = 1:maxp
    tmp = S3(i,p,1:Tr(1));
    MSim(i,p) = sum(tmp)/Tr(1);
    if Tr(1)>1 then
      VSim(i,p) = sum((tmp-MSim(i,p)).^2)/(Tr(1)-1);
    end;
  end;
end;

for k = 1:N
  MSSim(k,1)=sum(S5(k,:))/Tr(1);
  if Tr(1)>1 then
    VSSim(k,1)=sum((S5(k,:)-MSSim(k,1)).^2)/(Tr(1)-1);
  end;
end;

Flag_distribution = 0;
if Flag_distribution==1 then
//  figure("Name","Distribution of number of all microstates");
  figr=scf();
  set(gca(),"auto_clear","off");
  S4 = zeros(1,max(Tr));
  S4 = matrix(S5(N,:),1,max(Tr));  //S(N,1)
  Nm = max(S4);  //possible value is 0 to Nm
  f = zeros(1,Nm+1);
  for i = 1:Tr(1)
    f(S4(i)+1)=f(S4(i)+1)+1;
  end;
  f = f/sum(f);
  k = 0:Nm;
  plot(k,f,"b");  h = gce();
  %set(mtlb(h),"LineWidth",2);

  //compound distribution of axis of phy_age 1
  u = sum(Nu_I(1,:));
  g = zeros(1,N+1);  //conpound of b and c
  proba_10=binomial(b(1),N);
  for k = 0:N
    for i = k:N-1 
      if i<>0 then
        proba_9=binomial(b(1),i);
        //g(k+1)=g(k+1)+(1-c(1))*c(1)^i*binopdf(k,i,b(1));
        g(k+1)=g(k+1)+(1-c(1))*c(1)^i*proba_9(k+1);
      end;
    end;
    //g(k+1)=g(k+1)+c(1)^N*binopdf(k,N,b(1));
    g(k+1)=g(k+1)+c(1)^N*proba_10(k+1);
  end;
  m = N*u;
  h = zeros(1,m+1);
  for k = 0:m //possible number of microstates in axis
   //for j = 0:N //possible number of macrostates in i cycles
   for j=1:N
    proba_12=binomial(bu(1),j*u(1));                        // binomial in place of binopdf QR 2006 04 20
                                                            // same as below
    for i = j:N-1 //possible number of cycles to survive
     proba_11=binomial(b(1),i);
     //h(k+1)=h(k+1)+(1-c(1))*c(1)^i*binopdf(j,i,b(1))*binopdf(k,j*u(1),bu(1));
     if k<=j*u(1) then
      h(k+1)=h(k+1)+(1-c(1))*c(1)^i*proba_11(j+1)*proba_12(k+1);
     end;
    end;
    //h(k+1)=h(k+1)+c(1)^N*binopdf(j,N,b(1))*binopdf(k,j*u(1),bu(1)); //boundary
    if k<=j*u(1) then
      h(k+1)=h(k+1)+c(1)^N*proba_10(j+1)*proba_12(k+1); //boundary
    end;
   end;
  end;
  k = 0:m;
  plot(k,h,"r");  h = gce();
  %set(h,"LineWidth",2);
  legend(["Simulation","Theory"]);
  axi=gca();
  axi.title.text="Distribution of number of microstates in an axis,p_c=0.95,p_a=0.9,p_i=0.8,N=10,u=3,T=500 ";
  //bu
  //     m=N*3;
  //     h=zeros(1,m+1);
  //     for k=0:m
  //         h(k+1)=binopdf(k,m,bu(1));
  //     end
  //         k=0:m;    
  //     h=plot(k,h,'b');
  //     set(h,'LineWidth',2);  
  //     
  //     %b
  //     m=N*3;
  //     h=zeros(1,m+1);
  //     for k=0:m
  //         if mod(k,3)==0
  //             h(k+1)=binopdf(k/3,m/3,b(1));
  //         end
  //     end
  //     k=0:m;    
  //     h=plot(k,h,'g');
  // %    set(h,'LineWidth',2);  
  // 
  //     %c
  //     m=N*3;
  //     h=zeros(1,m+1);
  //     for k=0:m-1
  //         if mod(k,3)==0        
  //             h(k+1)=(1-c(1))*c(1)^(k/3);
  //         end
  //     end
  //     h(m+1)=c(1)^N;
  //         k=0:m;    
  //     h=plot(k,h,'m');
  //     %set(h,'LineWidth',2);  
  //     legend('p_c=0.95,p_a=0.9,p_i=0.8','p_c=1,p_a=1,p_i=0.8','p_c=1,p_a=0.9,p_i=1','p_c=0.95,p_a=1,p_i=1',1)
  //     
  //     %b
  //     m=N;
  //     h=zeros(1,m+1);
  //     for k=0:m
  //             h(k+1)=binopdf(k,m,b(1));
  //     end
  //         k=0:m;    
  //     h=plot(k,h,'g');
  //     set(h,'LineWidth',2);  
  // 
  //     %c
  //     m=N;
  //     h=zeros(1,m+1);
  //     for k=0:m-1
  //             h(k+1)=(1-c(1))*c(1)^(k);
  //     end
  //     h(m+1)=c(1)^N;
  //         k=0:m;    
  //     h=plot(k,h,'m');
  //     set(h,'LineWidth',2);  
  //     legend('Compund law','Bino(N*u,p_i)','Bino(N,p_a)','GeomTrunc(p_c,N)',1)    
end;
endfunction
