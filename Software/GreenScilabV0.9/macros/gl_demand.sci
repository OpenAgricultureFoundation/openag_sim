function [MAT_EX,Demand] = gl_demand(N,maxp,t_exp,Bt_N,Bt_p,S_O, N_SI,kp_SI,Nb_O,Tu_O,Nb_BI)


// Ouput variables initialisation (not found in input variables)
MAT_EX=[];
Demand=[];


// get demand of organs and share of each

// organ ID:  1 blade, 2 petiel, 3 internode, 4 male flower,  5 female flower, 6 layer, 7 root

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// compute expansion laws of organs 
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OrganType=size(Tu_O,1);

[EX_O,EX_OT] = gl_expan(N,t_exp,Bt_N,Bt_p);
MAT_EX=zeros(OrganType,maxp,N,N);
Demand=zeros(1,N);
for i = 1:N ; //plant age
 for j = 1:i; //age of organ
  for p = 1:maxp ;
    for id = 1:OrganType;
      select id
        case 1 then //blade

           if j<=Tu_O(id,1,p) & Nb_O(id,1,j,i,i,p)>0 then
                 MAT_EX(id,p,j,i) = EX_O(id,j)*S_O(id,p); 
                Demand(1,i) = Demand(1,i)+MAT_EX(id,p,j,i)*Nb_O(id,1,j,i,i,p);
           end;
        case 2 then //petiole
           if j<=Tu_O(id,1,p) & Nb_O(id,1,j,i,i,p)>0 then
                 MAT_EX(id,p,j,i) = EX_O(id,j)*S_O(id,p); 
                Demand(1,i) = Demand(1,i)+MAT_EX(id,p,j,i)*Nb_O(id,1,j,i,i,p);
           end;
        case 3 then //internode
           if j<=Tu_O(id,1,p) & Nb_O(id,1,j,i,i,p)>0 then
                //for wheat, rice, maize...
                if  (i-j+1<=N_SI) then
                  MAT_EX(id,p,j,i)=EX_O(id,j)*S_O(id,p)*kp_SI;
                else
                  MAT_EX(id,p,j,i) = EX_O(id,j)*S_O(id,p); 
                end                
                Demand(1,i) = Demand(1,i)+MAT_EX(id,p,j,i)*Nb_O(id,1,j,i,i,p);
           end;
        case 4 then //female organ
           if j>1 then
             if j-1<=Tu_O(id,1,p) & Nb_O(id,1,j-1,i-1,i-1,p)>0  then
                 MAT_EX(id,p,j-1,i-1) = EX_O(id,j-1)*S_O(id,p);
                 Demand(1,i)=Demand(1,i)+MAT_EX(id,p,j-1,i-1)*Nb_O(id,1,j-1,i-1,i-1,p);                                         
            end;
           end;
        case 5 then //male organ
           if j>1 then
             if j-1<=Tu_O(id,1,p) & Nb_O(id,1,j-1,i-1,i-1,p)>0  then
                 MAT_EX(id,p,j-1,i-1) = EX_O(id,j-1)*S_O(id,p);
                 Demand(1,i)=Demand(1,i)+MAT_EX(id,p,j-1,i-1)*Nb_O(id,1,j-1,i-1,i-1,p);                                         
            end;
           end;
        case 6 then //layer, root
           if j>1 & i>1 then
             MAT_EX(id,p,j-1,i-1) = S_O(id,p);
             Demand(1,i) = Demand(1,i)+S_O(id,p)*Nb_O(id,1,j-1,i-1,i-1,p);  //number of layer(living leaves in last cycle)   
           end;
        case 7 then //layer, root
           if j>1 & i>1 then
             MAT_EX(id,p,j-1,i-1) = S_O(id,p);
             Demand(1,i) = Demand(1,i)+S_O(id,p)*Nb_O(id,1,j-1,i-1,i-1,p);     
           end;
      end;
    end;
  end;
 end;
end;

for i = 1:N;
  for id = 1:OrganType;
    select id
      case 1 then //leaf, internode            
         if Demand(1,i)>0 then
            MAT_EX(id,:,:,i) = MAT_EX(id,:,:,i)/Demand(1,i);
         else
            MAT_EX(id,:,:,i) = 0;
         end;
      case 2 then //leaf, internode            
         if Demand(1,i)>0 then
            MAT_EX(id,:,:,i) = MAT_EX(id,:,:,i)/Demand(1,i);
         else
            MAT_EX(id,:,:,i) = 0;
         end;
      case 3 then //leaf, internode            
         if Demand(1,i)>0 then
            MAT_EX(id,:,:,i) = MAT_EX(id,:,:,i)/Demand(1,i);
         else
            MAT_EX(id,:,:,i) = 0;
         end;
      case 4 then //fruits
         if Demand(1,i)>0 then
            if i>1 then
               MAT_EX(id,:,1:i-1,i-1) = MAT_EX(id,:,1:i-1,i-1)/Demand(1,i);
            end;
         else
            MAT_EX(id,:,:,i) = 0;
         end;
      case 5 then //fruits
         if Demand(1,i)>0 then
            if i>1 then
               MAT_EX(id,:,1:i-1,i-1) = MAT_EX(id,:,1:i-1,i-1)/Demand(1,i);
            end;
         else
            MAT_EX(id,:,:,i) = 0;
         end;
      case 6 then //layer, root            
        if Demand(1,i)>0 then
          if i>1 then
             MAT_EX(id,:,1:i-1,i-1) = MAT_EX(id,:,1:i-1,i-1)/Demand(1,i);
         end;
        else
           MAT_EX(id,:,:,i) = 0;
        end;
      case 7 then //layer, root            
        if Demand(1,i)>0 then
          if i>1 then
             MAT_EX(id,:,1:i-1,i-1) = MAT_EX(id,:,1:i-1,i-1)/Demand(1,i);
         end;
        else
           MAT_EX(id,:,:,i) = 0;
        end;
    end;
  end;
end;
endfunction
