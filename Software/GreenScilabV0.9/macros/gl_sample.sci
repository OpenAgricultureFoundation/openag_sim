function [sqa,sqb,sqbu,sqc,sel,um,umb,uml] = gl_sample(Tr,N,maxp,Nu_Ma,Nu_I,Nu_O,u,rt_a,st_j,a,b,bu,c)

// Ouput variables initialisation (not found in input variables)
sqa=[];
sqb=[];
sqbu=[];
sqc=[];
sel=[];
um=[];
umb=[];
uml=[];

// Display mode
//mode(-1);

// Display warning for floating point exception
//sieee(1);

// This function is to get random sequence with MonteCarlo method. 
// Tr is number of random structure with each physiologicasl age
// we should be very cautious in using rand matrix because there is covariance

rand("seed",3);

// sqb are 0/1 sequence describing a growth unit grow or not
sqb = zeros(max(Tr),N,maxp);


for p = 1:maxp
  for i = 1:min(N,Nu_Ma(p)) 
    for r = 1:Tr(p)
      sqb(r,i,p) = ceil(b(p)-rand());
    end;
  end;
end;

// sqc are 0/1 sequence describing a growth unit die or not
sqc = zeros(max(Tr),N,maxp);
for p = 1:maxp
  for r = 1:Tr(p)
    count = 0;
    for i = 1:min(N,Nu_Ma(p))
      if rand()<c(p) then
        count = count+1;
      else
        break;
      end;
    end;
    sqc(r,1:count,p) = 1;
  end;
end;

disp("sqbu"); //tic
sqbu = zeros(max(Tr),N*max(u),maxp);
sqa = zeros(max(Tr),N*max(u),max(max(Nu_O(4,:,:))),maxp);
sel = zeros(max(Tr),N*max(u),max(max(Nu_O(4,:,:))),maxp);
umb = zeros(max(Tr),N,maxp,6);
// sel are interger numbers between 1-Tr showing the ID of chosed branch
//N+1 is for terminal structure. If branching probability considered, should one more index
for p = 1:maxp
  for r = 1:Tr(p)
    sumi = 0;
    for i = 1:min(N,Nu_Ma(p))
      for k = 6:-1:p //remember the sequence--from min to max phy_age
       suma = 0;
       for j = 1:Nu_I(p,k) // for each microsate
        sumi = sumi+1;
        sqbu(r,sumi,p) = ceil(bu(p)-rand());
        if sqbu(r,sumi,p)==1 & sqb(r,i,p)==1 & sqc(r,i,p)==1 then
          suma = suma+1;  //number of microstate(p,k)
          if maxp>=k then //only if internode exist
           for bj = 1:Nu_O(4,p,k) // for each branch
            sqa(r,sumi,bj,p) = ceil(a(k)-rand());
            if sqa(r,sumi,bj,p)>0 then
              sel(r,sumi,bj,p) = ceil(rand()*Tr(k));
            end;
           end;
          end;
        end;
       end;
       if sqb(r,i,p)==1 & sqc(r,i,p)==1 then
         umb(r,i,p,k) = suma;
       end;
      end;
    end;
  
    if N>Nu_Ma(p,1) then // terminal structure exist
     k = st_j(p);
     if k>=p & k<=maxp then
       sel(r,Nu_Ma(p,1)*u(p)+1,1,p) = ceil(rand()*Tr(k));
     end;
    end;
  
  end;
end;

//toc

//um are number of metamer in G.U. along the aixs, it''s result of b,bu,c
//uml are number of leaves in G.U. along the aixs, it''s result of b,bu,c
um = zeros(max(Tr),N,maxp);
uml = zeros(max(Tr),N,maxp);
for p = 1:maxp
  for r = 1:Tr(p)
    for i = 1:min(N,Nu_Ma(p))
      um(r,i,p) = sqb(r,i,p)*sqc(r,i,p)*sum(sqbu(r,(i-1)*u(p)+1:i*u(p),p));
      sumi = (i-1)*u(p);  nl = 0;
      for k = 6:-1:p
        nl = nl+sum(sqbu(r,sumi+1:sumi+Nu_I(p,k),p))*Nu_O(1,p,k);
        sumi = sumi+Nu_I(p,k);
      end;
      uml(r,i,p) = sqb(r,i,p)*sqc(r,i,p)*nl;
    end;
  end;
