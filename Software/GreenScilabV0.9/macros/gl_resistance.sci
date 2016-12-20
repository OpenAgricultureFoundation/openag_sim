function [R_Struct,B_ST] = gl_resistance(J,maxp,R_Struct,B_ST,r_B,r_P,r_R,B_S,Nb_O,Tu_O)

// resistence of plant and leaf area

Rinv = zeros(maxp,J);

for p = 1:maxp;
  for i = 1:J;
    r = 0;
    if B_S(p,i,J)>0 & i<=Tu_O(1,1,p) then // leaf exist and still function         
        r =r_B/B_S(p,i,J)+r_P;
        B_ST(J)=B_ST(J)+B_S(p,i,J)*Nb_O(1,1,i,J,J,p);
    end;
    
    if r>0 then
    
      Rinv(p,J) = Rinv(p,J) +Nb_O(1,1,i,J,J,p)/r;  //sum up leaf appear at same age         
      
    end;
  end;
end;



if sum(Rinv(:,J))>0 then
  R_Struct(1,J)=1/sum(Rinv(:,J));
else
  R_Struct(1,J) = 0;
end;

clear("Rinv");
//root missed
//some leaves are paralell in fact
endfunction
