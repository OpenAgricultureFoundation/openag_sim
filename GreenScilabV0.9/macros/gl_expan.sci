function [EX_O,EX_OT] = gl_expan(N,t_exp,Bt_N,Bt_p,OrganType)

// Ouput variables initialisation (not found in input variables)
EX_O=[];
EX_OT=[];


//EX_O: BETA LAW  EX_OT: accumulated beta law
// organ id:  1 blade, 2 petiel, 3 internode, 4 fruit, 5 layer, 6 root

OrganType=size(t_exp,1);

EX_O = zeros(OrganType,N);
EX_OT=zeros(OrganType,N);

for id = 1:OrganType;
  S = 0;  q = 0;
  for i = 1:t_exp(id)
    //EX_O(id,i) = ((((i-0.5)/mtlb_double(mtlb_e(t_exp,id)))^mtlb_s(mtlb_a(1,mtlb_double(mtlb_e(Bt_N,id)))*mtlb_double(mtlb_e(Bt_p,id)),1))*(mtlb_s(1,(i-0.5)/mtlb_double(mtlb_e(t_exp,id)))^mtlb_s(mtlb_a(1,mtlb_double(mtlb_e(Bt_N,id)))*mtlb_s(1,mtlb_double(mtlb_e(Bt_p,id))),1)))*(1/mtlb_double(mtlb_e(t_exp,id)));
    //EX_O(id,i) = ((i-0.5) / t_exp(id)) ^ ( (1+Bt_N(id) ) * Bt_p(id) - 1) * (1 - (i-0.5) / t_exp(id) ) ^ ((1+ Bt_N(id) )*(1-Bt_p(id))- 1) * (1 / t_exp(id));
    EX_O(id,i) = ((i-0.5) / t_exp(id)) ^ ( Bt_N(id) - 1) * (1 - (i-0.5) / t_exp(id) ) ^ (Bt_p(id)- 1) * (1 / t_exp(id));
//    S = S + EX_O(id,i);
  end;
  S = max(EX_O(id,:));

  // computing classes and comulating function
  for i =  1:t_exp(id) ;
    EX_O(id,i) = EX_O(id,i)/S;
    q = q + EX_O(id,i);
    EX_OT(id,i) = q;
  end;

end;

//id = 3;
//i = mtlb_imp(1,mtlb_double(N));
//figure
//plot(i,EX_O(id,:));
//xlabel('Chronological age of internode');ylabel('Growth rate');title('Expansion law of internode')
clear("OrganType");
endfunction
