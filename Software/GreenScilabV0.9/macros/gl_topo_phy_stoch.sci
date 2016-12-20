function [S,Nb_O] = gl_topo_phy_stoch(N,maxp,Nu_Ma,Nu_I,Nu_O,st_j,b_o,br_a,re_a,rs_a,rt_a,T_Pr,Tu_O,sqa,sqb,sqbu,sqc,sel,um,umb,uml,Tr,Flag_pruning,Pruning_delay)

// Ouput variables initialisation (not found in input variables)
S=[];
Nb_O=[];

// Display mode
mode(-1);

// Display warning for floating point exception
//ieee(1);


//to get number of new growth unit in each cycle. 

//%v0 = mtlb_double(Tr);%v1 = mtlb_double(mtlb_e(b_o,:));// ! L.5: real(mtlb_double(maxp)) may be replaced by:
S = zeros(maxp,N,N,maxp,max(Tr),max(b_o(:))+1);

OrganType = 2;
//%v0 = mtlb_double(Tr);%v1 = mtlb_double(mtlb_e(b_o,:));// ! L.8: real(mtlb_double(maxp)) may be replaced by:
Nb_O = zeros(OrganType,maxp,N,N,maxp,max(Tr),max(b_o(:))+1);

//%v0 = mtlb_double(mtlb_e(b_o,:));
nr = max(b_o(:))+1;

u = sum(Nu_I,2);
printf("Topological computation with physiological age: ");
tic
for p = maxp:-1:1 //physiological age
 printf(" %4d ",p);
 for i = 1:N //chronological age        
 
  for r = 1:Tr(p) //stochastic ID                            
  
   for m = 1:nr //0/1series about G.U.
    //S(p,1:i,i,p,r,1:nr)=sqb(r,i:-1:1,p);
    S(p,1:i,i,p,r,1:nr) = um(r,i:-1:1,p);
    for k = 1:i // chr_age of G.U.                    
     for id = 1:OrganType
       select id
         case 2 then //living internode
        Ne = um(r,i-k+1,p);
         case 1 then //living leaf or petiel
        Ne = uml(r,i-k+1,p);
       end;
       flag1 = (i<=Tu_O(id,1)+m-1) & (k>(i-Nu_Ma(p)));  // a young branch 
       flag2 = (Tu_O(id,1)+m-1<i & i<=Nu_Ma(p)+m-1) & (k<=Tu_O(id,1)+m-1);  // a normal branch, 
       flag3 = (Nu_Ma(p)<i & i<Nu_Ma(p)+Tu_O(id,1)+m-1) & ((k>i-Nu_Ma(p)) & k<=Tu_O(id,1)+m-1);  // part beyond the bearing axis 
       if flag1|flag2 | flag3 then
         Nb_O(id,p,k,i,p,r,m) = Ne;
       end;
     end; //id                    
    end; //k                                
   end;
  
   if i>Nu_Ma(p,1) then // terminal structure
    b = st_j(p);
    //rb=sel(r,Nu_Ma(p,1)*u(p)+1,1,p);
    if b>=p & b<=maxp then
      rb = ceil(rand()*Tr(b));
      jd = i-Nu_Ma(p,1);
      if jd>0 then
        S(p,:,i,:,r,1:nr) = S(p,:,i,:,r,1:nr)+S(b,:,jd,:,rb,1:nr);
        Nb_O(:,p,:,i,:,r,1:nr) = Nb_O(:,p,:,i,:,r,1:nr)+Nb_O(:,b,:,jd,:,rb,1:nr);
      end;
    end;
   end;
  
   //lateral structure
   //u(p)=sum(Nu_I(p,p+1:maxp));%exclude reiteration case
   for k = max(1,i-Nu_Ma(p,1)+1):i //ch_age of G.U. on the axis from top
    suma = 0; //number of microstates in this G.U.
    for b = 6:-1:p+1 //no reiteration      
     for jj = 1:Nu_I(p,b)
       suma = suma+1;
       sumi = (i-k)*u(p)+suma;  //(j-k)*u(p)+suma; 
       if sqbu(r,sumi,p)==1 & maxp>=b then //only if internode exist
        for bj = 1:Nu_O(4,p,b) // for each branch
         if sqa(r,sumi,bj,p)>0 then
           rb = sel(r,sumi,bj,p);
           jd = floor((k-1-rs_a(b,1))*rt_a(b,1));  //the ch_age of lateral substructure                                                          
           if jd>0 then
             S(p,1:jd,i,b:maxp,r,1:nr) = S(p,1:jd,i,b:maxp,r,1:nr)+S(b,1:jd,jd,b:maxp,rb,1:nr);  // add number of internode in lateral substructures                                           
             Nb_O(:,p,1:jd,i,b:maxp,r,1:nr) = Nb_O(:,p,1:jd,i,b:maxp,r,1:nr)+Nb_O(:,b,1:jd,jd,b:maxp,rb,1:nr);  // add number of internode in lateral substructures                                           
           end;
         end;
        end;
       end;
     end;
    end;
   end;
  
   if b_o(p)>0 & Nu_I(p,p)*Nu_O(4,p,p)>0 then //reiteration             
    for k = max(1,i-Nu_Ma(p,1)+1):i
      suma = 0;  //number of microstates in this G.U.
      for jj = 1:Nu_I(p,p)
        suma = suma+1;
        sumi = (i-k+1)*u(p)-Nu_I(p,p)+jj;  //order in sqbu sequence
        if sqbu(r,sumi,p)==1 then //only if internode exist
         for bj = 1:Nu_O(4,p,p) // for each branch
          if sqa(r,sumi,bj,p)>0 then
            rb = sel(r,sumi,bj,p);
            for m = 1:b_o(p) //reiteration order  
             jd = floor((k-1-rs_a(p,1))*rt_a(p,1)); //the ch_age of substructure                                                                            
             if jd>0 then
               S(p,1:jd,i,p:maxp,r,m) = S(p,1:jd,i,p:maxp,r,m)+S(p,1:jd,jd,p:maxp,rb,m+1);  // add number of internode in lateral substructures                       
               Nb_O(:,p,1:jd,i,p:maxp,r,m) = Nb_O(:,p,1:jd,i,p:maxp,r,m)+Nb_O(:,p,1:jd,jd,p:maxp,rb,m+1);  // add number of internode in lateral substructures                                           
             end;
            end;
          end;
         end;
        end;
      end;
    end;
   end;
  
  end; //i
 end; //r
end;//p

// L.106: No simple equivalent, so mtlb_fprintf() is called
printf("done. \n ");
toc
endfunction
