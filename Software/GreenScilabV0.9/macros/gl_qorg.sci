function [q_O,q_L,QO] = gl_qorg(J,maxp,Q,QO,q_O,q_L,DL,coff_L,Nb_BI,MAT_EX,Nb_O,RingOption,I_H)
                       
//%calculate biomass partition to each kind of organ
//q_O(id, p,i,j):biomass to orang id with p phy age locates at position i in plant with chr age j
// j is the age of plant, i is position of organ from top, also age of the organ
// one is to get the size of organ--Q_O; the other is to know total biomass distribution

//biomass for single organ q_O(id, p,i, J)= q_O(id, p,i, J-1)+MAT_EX(id,p,J,i) * Q(J ,1)
//biomass repartition  QO(id,p,J)=sum(MAT_EX(id,p,J,1:J).*Nb_O(id,p,1:J) * Q(J ,1))
//accumulated biomass distribution  QO_T(id,J)

OrganType=size(Nb_O,1);
// steps: 1 get new biomass for organs. 2 accumulate 

for p = 1:maxp ;
  for id = 1:OrganType;
  
    for i = 1:J; //i is chr_age of organs
     select id
       case 1 then //blade
          if Nb_O(id,1,i,J,J,p)>0 then // organ must exist
             q_O(id, p,i, J) =MAT_EX(id,p,i,J) * Q(J,1 ); //new biomass for organ(id, p,i,) in cycle J--new organ or organ expansion
          end;
          if i>1 then //accumulate, add new biomass to that of previous cycle
             q_O(id,p,i,J) =q_O(id, p,i-1, J-1)+MAT_EX(id,p,i,J) * Q(J,1);
          end;
       case 2 then // petiole
          if Nb_O(id,1,i,J,J,p)>0 then // organ must exist
             q_O(id, p,i, J) =MAT_EX(id,p,i,J) * Q(J,1 ); //new biomass for organ(id, p,i,) in cycle J--new organ or organ expansion
          end;
          if i>1 then //accumulate, add new biomass to that of previous cycle
             q_O(id,p,i,J) =q_O(id, p,i-1, J-1)+MAT_EX(id,p,i,J) * Q(J,1);
          end;
       case 3 then //internode
          if Nb_O(id,1,i,J,J,p)>0 then // organ must exist
             q_O(id, p,i, J) =MAT_EX(id,p,i,J) * Q(J,1 ); //new biomass for organ(id, p,i,) in cycle J--new organ or organ expansion
          end;
          if i>1 then //accumulate, add new biomass to that of previous cycle
             q_O(id,p,i,J) =q_O(id, p,i-1, J-1)+MAT_EX(id,p,i,J) * Q(J,1);
          end;
       case 4 then //female flower, male flower, 
          if i>1 then
             if Nb_O(id,1,i-1,J-1,J-1,p)>0  then // organ must exist                        
                q_O(id,p,i,J) =MAT_EX(id,p,i-1,J-1) * Q(J,1 ); //new biomass in cycle J                  
             end;
             if i>2 then //accumulate                  
                q_O(id,p,i,J) = q_O(id, p,i-1, J-1)+MAT_EX(id,p,i-1,J-1) * Q(J,1 );
             end;
         end;
       case 5 then //female flower, male flower, 
          if i>1 then
             if Nb_O(id,1,i-1,J-1,J-1,p)>0  then // organ must exist in last cycle. They compete the biomass with other organs in current cycle                  
                q_O(id,p,i,J) =MAT_EX(id,p,i-1,J-1) * Q(J,1 ); //new biomass in cycle J                  
             end;
             if i>2 then //accumulate                  
                q_O(id,p,i,J) = q_O(id, p,i-1, J-1)+MAT_EX(id,p,i-1,J-1) * Q(J,1 );
             end;
         end;
       case 6 then //layer,root
          if i>1 then
             q_O(id,p,i,J) = MAT_EX(id,p,i,J) * Q(J,1 );  //new biomass in cycle J    
             if i>2 then //accumulate                  
                q_O(id,p,i,J) = q_O(id, p,i-1, J-1)+MAT_EX(id,p,i,J) * Q(J,1 );
             end;
          end;
       case 7 then //layer,root
          if i>1 then
             q_O(id,p,i,J) = MAT_EX(id,p,i,J) * Q(J,1 );  //new biomass in cycle J    
             if i>2 then //accumulate                  
                q_O(id,p,i,J) = q_O(id, p,i-1, J-1)+MAT_EX(id,p,i,J) * Q(J,1 );
             end;
          end;
     end;
    
    end;
  
    select id
      case 1 then //blade, petiel, internode
         tt1=matrix(MAT_EX(id,p,1:J,J),1,J)
         tt2=matrix(Nb_O(id,1,1:J,J,J,p),1,J);
         QO(id,p,J)=sum(tt1.*tt2) * Q(J,1); 
         
      case 2 then //blade, petiel, internode
         tt1=matrix(MAT_EX(id,p,1:J,J),1,J)
         tt2=matrix(Nb_O(id,1,1:J,J,J,p),1,J);
         QO(id,p,J)=sum(tt1.*tt2) * Q(J,1); 
         
      case 3 then //blade, petiel, internode
         tt1=matrix(MAT_EX(id,p,1:J,J),1,J)
         tt2=matrix(Nb_O(id,1,1:J,J,J,p),1,J);
         QO(id,p,J)=sum(tt1.*tt2) * Q(J,1); 
         
      case 4 then //female flower, male flower,
         if J>1 then
              tt1=matrix(MAT_EX(id,p,1:J-1,J-1),1,J-1);                     
              tt2=matrix(Nb_O(id,1,1:J-1,J-1,J-1,p),1,J-1);                      
              QO(id,p,J)=sum(tt1.*tt2) * Q(J,1);        
         end;
      case 5 then //female flower, male flower,
         if J>1 then
              tt1=matrix(MAT_EX(id,p,1:J-1,J-1),1,J-1);                     
              tt2=matrix(Nb_O(id,1,1:J-1,J-1,J-1,p),1,J-1);                      
              QO(id,p,J)=sum(tt1.*tt2) * Q(J,1);        
         end;
      case 6 then //layer,root
          if J>1 then
             tt1=matrix(MAT_EX(id,p,1:J-1,J-1),1,J-1);                     
             tt2=matrix(Nb_O(id,1,1:J-1,J-1,J-1,p),1,J-1);                      
             QO(id,p,J)=sum(tt1.*tt2) * Q(J,1);        
          end;  
      case 7 then //layer,root
          if J>1 then
             tt1=matrix(MAT_EX(id,p,1:J-1,J-1),1,J-1);                     
             tt2=matrix(Nb_O(id,1,1:J-1,J-1,J-1,p),1,J-1);                      
             QO(id,p,J)=sum(tt1.*tt2) * Q(J,1);        
          end;  
    end;
  end;  //id
end;//p

clear("tt1");
clear("tt2");

if J>1 then //only plant older than 1 can layer exist
  QL = sum(QO(6,:,J));  //total biomass for layer of GUs in last cycle
    
    for p =1:maxp

      for i =  1:J; // i is the age  when the organ is produced, or CA of substructure
      
        if DL(1,J-1,J-1)>0 then
        
         for j = 1:i; //for each GU of CA j
           
           if j>1 then
              if sum(Nb_O(3,1,1:j-1,i-1,J-1,:,:))>0 then
                q_L(p,j,i,J) = coff_L*Nb_BI(p,j-1,i-1,i-1)/DL(1,J-1,J-1)*QL+ (1-coff_L)* QL/sum(Nb_O(3,1,1:j-1,i-1,J-1,:,:));  //biomass for layer of last cycle
              else
                q_L(p,j,i,J) = coff_L*Nb_BI(p,j-1,i-1,i-1)/DL(1,J-1,J-1)*QL;
              end
           end;
         
         end;
         
       end;
       
      end;
      
    end;
end

endfunction

