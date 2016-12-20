function [MAT_EX,Demand,q_O,q_L,QO,B_S,B_ST,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V,R_Struct,Q,QSW,QTW,E] =gl_main(Flag_C_code,Flag_Sci_code,N,maxp,t_exp,Bt_N, Bt_p,S_O, N_SI,kp_SI,Nb_O,Tu_O,...
                             Nb_BI,Q0,dQ0,DL,coff_L,RingOption,a_aI,a_aP,Th_B,Den_Ff,Den_Fm,Den_I,a_bI,a_bP,r_B,r_P,r_R,Sp,rp,kp,...
                             QSW,QTW,water_sequence,theta_sequence, light_sequence,Omega, aux_paras, Flag_environment,QSWMAX,QSWMIN,C1,C2,E,Nu_Ma,u,E0, Flag_field)


q_O = zeros(OrganType,maxp,N,N);
q_L = zeros(maxp,N,N,N);

Q = zeros(N+1,1);

// first allocation of biomass from the seed
Q(1,1) = Q0*(1-dQ0);

QO = zeros(OrganType,maxp,N+1);

R_Struct = zeros(1,N);
B_ST= zeros(1,N);

//I_H = [];I_S = [];B_S = [];P_H = [];P_S = [];L_S = zeros(maxp,N,N,N);Ff_V = zeros(maxp,N,N);Fm_V = zeros(maxp,N,N);              
I_H =zeros(maxp,N,N); B_S = zeros(maxp,N,N); P_H = zeros(maxp,N,N); P_S = zeros(maxp,N,N);
L_S = zeros(maxp,N,N,N); I_S = zeros(maxp,N,N,N); 
Ff_V = zeros(maxp,N,N);Fm_V = zeros(maxp,N,N);  

    [MAT_EX,Demand] =gl_demand(N,maxp,t_exp,Bt_N, Bt_p,S_O, N_SI,kp_SI,Nb_O,Tu_O,Nb_BI);
    
    for J = 1:N;
        //if mod (J,5) == 0  fprintf(1,' %g',J);      end 
        
        //%weight and size of organs  
        if Flag_Sci_code == 1 then
          //scilab code
          [q_O,q_L,QO]= gl_qorg(J,maxp,Q,QO,q_O,q_L,DL,coff_L,Nb_BI,MAT_EX,Nb_O,RingOption,I_H); 
          //%size of organs
          //scilab code
          [B_S,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V]= gl_sizorg(J,maxp,q_O,q_L,QO,Nb_O,a_aI,a_bI,a_aP,a_bP,N_SI,kp_SI,Th_B,Den_Ff,Den_Fm,Den_I,B_S,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V,Nu_Ma,Nb_BI,DL);
        end;
       
        if Flag_C_code == 1 then
        //call c function
        //[q_O,q_L,QO] = qorg(J,maxp,coff_L,Q,Nb_O,MAT_EX,Nb_BI,DL,q_O,q_L,QO);
        // for "qorg" , use SCILAB code
        [q_O,q_L,QO]= gl_qorg(J,maxp,Q,QO,q_O,q_L,DL,coff_L,Nb_BI,MAT_EX,Nb_O,RingOption,I_H); 
        
        //call c function        
        [B_S,P_H,P_S,I_H,Ff_V,Fm_V,L_S,I_S] = sizorg(J,maxp,Den_I,Den_Ff,Den_Fm,a_aI,a_bI,a_aP,a_bP,Th_B,q_O,q_L,B_S,P_H,P_S,I_H,Ff_V,Fm_V,L_S,I_S,N_SI,kp_SI);
        end;
                                    
        //% hydraulic resistances *
        [R_Struct,B_ST] = gl_resistance(J,maxp,R_Struct,B_ST,r_B,r_P,r_R,B_S,Nb_O,Tu_O); // resistance of the leaves     
        
        //% biomass production at each cycle= seed contribution + photosynthesis*
        //%[Q,QS,E]=gl_photosynthsis(J,dQ0,Q0, Q,QS,QT,DH,QMAX,QMIN,c1,c2,E0,E,R_Struct,Flag_climate) ;           
         
        // Environment effects
        if mtlb_any(Flag_environment) then
            //if Flag_sumt    % environmental daily sequence data
            //else            % environmental growth cycle sequence data
                //E(J) = feval(QSW(J), theta_sequence(J), light_sequence(J), Omega, aux_paras, Flag_environment,fun);

                E(J) = env_fun(J,QSW, theta_sequence, light_sequence, Omega, aux_paras, Flag_environment);
            //end
        else 
            E(J) = E0;
        end        
        // biomass production at each cycle= seed contribution + photosynthesis*
        Flag_climate=Flag_environment(1);// it is the water level
        
        [Q,QSW,QTW]=gl_photosynthsis(J,dQ0,Q0, Q,QSW,QTW,water_sequence,QSWMAX,QSWMIN,C1,C2,E,R_Struct,B_ST,Flag_climate,N,maxp,Nu_Ma,u,Nb_O,I_H,B_S,r_B,r_P,Sp,rp,kp,Tu_O, Flag_field);
        
    end; //  J = 1:N  end of loop of Plant Growth on N cycle
    
 endfunction
