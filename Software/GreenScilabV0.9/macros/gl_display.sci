function [] = gl_display(MTh,VTh,MSTh,VSTh,MSim,VSim,MSSim,VSSim,Tr,S)

// Display mode
mode(-1);

// Display warning for floating point exception
//ieee(1);


N = size(MSim,1);maxp = size(MSim,2);

//%%%%%%%%%%%%%%%%%%%%%%%display mean and covariance %%%%%%%%%%%%%%%%%%%%%%%%%%%%
printf("-------------    stochastic structure  simulation --------------\n");
printf("\n");
printf("substruture sample size:");
for p = 1:maxp
  printf("%4d  ",Tr(p));
end;
z = zeros(1,maxp);
for p = 1:maxp
  if VTh(1,p,N)>0 then
    z(p)=(MSim(N,p)-MTh(1,p,N))*sqrt(Tr(1))/sqrt(VTh(1,p,N));
  else
    z(p)=0;
  end;
end;

printf("\n");
printf("                  MSim          VSim          MTh          VTh             z\n");
for p = 1:maxp
  printf("Phy age %d :  ",p);
  printf(" %8.3f    %8.3f     ",MSim(N,p),VSim(N,p));
  printf(" %8.3f    %8.3f     ",MTh(1,p,N),VTh(1,p,N));
  printf("   %8.3f    \n",z(p));
end;
printf("TOTAL     :   %8.3f    %8.3f      %8.3f    %8.3f\n",MSSim(N),VSSim(N),MSTh(1,N),VSTh(1,N));

M = MSTh(1,N);V = VSTh(1,N);V = sqrt(V);
Flag_distribution = 0;
if Flag_distribution==1 then
  //approximate with a normal distribution
  tmp = zeros(N,maxp);
  tmp = matrix(S(1,:,N,:,1),N,maxp);
  tmp1 = sum(tmp,1);
  Nm = ceil(M);
  if V>0 then
    //Nm=ceil(M+4*sqrt(V));
    Nm = sum(tmp1);
  end;

  
  
  f = zeros(1,Nm(1));
  for j = 0:Nm
    if V>0 then
      f(1,j+1) = (1/sqrt(2*%pi*V))*exp(-(1/2)*((j-M)/V)^2);
    else
      f(1,M) = 1;
    end;
  end;
  f = f/sum(f);  //normalize
  k = 0:Nm;
  plot(k,f,"r");  h = gce();
  %set(mtlb(h),"LineWidth",2);
  M1 = 0;  M2 = 0;
  for k = 0:Nm
    M1 = M1+(k+1)*f(k+1);
    M2 = M2+((k+1)^2)*f(k+1);
  end;
  V1 = M2-M1^2;
  printf("M1=%8.2f,V1=%8.2f\n",M1,V1);
  legend(["Simulation","Normal distribution"])
  //title('P_m=2,M_a=[10 10],T=[250 250],p_a=[.9 .8],p_b=[1 .8],p_c=[0.95 0.9],p_i=[0.8 0.7]')     
end;
endfunction
