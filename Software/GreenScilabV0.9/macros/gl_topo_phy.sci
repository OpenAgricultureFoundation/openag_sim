function [S,Nb_O,Nb_BI,DL] = gl_topo_phy(N,maxp,Nu_Ma,Nu_I,Nu_O,st_j,b_o,br_a,re_a,rs_A,rs_B,rt_a,T_Pr,Tu_O,Flag_pruning,Pruning_delay,RingOption)
//to get number of new growth unit,organs in each cycle. 

S = zeros(maxp,N,N,N,maxp,nr);

Nb_BI = zeros(maxp,N,N,N,nr);//Number of living leaves above each G.U.

DL = zeros(maxp,N,N,nr);//demand of layer, case that amount of layer for a GU is proportional to the number of living leaves above it

DL_0 = zeros(maxp,N,N,nr);//demand of layer, case of a homogeneous layer provided by a single leaf


OrganType = size(Tu_O,1);

//number of living organs in plant --internode, leaves, fruit and layer in each cycle 
//temp=OrganType*maxp*N*N*N*maxp*nr
 // printf("length= %4d ",temp);
 //stacksize(1.5*length)
Nb_O = zeros(OrganType,maxp,N,N,N,maxp,nr);

nr=max(b_o(:))+1;


NM = zeros(1,maxp);//maximum number of G.U. in an axis p
NM = Nu_Ma';
for p = maxp:-1:1;
  if (st_j(p)>p) & (st_j(p) <=maxp) then
    st_b = st_j(p);
    NM(p)=NM(p)+NM(st_b);
  end;
end;      

////////////////////NM(1) stand for the total number of GU
////////////////////////   QIRUI     ////////////////////////////////////


StateO = Gl_StateOccupy(Tu_O);


u = sum(Nu_I,2);

//##################################
//printf("Topological computation with physiological age: ");
//###################################

