function [theta] = Draw_bending(p,L0,h0,Ey,InitAngle,fp,End_Ang,End_N,InitNum)

// Ouput variables initialisation (not found in input variables)
theta=[];


//------------------------ calculate bending angal theta -------------------------%

Init = InitAngle;//第一个生长单元离Z轴的角度
h=ceil(fp(p)*h0);
theta=zeros(1,L0);
I = (%pi*((1/2)^4))/4;
K = sqrt(0.35./(Ey(:,1)*I));
dx = 1;//每个单元的长度                

at = 0.1744;// accuracy angle for the bending angle=10
if Init>0 then
  
  x = K(p,1)*h*sqrt(abs(cos(Init))); //abs is added in case multiple initial angles. 2006/05/08. QR, MZ
  
  w=  sin(Init)*(1-cos(x))/(cos(Init)*cos(x));  // matlab can do cos(Init) <0!  
 
  if (K(p,1)*h*sqrt(abs(cos(Init)))*2/%pi >0.8 | abs(w)> .80 | w < 0 ) then // .80 = 45*%pi/180     
  
   a = 0; b = %pi -Init;
   while ( b -a > at ) 
     w = (a+b)/2;  tt = 0;  s = 0;  x = 1;  //I_H(i,p);                  
     while (tt < w & x ~= 0)
       dt =  dx*sqrt(2)* K(p,1) * sqrt((abs(cos(Init+tt)-cos(Init+w))));
       tt = tt + dt;  x =  x + dx;
     end;
     if x < h then
       a = w;
     else
       b = w;
     end;
   end;
   w =  (a+b)/2;
  end;  //计算最后一个生长单元离Z轴的角度W          
else
  w = 0;  //Init<0    
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%% calculate total bending angal W %%%%%%%%%%%%%%%%%%%%%


//L0: last G.U.
//Lf: force point
//Le: ending point
tt = 0;

te = End_Ang;//the angle of last G.U.
if h0>0 then
  Le = ceil(End_N*L0/h0);  //number of ending up cycle
else
  Le = 0;
end;


Lf = ceil(fp(p)*L0);

theta(1,1) = Init;

if L0<=Le then // ending point do not function
 if L0>1 then
   dt =(te-Init)/(L0-1);
   for j = 2:L0 ;
     //         theta(j)=Init+dt*(j-1);            
     if tt<w  then
       tt = tt+ K(p,1)*sqrt(2*(cos(tt+Init)-cos(w+Init)))*dx;
     end;
     theta(j)=Init+tt;  //每个生长单元离Z轴的角度                                    
   end;
 end;

else // ending point do influence
 Lb=L0-Le; //left of ending point      
 if Lf<Lb then //force point in the left part       
  //part 1-Lf
  for j = 2:Lf-1 ;
    if tt<w then
      tt = tt+ K(p,1)*sqrt(2*(cos(tt+Init)-cos(w+Init)))*dx;
    end;
    theta(j) = Init+tt;  //每个生长单元离Z轴的角度                  
  end;
  //part Lf-Lb
  for j = Lf:Lb;
    if tt+Init>0 then
      tt = tt- K(p,1)*sqrt(2*(abs(cos(tt+Init)-cos(w+Init))))*dx;
    end;
    theta(j) =Init+tt;
  end;
  //part Lb-L0
  if Le>0 then
    dt = (te-theta(Lb))/Le;
  else
    dt = 0;
  end;
  for j = Lb+1:L0;
    theta(j)=theta(j-1)+dt;
  end;
 else // %force point in the right part of ending point         
  //part 1:Lb
  for j = 2:Lb;
    if tt<w  then
      tt = tt+ K(p,1)*sqrt(2*(cos(tt+Init)-cos(w+Init)))*dx;
    end;
    theta(j)=Init+tt;  //每个生长单元离Z轴的角度                  
  end;
  //part Lb+1:L0
  if Le>0 then
    dt=(te-theta(Lb))/Le;
  else
    dt = 0;
  end;
  for j = Lb+1:L0 ;
    if j==1 then
      theta(j)=Init;
    else
      theta(j)=theta(j-1)+dt;
    end;
  end;
 end;
end;

// if initial angle is only one, make the initial angle 0
if InitNum==1 then
  theta(:) = theta(:)-Init;
end;

//------------------------ calculate bending angal theta -------------------------%
endfunction
