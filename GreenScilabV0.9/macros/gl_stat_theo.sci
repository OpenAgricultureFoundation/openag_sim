function [MTh,VTh,MSTh,VSTh] = gl_stat(N,maxp,Nu_I,Nu_O,st_j,Nu_Ma,rt_a,a,c,b,bu)

// Ouput variables initialisation (not found in input variables)
MTh=[];
VTh=[];
MSTh=[];
VSTh=[];

// Display mode
mode(-1);

// Display warning for floating point exception
//ieee(1);


//M and V for each phy_age
MTh = zeros(maxp,6,N);
VTh = zeros(maxp,6,N);
//M and V for total
MSTh = zeros(maxp,N);
VSTh = zeros(maxp,N);

Nu_A = matrix(Nu_O(4,:,:),maxp,6);
// computing the mean and variance
u = sum(Nu_I,2);

I = ones(N,1);

//survival probablity c--number of macrostate in chr_age i x~ truncated geometrical distribution
Mx = zeros(maxp,N);
Vx = zeros(maxp,N);
for p = 1:maxp
  for i = 1:N
    n = min(i,Nu_Ma(p));
    if c(p)<1 then
      Mx(p,i) = c(p)*(1-c(p)^n)/(1-c(p));
      Vx(p,i) = c(p)*(1-(2*n+1)*(1-c(p))*c(p)^n-c(p)^(2*n+1))/(1-c(p))^2;
    else
      Mx(p,i) = n;
      Vx(p,i) = 0;
    end;
  end;
end;


//covariance between macrostate because of c
MC = zeros(maxp,N,N);
VC = zeros(maxp,N,N);
for p = 1:maxp
  for i = 1:N
    for j = i:N
      if i==j then //mean and variance for existence of a single macrostate
       MC(p,i,i) = c(p)^i;
       VC(p,i,i) = c(p)^i*(1-c(p)^i);
      else //covariance matrix between the macrostates
       VC(p,i,j) = c(p)^j*(1-c(p)^i);
       VC(p,j,i) = VC(p,i,j);
      end;
    end;
  end;
end;

//growth probability of each macrosate --number of macrostate during one cycle y~  0/1 distribution
My = zeros(maxp,1);
Vy = zeros(maxp,1);
for p = 1:maxp
  My(p)=b(p);
  Vy(p)=b(p)*(1-b(p));
end;

//growth probability of each microsate in a macrostate-- number of microstate in a macrostate z~ bion(Nu_I(p,k),bu(p)) distribution
Mz = zeros(maxp,6);
Vz = zeros(maxp,6);
Mu = zeros(maxp,1);
Vu = zeros(maxp,1);//sum of Mz
for p = 1:maxp
  Mz(p,:) = Nu_I(p,:)*bu(p);
  Vz(p,:) = Nu_I(p,:)*bu(p)*(1-bu(p));
  Mu(p)=sum(Nu_I(p,:))*bu(p);
  Vu(p)=sum(Nu_I(p,:))*bu(p)*(1-bu(p));
end;

//branching probability of each buds in a microstate -- number of substructures in a microstate w ~ bino(Nu_A(p,k),a(k)) distribution
Mw = zeros(maxp,6);
Vw = zeros(maxp,6);
for p = 1:maxp
  for k = p:maxp
    Mw(p,k) = Nu_A(p,k)*a(k);
    Vw(p,k) = Nu_A(p,k)*a(k)*(1-a(k));
  end;
end;

//compound law of y (b) and z (bu)--if a macostate live, number of microstate inside it: yz
Myz = zeros(maxp,6);
Vyz = zeros(maxp,6);
Myu = zeros(maxp,1);
Vyu = zeros(maxp,1);
for p = 1:maxp
  for k = p:6
    Myz(p,k) = My(p)*Mz(p,k);
    Vyz(p,k) = My(p)*Vz(p,k)+Vy(p)*(Mz(p,k)^2);
  end;
  Myu(p)=My(p)*Mu(p);
  Vyu(p)=My(p)*Vu(p)+Vy(p)*Mu(p)^2;
end;

//compound law of y (b) and z (bu) and a--if a macostate live, number of substructures inside it: yzw
//mean and var of number of substructure with phy_age j in macrostate p with chr age k
Myzw = zeros(maxp,6);
Vyzw = zeros(maxp,6);
for p = 1:maxp
  for k = p:6
    Myzw(p,k) = Myz(p,k)*Mw(p,k);
    Vyzw(p,k) = Myz(p,k)*Vw(p,k)+Vyz(p,k)*(Mw(p,k)^2);
  end;
end;