end;

disp("end of random sequence")

Flag_smaple_check = 0;
MS = zeros(4,maxp);
MTh = zeros(4,maxp);
VS = zeros(4,maxp);
VTh = zeros(4,maxp);

if Flag_smaple_check==1 then
  printf("            Simu/Theo--b;    Simu/Theo--bu;    Simu/Theo--c;     Simu/Theo--compound\n");
  for p = 1:maxp
    printf("Mp=%3d",p);
    Num = min(N,Nu_Ma(p));
    //b
    MTh(1,p) = Num*u(p)*b(p);  VTh(1,p) = Num*u(p)^2*b(p)*(1-b(p));  //theoretical mean and variance     
    tempb = matrix(sqb(:,:,p),max(Tr),N)*u(p);  //simulation mean and variance
    MS(1,p) = sum(sum(tempb,1))/Tr(p);
    tempb1 = sum(tempb,2);
    VS(1,p) = sum((tempb1(1:Tr(p))-MS(1,p)) .^2);
    if Tr(p)>1 then
      VS(1,p) = VS(1,p)/(Tr(p)-1);
    else
      VS(1,p) = 0;
    end;
    //bu        
    MTh(2,p) = Num*u(p)*bu(p);  VTh(2,p) = Num*u(p)*bu(p)*(1-bu(p));  //theoretical mean and variance
    tempbu = matrix(sqbu(:,:,p),max(Tr),N*max(u));  //simulation mean and variance
    MS(2,p) = sum(sum(tempbu,1))/Tr(p);
    tempbu1 = sum(tempbu,2);
    VS(2,p) = sum((tempbu1(1:Tr(p))-MS(2,p)) .^2);
    if Tr(p)>1 then
      VS(2,p) = VS(2,p)/(Tr(p)-1);
    else
      VS(2,p) = 0;
    end;
    //c
    MTh(3,p) = sum(c(p).^[1:Num]);  //theoretical mean and variance
    cc = c(p);
    if c(p)<1 then
      MTh(3,p) = cc*(1-cc^Num)/(1-cc);
    else
      MTh(3,p) = Num;
    end;
    if c(p)<1 then
      VTh(3,p) = c(p)/(1-c(p))^2*(1-c(p)^Num*(2*Num+1)*(1-c(p))-c(p)^(2*Num+1));
    else
      VTh(3,p) = 0;
    end;
    MTh(3,p) = MTh(3,p)*u(p);
    VTh(3,p) = VTh(3,p)*u(p)^2;
    tempc = matrix(sqc(:,:,p),max(Tr),N)*u(p);  //simulation mean and variance
    MS(3,p) = sum(sum(tempc,1))/Tr(p);
    tempc1 = sum(tempc,2);
    VS(3,p) = sum((tempc1(1:Tr(p))-MS(3,p)) .^2);
    if Tr(p)>1 then
      VS(3,p) = VS(3,p)/(Tr(p)-1);
    else
      VS(3,p) = 0;
    end;
    //coumpound
    MTh(4,p) = sum(c(p) .^[1:Num])*b(p)*u(p)*bu(p);  //theoretical mean and variance
    //VTh(4,p)=Num*b(p)*u(p)*bu(p)*(1-bu(p))+Num*b(p)*(1-b(p))*(u(p)*bu(p))^2;%V=m1v2+v1m2^2        
    m1 = b(p);  v1 = b(p)*(1-b(p));  m2 = u(p)*bu(p);  v2 = u(p)*bu(p)*(1-bu(p));  m3 = MTh(3,p)/u(p);  v3 = VTh(3,p)/(u(p)^2);
    m12 = m1*m2;  v12 = m1*v2+v1*m2^2;
    m312 = m3*m12;
    v312 = m3*v12+v3*m12^2;
    MTh(4,p) = m312;
    VTh(4,p) = v312;
  
    tempum = matrix(um(:,:,p),max(Tr),N);  //simulation mean and variance       
    MS(4,p) = sum(sum(tempum,1))/Tr(p);
    tempum1 = sum(tempum,2);
    VS(4,p) = sum((tempum1(1:Tr(p))-MS(4,p)) .^2);
    if Tr(p)>1 then
      VS(4,p) = VS(4,p)/(Tr(p)-1);
    else
      VS(4,p) = 0;
    end;
    //output
    for j = 1:4
      printf("%10.2f%8.2f",MS(j,p),MTh(j,p));
    end;
    printf("\n");
    fprintf("Vp=%3d",p);
    for j = 1:4
      printf("%10.2f%8.2f",VS(j,p),VTh(j,p));
    end;
    printf("\n");
    printf("\n");
  end;