for p = maxp:-1:1;
  //printf(" %4d ",p);

  for i = 1:N;
  
    No = gl_organ_axis_ori(p,i,Tu_O,Nu_Ma,Nu_I,Nu_O,nr,StateO,b_o);


    for j = 1:i;
      //number of seen by G.U. j
      for m = 1:nr;
        for id = 1:OrganType;
          Nb_O(id,p,1:j,j,i,p,m) = No(id,1:j,m);
   
        end;
        Nb_BI(p,1:j,j,i,m) = cumsum(Nb_O(1,p,1:j,j,i,p,m));
      end;

      tmpDL = zeros(nr,1);
    
      if i<=Nu_Ma(p,1)  then //yound axis, no terminal structure                 
       S(p,1:j,j,i,p,1:nr) = 1; //j
      else
        if j>i-Nu_Ma(p,1) then //in axis part only
         S(p,i-Nu_Ma(p,1)+1:j,j,i,p,1:nr) = 1; //(j-i+Nu_Ma(p,1));
        end;
        b = st_j(p);
        if b>=p & b<=maxp  then
          jd =min(j,i-Nu_Ma(p,1));
          if jd>0   then
            S(p,:,j,i,:,1:nr)=S(p,:,j,i,:,1:nr)+S(b,:,jd,jd,:,1:nr);
            Nb_O(:,p,:,j,i,:,1:nr)=Nb_O(:,p,:,j,i,:,1:nr)+Nb_O(:,b,:,jd,jd,:,1:nr); 
            for m = 1:nr;
              if j-( i-Nu_Ma(p,1)+1)>0 then
                 Nb_BI(p,i-Nu_Ma(p,1)+1:j,j,i,m) = Nb_BI(p,i-Nu_Ma(p,1)+1:j,j,i,m)+Nb_BI(b,jd,jd,jd,m);
              end;
            end;
            DL(p,j,i,1:nr)=DL(p,j,i,1:nr)+DL(b,jd,jd,1:nr);  
          end;
        end;
      
      end;
    
      for k=max(1,i-Nu_Ma(p,1)+1):j; //lateral structure from top to bottom
       for b = p+1:maxp ;
       
                    if br_a(p)==0 then
                        rs_n=round(rs_A(b,1)+rs_B(b,1)*(k-max(1,i-Nu_Ma(p,1)+1)));//delayed cycle of branch
                    else
                        rs_n=round((rs_B(b,1)-1)*(k-max(1,i-Nu_Ma(p,1)+1)));//delayed cycle of infloresence , MZ 2005.8
                        pos=Nu_Ma(p)-(k-max(1,i-Nu_Ma(p,1)+1));
                        if pos< (Nu_Ma(p)-Nu_Ma(b)) then
                            rs_n=rs_n+(Nu_Ma(p)-Nu_Ma(b))-pos;
                        end
                        if rs_n<0 then
                            rs_n=rs_A(b,1)+0;
                        else
                            rs_n=rs_A(b,1)+rs_n;
                        end
                      
                    end
       
                     jd=floor((k-1-rs_n)*rt_a(b,1));//the ch_age of the upper part of substructure     
                    
                    np=k-1+NM(p)-j;
                    
                    if NM(b)>np  & br_a(p)==1 then
                        nb=floor((i+NM(b)-NM(p)-rs_n)*rt_a(b,1));//CA of substructure. 
                    else
                        nb=jd;
                    end

         flag = (Flag_pruning(b)~=1) | (nb<=Nu_Ma(b)+Pruning_delay(b)) ;  //not prunned, for anne-laure output                          
         flag = flag & StateO(4,j-k+1,p); //organ occupied state                                                
         if jd>0  & nb>0  & flag   then
           S(p,1:jd,j,i,b:maxp,1:nr)=S(p,1:jd,j,i,b:maxp,1:nr)+Nu_I(p,b)*Nu_O(4,p,b)*S(b,1:jd,jd,nb,b:maxp,1:nr);// add number of internode in lateral substructures                                           
           Nb_O(:,p,1:jd,j,i,b:maxp,1:nr)=Nb_O(:,p,1:jd,j,i,b:maxp,1:nr)+Nu_I(p,b)*Nu_O(4,p,b)*Nb_O(:,b,1:jd,jd,nb,b:maxp,1:nr);//add number of internode in lateral substructures                            
           for jk=max(1,i-Nu_Ma(p,1)):jd; //branches above k
            np=jk+NM(p)-j;
            if NM(b)>np  & br_a(p)==1 then
              nb=i+NM(b)-NM(p);
            else
              nb = jk;
            end;
            Nb_BI(p,k,j,i,1:nr)=Nb_BI(p,k,j,i,1:nr)+Nu_I(p,b)*Nu_O(4,p,b)*Nb_BI(b,jk,jk,nb,1:nr);                                                                                 
           end;
           for m = mtlb_imp(1,nr);
             tmpDL(m)=tmpDL(m)+Nu_I(p,b)*Nu_O(4,p,b)*DL(b,jd,jd,m);  
           end;
         end;
       end;
      end;
    
      if b_o(p)>0 & Nu_I(p,p)*Nu_O(4,p,p)>0  then //reiteration             
       for k = max(1,i-Nu_Ma(p,1)+1):j;
         for m = 1:b_o(p); //reiteration order  
           rs_n=round(rs_A(p,1)+rs_B(p,1)*(k-max(1,i-Nu_Ma(p,1))-1));
           jd=floor((k-1-rs_n)*rt_a(p,1));//the ch_age of substructure  
            np=jd+NM(p)-j;
          if NM(p)>np  & re_a(p)==1 then
            nb=i+NM(p)-NM(p);
          else
            nb = jd;
          end;
          //flag=(Flag_pruning(p)~=1) | (jd<=T_Pr(p)+Pruning_delay(p)) ;%not prunned   
          flag=(Flag_pruning(p)~=1) | (jd<=Nu_Ma(p)+Pruning_delay(p)) ;//not prunned                            
          flag=flag & StateO(4,j-k+1,p);       //organ occupied state                                                                        
          if jd>0  & nb>0  & flag  then
            S(p,1:jd,j,i,p:maxp,m)=S(p,1:jd,j,i,p:maxp,m)+Nu_I(p,p)*Nu_O(4,p,p)*S(p,1:jd,jd,nb,p:maxp,m+1);// add number of internode in lateral substructures                       
            Nb_O(:,p,1:jd,j,i,p:maxp,m)=Nb_O(:,p,1:jd,j,i,p:maxp,m)+Nu_I(p,p)*Nu_O(4,p,p)*Nb_O(:,p,1:jd,jd,nb,p:maxp,m+1);// add number of internode in lateral substructures                                            
                      
            //Nb_BI(p,k,j,i,m)=Nb_BI(p,k,j,i,m)+Nu_I(p,p)*Nu_O(4,p,p)*sum(Nb_BI(p,max(1,i-Nu_Ma(p,1)):jd,jd,jd,m+1)); %results are wrong . Mengzhen 2004.06
            for jk=max(1,i-Nu_Ma(p,1)):jd; //branches above k
          
             np=jk+NM(p)-j;
             
             if  NM(p)>np  & re_a(p)==1 then
               nb=i+NM(p)-NM(p);
             else
               nb = jk;
             end;
             Nb_BI(p,k,j,i,m)=Nb_BI(p,k,j,i,m)+Nu_I(p,p)*Nu_O(4,p,p)*Nb_BI(p,jk,jk,nb,m+1);
            end;
            tmpDL(m)=tmpDL(m)+Nu_I(p,p)*Nu_O(4,p,p)*DL(p,jd,jd,m+1);   
          end;
         end;
       end;
      end;
 
    
         for  m=1:nr;
          DL(p,j,i,m)=DL(p,j,i,m)+sum(Nb_BI(p,1:j,j,i,m));  // demand of bearing axis plus the leaves of substructures       
          DL(p,j,i,m)=DL(p,j,i,m)+tmpDL(m);    
        end;
    
    end;  //j
  end;  //i
end;//p

//printf("done. \n ");

//layer number is same as living leaf number
//Nb_O(6,:,:,:,:,:,1:nr)=Nb_O(1,:,:,:,:,:,1:nr);

//layer number is same as living internode number
Nb_O(6,:,:,:,:,:,1:nr)=Nb_O(3,:,:,:,:,:,1:nr);

endfunction


