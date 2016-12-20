function [B_S,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V] = gl_sizorg(J,maxp,q_O,q_L,QO,Nb_O,a_aI,a_bI,a_aP,a_bP,N_SI,kp_SI,Th_B,Den_Ff,Den_Fm,Den_I,B_S,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V,Nu_Ma,Nb_BI,DL)


//get size of organs  leaf -- area, pith -- length and section area, fruit -- volume
// what's special is diameter section area of internode =pith + layer
// organ ID:  1 blade, 2 petiel, 3 internode, 4 fruit, 5 layer, 6 root

// at each cycle all the organ change of size because the expansion

for i =  1:J; // i is the age of organ
 for p = 1:maxp;
   // Blade surface area
   B_S(p,i,J) = q_O(1,p,i, J) / Th_B(p);
   // Petiole sizes lenght section
   if q_O(2,p,i, J)>0 then
     P_H(p,i,J) = sqrt(a_bP(p)) * q_O(2,p,i, J) ^ ((1 + a_aP(p)) / 2);
     P_S(p,i,J) =  sqrt(1 / a_bP(p)) * q_O(2,p,i, J) ^ ((1 - a_aP(p)) / 2);
   else
     P_H(p,i,J) = 0;
     P_S(p,i,J) = 0;
   end;
   // Internode sizes lenght section. H/S=a_bI*q^a_aI
   if q_O(3,p,i, J)>0 then
     I_V = q_O(3,p,i, J)/Den_I(p);
     if  (J-i+1<=N_SI) then
        I_H(p,i,J) =  sqrt(a_bI(p)*kp_SI) * I_V ^ ((1 + a_aI(p)*kp_SI) / 2);  //if a_aI(p)=-1, I_H have nothing to do with qi
        IP_S(p,i,J) = sqrt(1 /( a_bI(p)*kp_SI)) * I_V ^ ((1 - a_aI(p)*kp_SI) / 2);
        //I_H(p,i,J) =  sqrt(a_bI(p))*kp_SI * I_V ^ ((1 + a_aI(p)) / 2);  //if a_aI(p)=-1, I_H have nothing to do with qi
        //IP_S(p,i,J) = sqrt(1 / a_bI(p))/kp_SI * I_V ^ ((1 - a_aI(p)) / 2);             
     else //normal case
        I_H(p,i,J) =  sqrt(a_bI(p)) * I_V ^ ((1 + a_aI(p)) / 2);  //if a_aI(p)=-1, I_H have nothing to do with qi
        IP_S(p,i,J) = sqrt(1 / a_bI(p)) * I_V ^ ((1 - a_aI(p)) / 2);     
     end
     
   else
     I_H(p,i,J) = 0;
     IP_S(p,i,J) = 0;
   end;
 
   //layer
   for j = 1:J;
     L_S(p,i,j,J) = q_L(p,i,j,J);
   end;
   //accumulate layer
   for j = i:J;
     LS = 0;
     for k = 0:i-1;
       LS = LS+L_S(p,i-k,j-k,J-k);  //total biomass for layer on G.U. (p,j,i,J)
       //LS = LS+L_S(p,i-k,j-k,J-k)*I_H(p,i-k,J-k);  //total biomass for layer on G.U. (p,j,i,J), considering the height of each GU
     end;     
     if I_H(p,i,J)>0  then
       LS = LS/I_H(p,i,J);
     else
       LS = 0;
     end;  //section area of layer for G.U. appear in cycle J is biomass devided by its length of current growth unit.         
     I_S(p,i,j,J) = IP_S(p,i,J)+LS;  //section area of G.U.       
   end;
   //LS(i:J)=
   //I_S(p,i,i:J,J) = IP_S(p,i,J)+LS(i:J);
   clear("SL");
   //fruit volume
   if i>1 then
     Ff_V(p,i-1,J-1) = q_O(4,p,i, J)/Den_Ff(p);//fruits born in the last cycle get biomass from the current cycle
     Fm_V(p,i-1,J-1) = q_O(5,p,i, J)/Den_Fm(p);
   end;
 end;
end;
endfunction