for p = maxp:-1:1
  //mean and var of number of microstates(from substructure) in a macrostates

  for i = 1:N //chr_age of substructure p
   MA = zeros(maxp,6,N); 
   VA = zeros(maxp,6,N);
   //number of microstates in axis (p,i), compound of c and b, bu
   MTh(p,p,i) = Mx(p,i)*Myu(p);
   VTh(p,p,i) = Mx(p,i)*Vyu(p)+Vx(p,i)*(Myu(p)^2);
  
   for k = max(1,i-mtlb_double(Nu_Ma(p,1))+1):i //lateral structure, k is chr_age of macrostate    
    x = i-k+1; //time order when G.U. appear
    for j = p+1:maxp
      jd = (k-1)*rt_a(j,1);  //the ch_age of substructure                                                          
      flag = 1;  //(Flag_pruning(b)~=1) | (jd<=T_Pr(b)+Pruning_delay(b)) ;%not prunned                              
      if jd>0 & flag then
        for m = j:maxp
          MA(p,m,x) = MA(p,m,x)+Myzw(p,j)*MTh(j,m,jd);
          VA(p,m,x) = VA(p,m,x)+Myzw(p,j)*VTh(j,m,jd)+Vyzw(p,j)*(MTh(j,m,jd)^2);
        end;
      end;
    
    end;
   end;
  
   for m = p+1:maxp
     M1 = matrix(MA(p,m,:),1,N);  //vector of mean of microstate m top down
     V1 = matrix(VA(p,m,:),1,N);  //vector of var  of microstate m top down
     MTh(p,m,i) = (M1*matrix(MC(p,:,:),N,N))*I;
     VTh(p,m,i) = V1*matrix(MC(p,:,:),N,N)*I+M1*matrix(VC(p,:,:),N,N)*M1';
   end;
  
   //terminal structure
   j = st_j(p);
   if i>Nu_Ma(p) & j>=p & j<=maxp then
     jd = i-Nu_Ma(p);
     for m = j:maxp
       MTh(p,m,i) = MTh(p,m,i)+MTh(j,m,jd);
       VTh(p,m,i) = VTh(p,m,i)+VTh(j,m,jd);
     end;
   end;
  
  end;  //i
end;//p

//total number
for p = maxp:-1:1
  //mean and var of number of microstates(from substructure) in a macrostates
  for i = 1:N //chr_age of substructure p
   MA1 = zeros(maxp,N); 
   VA1 = zeros(maxp,N);
   MA2 = zeros(maxp,N); 
   VA2 = zeros(maxp,N);
   MA = zeros(maxp,N); 
   VA = zeros(maxp,N);
  
   for k = max(1,i-Nu_Ma(p,1)+1):i //lateral structure, k is chr_age of macrostate
    x = i-k+1; //time order when G.U. appear
    //number in axis            
    MA1(p,x) = Myu(p);
    VA1(p,x) = Vyu(p);
    for j = p+1:maxp
      jd = (k-1)*rt_a(j,1);  //the ch_age of substructure                                                          
      flag = 1;  //(Flag_pruning(b)~=1) | (jd<=T_Pr(b)+Pruning_delay(b)) ;%not prunned                              
      if jd>0 & flag then
        MA2(p,x) = MA2(p,x)+Myzw(p,j)*MSTh(j,jd);
        VA2(p,x) = VA2(p,x)+Myzw(p,j)*VSTh(j,jd)+Vyzw(p,j)*(MSTh(j,jd)^2);
      end;
    
    end;
    MA(p,x) = MA1(p,x)+MA2(p,x);
   
    //sum of variance and covariance between number of microstate in a G.U. in axis and that in substrucutre on that G.U.
    VA(p,x) = VA1(p,x)+VA2(p,x)+2*(1-bu(p)+u(p)*bu(p)*(1-b(p)))*MA2(p,x);
   end;
  
   M1 = matrix(MA(p,:),1,N); //vector os mean of microstate m top down
   V1 = matrix(VA(p,:),1,N); //vector os var  of microstate m top down
   MSTh(p,i) = (M1*matrix(MC(p,:,:),N,N))*I;
   VSTh(p,i) = V1*matrix(MC(p,:,:),N,N)*I+M1*matrix(VC(p,:,:),N,N)*M1';
  
   //terminal structure
   j = st_j(p);
   if i>Nu_Ma(p) & j>=p & j<=maxp then
     jd = i-Nu_Ma(p);
     MSTh(p,i) = MSTh(p,i)+MSTh(j,jd);
     VSTh(p,i) = VSTh(p,i)+VSTh(j,jd);
   end;
  end;  //i
end;//p

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// DISTRIBUTION
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//  MA=max(u)*N;%maximum number of microstates in axis
//  FA=zeros(maxp,N,MA); %distribution of number of microstate in each axis
// 
// for k=0:m %possible number of microstates in axis
//         for j=0:N %possible number of macrostates in i cycles
//             for i=j:N-1 %possible number of cycles to survive
//                 h(k+1)=h(k+1)+(1-c(1))*c(1)^i*binopdf(j,i,b(1))*binopdf(k,j*u(1),bu(1));
//             end
//             h(k+1)=h(k+1)+c(1)^N*binopdf(j,N,b(1))*binopdf(k,j*u(1),bu(1));%boundary
//         end
//     end    
endfunction
