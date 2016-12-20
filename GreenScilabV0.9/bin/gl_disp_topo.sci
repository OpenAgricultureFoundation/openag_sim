
//%%%%%%%%%%%%% print data of topological production  %%%%%%%%%%%%%%%%%%%%%%

//###################### modified ########################
//printf("   Number of Growth unit, Internode, Leaves in plant...\n");
//####################### end ######################3
//if Flag_demo==0 then
//   x_message('the information will be shown in the workspace of SCILAB');
//end

tmp = zeros(1,maxp);

for p =1:maxp;
  for i = mtlb_imp(1,N);
    tmpGU(p,i) = mtlb_sum(S(1,:,i,i,p,1));
  
        tmpI(p,i)=tmpGU(p,i)*sum(Nu_I(p,:));
  
        tmpB(p,i)=tmpGU(p,i)*sum(Nu_I(p,:).*matrix(Nu_O(1,p,:),1,6));
 //tmpB(p,i)=tmpGU(p,i)*sum(Nu_I(p,:).*matrix(Nu_O(1,p,:),1,9));  original 
  end;
end;


for p = 1:maxp;  
    if Flag_topo_disp(p)==1 then
        printf("   Number of Growth unit, Internode, Leaves in plant...\n");
        printf('phy_age %2d:\n',p);    
        for i=1:N;
            printf('%10d',tmpGU(p,i));              
            printf('%10d',tmpI(p,i));      
            printf('%10d',tmpB(p,i));              
            printf('\n');   
        end ;     
    end;
end;

//total
if Flag_topo_disp_s==1 then
    printf('Total\n');       
    GUS=sum(tmpGU,1);IS=sum(tmpI,1);BS=sum(tmpB,1);
    for i=1:N;
        printf('%10d',GUS(i));              
        printf('%10d',IS(i));      
        printf('%10d',BS(i));              
        printf('\n');   
    end         
end

tmp=zeros(1,maxp);
tmpBa=zeros(maxp,N);
tmpF=zeros(maxp,N);
tmpFm=zeros(maxp,N);
      for p = 1:maxp      
    if Flag_topo_disp_l(p)==1 then
        printf('   Number of Living leaves, female organs, male organs in plant...\n');
        printf('phy_age %2d:\n',p);            
        for i=1:N;
            tmpBa(p,i)=sum(Nb_O(1,1,1:i,i,i,p,1));
            printf('%10d',tmpBa(p,i));      
            tmpF(p,i)=sum(Nb_O(4,1,1:i,i,i,p,1));      
            printf('%10d',tmpF(p,i));            
            tmpFm(p,i)=sum(Nb_O(5,1,1:i,i,i,p,1));      
            printf('%10d',tmpFm(p,i));                     
            printf('\n');   
        end;      
    end;
end;  

tmp=zeros(N,maxp);
tmp2=zeros(N,maxp);
m=1;
for p = 1:maxp;    
    if Flag_topo_disp_a(p)==1 then
        printf('   Number of Living leaves ABOVE each G.U.from top at each chr_age ... \n');
        printf('phy_age');            
        printf('%2d:\n',p);  
        for i=1:N;  
            printf('%4d:',i); 
            for j=max(1,i-Nu_Ma(p)+1):i;
                printf('%6d', Nb_BI(p,j,i,i,m));                          
            end      
            printf('\n');   
        end
    end
end    

// write results to 'out_topo.sci'
Foutopo=GL_SYS_DIR+'/bin/out_topo.sci';
[ftopo,err]=mopen(Foutopo,'w');
for p=1:maxp;
     if Flag_topo_disp(p)==1 then
        mfprintf(ftopo,"%s\n","   Number of Growth unit, Internode, Leaves in plant...");
	mfprintf(ftopo, "%s\t%2d\n","phy_age",p);
	for i=1:N;
		mfprintf(ftopo,"\t%d\t%d\t%d\n",tmpGU(p,i), tmpI(p,i),tmpB(p,i));
	end;
     end;
end;

mfprintf(ftopo,"\n");

if Flag_topo_disp_s==1 then
	mfprintf(ftopo,"%s\n","Total");
	for i=1:N;
		mfprintf(ftopo,"\t%d\t%d\t%d\n",GUS(i),IS(i),BS(i));
	end;
end;

mfprintf(ftopo,"\n");

for p=1:maxp;
   if Flag_topo_disp_l(p)==1 then
        mfprintf(ftopo,"%s\n","   Number of Living leaves, female organs, male organs in plant...");
	mfprintf(ftopo, "%s\t%2d\n","phy_age",p);
	for i=1:N;
		mfprintf(ftopo,"\t%d\t%d\t%d\n",tmpBa(p,i),tmpF(p,i),tmpFm(p,i));
	end;
   end;
end;

mfprintf(ftopo,"\n");

for p=1:maxp;
    if Flag_topo_disp_a(p)==1 then
        mfprintf(ftopo,"%s\n","   Number of Living leaves ABOVE each G.U.from top at each chr_age ... ");
	mfprintf(ftopo,"%s\t%2d\n","phy_age",p);
	for i=1:N;
		mfprintf(ftopo,"%d",i);
		for j=max(1,i-Nu_Ma(p)+1):i;
                	mfprintf(ftopo,'\t%d', Nb_BI(p,j,i,i,m));                          
            	end;      
            	mfprintf(ftopo,'\n');
	end;
     end;
end;
mclose(ftopo);

if exists('Flag_TCL')
     TCL_EvalFile(GL_SYS_DIR+'/inttcl/text_topo.tcl');
end;
clear Flag_TCL
//if Flag_demo ==0 then
//    x_message('number of organ has been calculated ');
//end

// if Flag_layer_disp==1 then
//    printf('Demand of layer:\n');                                        
//    for i=1:N;      
//        if i>1 then //if plant age bigger than 1
//            printf('%7d',DL(1,i-1,i-1));
//        else
//            printf('%7d',0);
//        end
//    end
//    printf('\n');         
//end