end;

clear("tempb","tempbu","tempc","tempum")

Flag_smaple_distribution = 1;
//distribution figure
if Flag_smaple_distribution==1 then
  figu=scf();
  set(gca(),"auto_clear","off"); 
  u = sum(Nu_I,2);
  for p = 1:maxp
    Num = min(N,Nu_Ma(p));
    nmax = u(p)*Num;
  
    //compound, theory
  // *** MATLAB ***
//    f = zeros(1,nmax+1);
//    for i = 1:nmax+1
//      for j = 0:Num-1
//        for k = 0:j
//          f(i) = f(i)+(1-c(p))*c(p)^j*binopdf(k,j,b(p))*binopdf(i-1,k*u(p),bu(p));
//        end;
//      end;
//      for k = 0:Num //item when total Num macrostates
//       f(i) = f(i)+c(p)^Num*binopdf(k,Num,b(p))*binopdf(i-1,k*u(p),bu(p));
//      end;
//    end;
 // **** MATLAB END *****   
    
 // **** SCILAB ***
    f=zeros(1,nmax+1);
    if u(p)==0 then
      for i=1:nmax+1
        f(i)=f(i)+(1-c(p));
        for j=1:Num-1
          proba_1=binomial(b(p),j);
          for k=0:j
           f(i)=f(i)+(1-c(p))*c(p)^j*proba_1(k+1);
          end;
        end;
        proba_3 = binomial(b(p),Num);
        for k=0:Num
          f(i)=f(i)+c(p)^Num*proba_3(k+1);
        end;
      end;
    else
      for i=1:nmax+1
        f(i)=f(i)+(1-c(p));
       for j=1:Num-1
          proba_1=binomial(b(p),j);
          f(i)=f(i)+(1-c(p))*c(p)^j*proba_1(1);
          for k=1:j
            proba_2=binomial(bu(p),k*u(p));     // ERROR : i may be greater than k*u(p)
            if i-1<=k*u(p) then
              f(i)=f(i)+(1-c(p))*c(p)^j*proba_1(k+1)*proba_2(i);
            end;
          end;
        end;
        proba_3 = binomial(b(p),Num);
        f(i)=f(i)+c(p)^Num*proba_3(1);
        for k=1:Num
          proba_4=binomial(bu(p),k*u(p));
          if i-1<=k*u(p) then
            f(i)=f(i)+c(p)^Num*proba_3(k+1)*proba_4(i);
          end;
        end;
      end;    
    end;
  // *** SCILAB END ****    

    i = 0:nmax;
    plot(i,f,"k"); 

    //compound, simulation      
    fS = zeros(1,nmax+1);
    tempum = matrix(um(:,:,p),max(Tr),N);
    temp = sum(tempum,2);  //number of microstate in each axis
    size(temp)
    for k = 1:Tr(p) //for each stochastic axis
     if temp(k)>0 then
       fS(temp(k)+1) = fS(temp(k)+1)+1;
     end;
    end;
    fS = fS/Tr(p);
    i = 0:nmax;
    plot(i,fS);
    legend(["Theoritical distribution","Simulated distribution"]);
  end
  axi=gca();
  axi.x_label.text = "Number of internodes in bearing axis";
  axi.y_label.text = "Probabilities";
  axi.title.text = "Compound distribution of number of internodes in bearing axis. N=5,u=9,p_C=0.99,p_A=0.9,p_I=0.86";


  //theoretical distribution of number of microstate of physiological age, single and compound
  figu=scf();  set(gca(),"auto_clear","off");  
  u = sum(Nu_I,2);
  for p = 1:maxp
    Num = min(N,Nu_Ma(p));
    nmax = u(p)*Num;
    //c
    f = zeros(1,nmax+1);
    for i = 1:nmax+1
      if pmodulo(i-1,u(p))==0 then //if it is integer times of u(p)
       n = (i-1)/u(p); //number of cycles
       if n<N then
         f(i)=(1-c(p))*c(p)^n;
       else
         f(i)=c(p)^n;
       end;
      end;
    end;
    i = 0:nmax;
    //plot(i,f,''r'')
    //b
    f = zeros(1,nmax+1);
    //tmp = binopdf(0:Num,Num,b(p));
    tmp = binomial(b(p),Num);
    f(1)=tmp(1);  //item 0
    for i = 1:nmax
      if pmodulo(i,u(p))==0 then //it is integer times of u(p)
       f(i+1)=tmp(i/u(p)+1); //becareful of the shift
      end;
    end;
    i = 0:nmax;
    //plot(i,f,''g'')
    //bu
    f = zeros(1,nmax+1);
    //f = binopdf(0:nmax,nmax,bu(p));  // ORIGINAL
    if nmax == 0 then    // QR 2006 04 19
      f = 1;
    else
      f = binomial(bu(p),nmax);
    end;                 // QR END
    i = 0:nmax;
    //plot(i,f,''b'')
    //compound
    
  // **** MATLAB *****
