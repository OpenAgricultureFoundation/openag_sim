function [Q,QS,QT] = gl_photosynthsis(J,dQ0,Q0,Q,QS,QT,DH,QMAX,QMIN,c1,c2,E,R_Struct,B_ST,Flag_climate,N,maxp,Nu_Ma,u,Nb_O,I_H,B_S,r_B,r_P,Sp,rp,kp,Tu_O, Flag_field)


d_Q0(J,1) = Q0 * (1 - dQ0)*dQ0^J;

if Flag_field==0 then //single plant

    if R_Struct(J)==0 then
       Q(J+1) = d_Q0(J,1);
    else
       Q(J+1) = d_Q0(J,1) + E(J) / R_Struct(J);
    end;
else

    if kp>0 then
    
    
        Q(J+1) = d_Q0(J,1) + E(J)*Sp/(rp * kp) * (1 - exp(-kp/Sp * B_ST(J)));     // Beer Law, QI RUI 2006 01
        //Q(J+1) = d_Q0(J,1) + E*10000/(r_B * r_P) * (1 - exp(-r_P/Sp * B_ST(J)));     // Beer Law, QI RUI 2006 01
    
    else
        Q(J+1) = d_Q0(J,1) + E(J) * B_ST(J)/rp; //similar to individual plant
    end
 
end;

if Flag_climate==1 then
    if Q(J+1)>QT(J) then                 
        Q(J+1)=QT(J);// Plant biomass increase canot be more water supplt         
    end;      
    QS(J+1)=QS(J)*(1-c1-c2*DH(J))+QMIN*c1+QMAX*c2*DH(J);       
    QT(J+1)=QT(J)*(1-c1-c2*DH(J))+QMIN*c1+QMAX*c2*DH(J);                         
    QS(J+1)=QS(J+1)-Q(J+1);               
    if QS(J+1)>QMAX then        
        QS(J+1)=QMAX;         
    end;      
    if QS(J+1)<QMIN then        
        QS(J+1)=QMIN;         
    end;      
    if QT(J+1)>QMAX then
        QT(J+1)=QMAX;
    end;
    if QT(J+1)<QMIN then
        QT(J+1)=QMIN;
    end;
end;

endfunction
