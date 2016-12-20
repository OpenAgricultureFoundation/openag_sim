function [Nb_O]=gl_organ_axis(p,i,Tu_O,Nu_Ma,Nu_I,Nu_O,nr,StateO,b_o)

//get number of leave on the axis seen by each G.U.
OrganType=size(Tu_O,1);

nr=max(b_o(:))+1;

//Nu_O // 1 leaf, 2 female flower, 3 male flower, 4 branch
Nb_O=zeros(OrganType,i,nr);
for m=1:nr;
    for id=1: OrganType;
        for k=1:i;
            select id
            case 1 then//leaf
                Ne=sum(Nu_I(p,:).*matrix(Nu_O(1,p,:),1,6)); 
     //Ne=sum(Nu_I(p,:).*matrix(Nu_O(1,p,:),1,9));  original  the same as below
                flag= StateO(1,i-k+1,p);       //organ occupied state                                                
            case 2 then//petiel
                Ne=sum(Nu_I(p,:).*matrix(Nu_O(1,p,:),1,6));   
                flag= StateO(1,i-k+1,p);       //organ occupied state                                                            
            case 3 then//internode
                Ne=sum(Nu_I(p,:));
                flag= 1;                    //internode must exist                                                            
            case 4 then//female flower
                Ne=sum(Nu_I(p,:).*matrix(Nu_O(2,p,:),1,6));   
                flag= StateO(2,i-k+1+m,p);       //organ occupied state                                                                        
            case 5 then//male flower
                Ne=sum(Nu_I(p,:).*matrix(Nu_O(3,p,:),1,6));   
                flag= StateO(3,i-k+1+m,p);       //organ occupied state                                                                                    
            case 6 then//layer         
                Ne=1;   
                flag=1;
            case 7 then//root         
                Ne=1;  
                flag=1;
            end;                  
            
            if ((i-k+1>=Tu_O(id,2,p)) & (i-k+1<Tu_O(id,3,p)+Tu_O(id,1,p)-1)  & flag ) then //  
                
                if i <Tu_O(id,1,p) then// a young branch                       
                    if k>(i-Nu_Ma(p,1)) then//inside axis 
                        Nb_O(id,k,m)=Ne;        
                    end;
                end;                 
                
                if Tu_O(id,1,p) <=i & i <Nu_Ma(p,1) then// a normal branch,          
                    if k<=Tu_O(id,1,p)  then          
                        Nb_O(id,k,m)=Ne;            
                    else                                   
                        Nb_O(id,k,m)=0;//Tu_O(1,1)*Ne;                
                    end;                       
                end;                 
                
                if Nu_Ma(p,1)<= i & i <Nu_Ma(p,1)+Tu_O(id,1,p) then// part beyond the bearing axis              
                    if k<= i-Nu_Ma(p,1) //out of bearing axis
                        Nb_O(id,k,m)=0;                             
                    else                          
                        if k<=Tu_O(id,1,p)  then//i-Tu_O(id,1)
                            Nb_O(id,k,m)=Ne;                                                   
                        else
                            Nb_O(id,k,m)=0;//(Nu_Ma(p,1)+Tu_O(1,1)-i)*Ne;                            
                        end;
                    end;
                end;
                
                if i>=Nu_Ma(p,1)+Tu_O(id,1,p) | i-k+1>=Tu_O(id,3,p) then// dead branch or no internode              
                    Nb_O(id,k,m)=0;              
                    
                end;                 
                
                Nb_O(6,k,m)=Ne;//layer always exist
            end;
        end;  //k
    end;   //id
end;  //m

endfunction


