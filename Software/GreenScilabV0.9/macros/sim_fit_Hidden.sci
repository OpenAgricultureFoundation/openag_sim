function [Y] = sim_fit_Hidden(x)
//
//   greenlab simulator for parameter estimization
//
//   Y       -   Target data
//   x       -   Hidden parameters
//   KANG MengZhen, 2006.11

exec('bin/glob_declare.sci');

sump=0;//current parameter

x_t_exp=t_exp;
for a=1:length(t_exp_i)
    sump=sump+1;
    x_t_exp(t_exp_i(a))=x(sump);    
end

x_Bt_N=Bt_N;
for a=1:length(Bt_N_i)
    sump=sump+1;
    x_Bt_N(Bt_N_i(a))=x(sump);    
end

x_Bt_p=Bt_p;
for a=1:length(Bt_p_i)
    sump=sump+1;
    x_Bt_p(Bt_p_i(a))=x(sump);    
end

x_S_O=S_O;
for a=1:length(S_O_i)
    sump=sump+1;
    x_S_O(S_O_i(a),S_O_j(a))=x(sump);    
end
for p=2:maxp
    x_S_O(1:OrganType,p)= x_S_O(1:OrganType,1).*x_S_O(1:OrganType,p);
end

x_r_B=r_B;
if C_r_B==1 then
    sump=sump+1; 
    x_r_B=x(sump);   
end
x_r_P=r_P;
if C_r_P==1 then
    sump=sump+1; 
    x_r_P=x(sump);   
end

x_Sp=Sp;
if C_Sp==1 then
    sump=sump+1; 
    x_Sp=x(sump);   
end
x_rp=rp;
if C_rp==1 then
    sump=sump+1; 
    x_rp=x(sump);   
end
x_kp=kp;
if C_kp==1 then
    sump=sump+1; 
    x_kp=x(sump);   
end


x_Q0=Q0;
if C_Q0==1 then
    sump=sump+1; 
    x_Q0=x(sump);   
end

Y=[]; //target computed in each reiteration

for h=1:NumPlt //for each plant
    
  Q=zeros(N0(h)+1,1);
  
  // first allocation of biomass from the seed
  Q(1,1) = x_Q0 * (1 - dQ0);        
  
  //for i=1:Tr(h) //for each stage//since for now all measurements are destructive, there is no multi-stage
      
    age=CASample(h);//age of the sample plant              
    
    //    compute share of biomass and demand                                         
    [MAT_EX,Demand,q_O,q_L,QO,B_S,B_ST,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V,R_Struct,Q,QSW,QTW,E] =gl_main(Flag_C_code,Flag_Sci_code,age,maxp,x_t_exp,x_Bt_N, x_Bt_p,x_S_O,N_SI,kp_SI,Nb_O,Tu_O,...
                         Nb_BI,x_Q0,dQ0,DL,coff_L,RingOption,a_aI,a_aP,Th_B,Den_Ff,Den_Fm,Den_I,a_bI,a_bP,x_r_B,x_r_P,r_R,x_Sp,x_rp,x_kp,...
                         QSW,QTW,water_sequence,theta_sequence, light_sequence,Omega, aux_paras, Flag_environment,QSWMAX,QSWMIN,C1,C2,E,Nu_Ma,u,E0,Flag_field);
    
                        
    // organ ID:  1 blade, 2 petiel, 3 internode, 4 female flower,  5 male flower, 6 blade area, 7 internode area, 8 internode length        
    TargetType=8;
    
    for typ=1:TargetType
    
       for p=1:maxp                   
         //GUend=min(age,Nu_Ma(p));
         //len=min(age,Nu_Ma(p));
         
         len=min(age,Nu_Ma(p))-PosLowestGU(1,p)+1;//number of GU in the axis of PA p             
         Pos=PosLowestGU(1,p):min(age,Nu_Ma(p));
         CA_O=age-PosLowestGU(1,p)+1:-1:age-min(age,Nu_Ma(p))+1;//the CA of the organs from bottom to up
                                   
         select LoDSample(h,p)
         case 0  //detailed data             
         
         if C_Tar(typ,p)==1 then //if this type of organ is to be fit
           select typ
           case 1 then //blade
              data=matrix(q_O(1, p,CA_O, age),1,len);
           case 2 then //petiole
              data=matrix(q_O(2, p,CA_O, age),1,len);
           case 3 then //internode weight, to be improved                                    
              data=[];
              for CA_0=age-PosLowestGU(1,p)+1:-1:age-min(age,Nu_Ma(p))+1
              //for CA_0=age:-1:age-len+1
                QL=0;//weight of layer in this GU
                for k=0:CA_0-1
                  QL=QL+q_L(1,CA_0-k,age-k,age-k);
                end
                tmp=q_O(3, p,CA_0,age)+QL;
                data=[data tmp];
              end
                                
           case 4 then //female
              data=matrix(q_O(4, p,CA_O, age),1,len);
           case 5 then //male
              data=matrix(q_O(5, p,CA_O, age),1,len);
           case 6 then //blade area
              data=matrix(B_S( p,CA_O, age),1,len);
           case 7 then //internode area
              data=matrix(I_H(p,CA_O, age),1,len);
           case 8 then //Internode length
              data=matrix(I_S(p,CA_O, age, age),1,len);
           end//select typ
           Y=[Y data];

         end             
         
         case 1 //compartment data
         if C_Tar(typ,p)==1 then //if this type of organ is to be fit
           select typ
           case 1 then //blade
             no=matrix(Nb_O(1,1,CA_O,age,age,p),1,length(Pos));
             qo=matrix( q_O(1,1,CA_O,age),1,length(Pos));
             data=sum(no.*qo);

           case 2 then //petiole
             no=matrix(Nb_O(2,1,CA_O,age,age,p),1,length(Pos));
             qo=matrix( q_O(2,1,CA_O,age),1,length(Pos));
             data=sum(no.*qo);
             
           case 3 then //internode weight, to be improved   
            no=matrix(Nb_O(3,1,CA_O,age,age,p),1,length(Pos));
            qo=[];
            for CA_I=age:-1:age-min(Nu_Ma(p),age)+1
              QL=0;
              for k=0:CA_I-1
                QL=QL+q_L(1,CA_I-k,age-k,age-k);
              end
              qo=[qo q_O(3, 1,CA_I, age)+QL];
            end
             data=sum(no.*qo);
             
                                
           case 4 then //female
             no=matrix(Nb_O(4,1,CA_O,age,age,p),1,length(Pos));
             qo=matrix( q_O(4,1,CA_O,age),1,length(Pos));
             data=sum(no.*qo);

           case 5 then //male
             no=matrix(Nb_O(5,1,CA_O,age,age,p),1,length(Pos));
             qo=matrix( q_O(5,1,CA_O,age),1,length(Pos));
             data=sum(no.*qo);

           case 6 then //blade area
              //data=matrix(B_S( p,CA_O, age),1,len);
           case 7 then //internode area
              //data=matrix(I_H(p,CA_O, age),1,len);
           case 8 then //Internode length
              //data=matrix(I_S(p,CA_O, age, age),1,len);
           end//select typ
           Y=[Y data];
         end             
         
       end
    end
  //end
 end 
end



endfunction