//    f = zeros(1,nmax+1);
//    for i = 1:nmax+1     
//      for j = 0:Num-1
//        for k = 0:j
//          f(i)=f(i)+(1-c(p))*c(p)^j*binopdf(k,j,b(p))*binopdf(i-1,k*u(p),bu(p));
//        end;
//      end;
//      for k = 0:Num //item when total Num macrostates
//       f(i)=f(i)+c(p)^Num*binopdf(k,Num,b(p))*binopdf(i-1,k*u(p),bu(p));
//      end;
//    end;
  // **** END ****
    
  // *** SCILAB ***** 
   f=zeros(1,nmax+1);
   if u(p)==0 then    
    for i = 1:nmax+1 
      f(i)=f(i)+(1-c(p));
      for j = 1:Num-1
        proba_5=binomial(b(p),j);
        for k=0:j
          f(i)=f(i)+(1-c(p))*c(p)^j*proba_5(k+1);
        end;
      end;

      proba_7=binomial(b(p),Num);
      for k = 0:Num //item when total Num macrostates
       f(i)=f(i)+c(p)^Num*proba_7(k+1);
      end;
    end;
   else
    for i = 1:nmax+1
      f(i)=f(i)+(1-c(p));
      for j = 1:Num-1
        proba_5=binomial(b(p),j);
        f(i)=f(i)+(1-c(p))*c(p)^j*proba_5(1);
        for k=1:j
          proba_6=binomial(bu(p),k*u(p));
          if i-1<=k*u(p) then
            f(i)=f(i)+(1-c(p))*c(p)^j*proba_5(k+1)*proba_6(i);
          end;
        end;
      end;
      proba_7=binomial(b(p),Num);
      f(i)=f(i)+c(p)^Num*proba_7(1);
      for k=1:Num
        proba_8=binomial(bu(p),k*u(p));
        if i-1<=k*u(p) then
          f(i)=f(i)+c(p)^Num*proba_7(k+1)*proba_8(i);
        end;
      end;
    end;
   end;
  // *** SCILAB END *****
    
    
    i = 0:nmax;
    //h=plot(i,f,''k'') 
    bar(i,f,0.5)
    //plot2d3(i,f,0.5)   // doesnt work
    //set(h,''LineWidth'',2);      
    //legend(''p_c=0.99,  p_a=1,     p_i=1  '',''p_c=1,      p_a=0.9,   p_i=1'',''p_c=1,       p_a=1,     p_i=0.8'',''p_c=0.95,  p_a=0.9,  p_i=0.8'',1)
    //%legend(''p_C=0.99,  p_A=0.94,  p_I=0.86'',1)
  end;
  axi = gca();
  axi.x_label.text = "Number of internodes in bearing axis";
  axi.y_label.text = "Probabilities";
  axi.title.text = "Compound distribution of number of internodes in bearing axis. N=5,u=9,p_C=0.99,p_A=0.9,p_I=0.86";

end;
endfunction
