function []=outputFolder(directory,iteration)

// display biomass production, size of organ, number....

//%%%%%%%% curve of biomass repartition between organs QO(id,p,J) %%%%%%%
//if Flag_demo==0 then
//   x_message('the information will be shown in the workspace of SCILAB');
//end
//Flag_layer_disp
//if 0==1 then
//    printf('Demand of layer:\n');
//   if S_O(6,1) == 0
//    for i=1:N;      
//       printf('%7d',0);
//       //printf('\t');
//    end
//   else
//    for i=1:N;      
//        if i>1 then //if plant age bigger than 1
//            printf('%7d',DL(1,i-1,i-1));
//            //printf('\t');
//        else
//            printf('%7d',0);
//            //printf('\t');
//        end
//    end
//   end;
//    printf('\n');         
//end
//Flag_layer_disp
//if 0==1 then
//
//    printf('Biomass for layer:\n');                                        
//    for i=1:N;
//        printf('%8.2f',sum(QO(6,:,i)));
//    end;
//    printf('\n');               
//    
//    printf('Layer on each branch:\n');                                        
//    for p=1:1;
//        printf('Phy age %d\n',p);                                                                
//        for J=max(1,N-Nu_Ma(p)+1):N ;       //current CA of GU
//            for j=1:J;    //each CA of GU
//                printf('%8.2f',q_L(p,j,N-J+j,N-J+j));
//            end;
//            printf('\n');                        
//        end;
//    end;
//    for p=2:maxp;
//        printf('Phy age %d, plant age %d\n',p,N);                                                                
//        for J=1:N-1;  //branch age       
//            printf('Branch age %d\n',J);                                                                         
//            for j=max(1,J-Nu_Ma(p)+1):J //from branch top to bottom
//                for k=1:j; // from G.U. inside to outside              
//                    printf('%8.2f',q_L(p,k,J-j+k,N-j+k));
//                end;            
//                printf('\n');
//            end;
//            printf('\n');                        
//        end;
//    end;   
//    printf('\n');               
//    
//end;

QO_T=zeros(OrganType,N+1); QO_T(:,:)=sum(QO,2);//biomass for organs in each cycle
QST=cumsum(Q);//accumulated biomass production
QO_TS=zeros(OrganType,N+1); //accumulated biomass for organs in each cycle
for id=1:OrganType;      
    QO_TS(id,:)=cumsum(QO_T(id,:));
end;   
QV=QO_TS(3,:);//biomass or volume of internode= pith+layer
QV(1,2:N)=QV(1,2:N)+QO_TS(6,1:N-1);
//Flag_demand_biomass
//if 0==1 then
//    printf('Demand of plant ... \n');                                        
//    for i=1:N;
//        printf('%8.2f',Demand(i));
//    end
//    printf('\n')               
//    
//    printf('Biomass production of plant in each cycle ...\n');                                        
//    for i=1:N+1;
//        printf('%8.2f',Q(i));
//    end
//    printf('\n')               
//end

//%%%%%%%%%%%%% print data of biomass repartition  %%%%%%%%%%%%%%%%%%%%%%

///###############  modified ##################################
//printf('-----------------------------------------biomass repartition---------------------------------------------\n');
//printf('Ph_Age\tCh_Age\t    Q\t\tQ_B  \t\tQ_P  \t\tQ_I  \t\tQ_Ff \t\tQ_Fm \t\tQ_L  \n');
//################  end  ########################################

//QO_Phy=zeros(maxp,N+1); QO_Phy(:,:)=sum(QO,1);
QTp=zeros(OrganType,maxp); QTp(:,:)=sum(QO,3);
QT=zeros(OrganType,1);QT(:,1)=sum(QTp,2);
//for p = 1:maxp;
//    if Flag_biomass_num(p)==1 then
//        printf('-----------------------------------------biomass repartition---------------------------------------------\n');
//        printf('Ph_Age\tCh_Age\t    Q\t\tQ_B  \t\tQ_P  \t\tQ_I  \t\tQ_Ff \t\tQ_Fm \t\tQ_L  \n');        
//        for J=1:N;      
//            printf('%6d\t',p);
//            printf('%6d\t',J);
//            printf('%8.2f\t',Q(J,1)); 	//biomass at each cycle     
//            printf('%8.2f\t',QO(1,p,J));//leaf
//            printf('%8.2f\t',QO(2,p,J));//petiel
//            printf('%8.2f\t',QO(3,p,J));//internode
//            if J>1 then
//                printf('%8.2f\t',QO(4,p,J));//female flower
//                printf('%8.2f\t',QO(5,p,J));//male flower      
//                printf('%8.2f\t',QO(6,p,J));//layer
//            end;
//            printf('\n');
//        end ;     
//        printf('\n');   
//    end;
//end;   
printf('\n');

//###################### modified ##########
//if Flag_biomass_num(p)==1 then
//   printf('Total:');
//   printf('%8.2f\t',sum(Q(1:N,1)));
//   for id=1:OrganType;
//       printf('%8.2f\t',QT(id,1));
//   end;
//   printf('\n');
//end
//######################### end  ############

//write results to 'out_result.sci'
[fre9,err]=mopen(directory+string(iteration)+".sci",'w');
//Flag_demand_biomass == 1
if 1== 1 then

mfprintf(fre9,"%s\n","Demand of layer:");
if S_O(6,1) == 0
for i=1:N;
		mfprintf(fre9,"%d\t",0);
end;
else
for i=1:N;
	if i>1 then;
		mfprintf(fre9,"%d\t",DL(1,i-1,i-1));
	else;
		mfprintf(fre9,"%d\t",0);
	end;
end;
end;
mfprintf(fre9,"\n");
mfprintf(fre9,"\n");
mfprintf(fre9,"%s\n","Biomass for layer:");
for i=1:N;
	mfprintf(fre9,"%.2f\t",sum(QO(6,:,i)));
end;
mfprintf(fre9,"\n");
mfprintf(fre9,"\n");
mfprintf(fre9,"%s\n","Layer on each branch:");
mfprintf(fre9,"%s\t%2d\n","Phy age",1);
for J=max(1,N-Nu_Ma(1)+1):N;
	for j=1:J;
		mfprintf(fre9,"%.2f\t",q_L(1,j,N-J+j,N-J+j));
	end;
	mfprintf(fre9,"\n");
end;

for p=2:maxp;
	mfprintf(fre9,"%s\t%2d\t%s\t%d\n","Phy age",p,"plant age",N);
	for J=1:N-1;
		mfprintf(fre9,"%s\t%d\n","Branch age",J);     // ############### error
		for j=max(1,J-Nu_Ma(p)+1):J;
			for k=1:j;
				mfprintf(fre9,"%.2f\t", q_L(p,k,J-j+k,N-j+k));
			end;
			mfprintf(fre9,"\n");
		end;
		mfprintf(fre9,"\n");
	end;
end;
mfprintf(fre9,"\n");

end;
//Flag_demand_biomass == 1
if 1 == 1 then

mfprintf(fre9,"%s\n","Demand of plant ...");
for i=1:N;
	mfprintf(fre9,"%.2f\t",Demand(i));
end;
mfprintf(fre9,"\n");
mfprintf(fre9,"\n");
mfprintf(fre9,"%s\n","Biomass production of plant in each cycle ...");
for i=1:N+1;
	mfprintf(fre9,"%.2f\t",Q(i));
end;
mfprintf(fre9,"\n");
mfprintf(fre9,"\n");

end;

for p=1:maxp;
  if Flag_biomass_num(p) ==1 then
   mfprintf(fre9,"%s\n","----------------------------------biomass repartition-------------------------------------");
  mfprintf(fre9,"%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n","Phy_Age","Ch_Age","Q","Q_B","Q_P","Q_I","Q_Ff","Q_Fm","Q_L");
  mfprintf(fre9,"%d\t%d\t%.2f\t%.2f\t%.2f\t%.2f\n",p,1,Q(1,1),QO(1,p,1),QO(2,p,1),QO(3,p,1));
  for J=2:N;
	mfprintf(fre9,"%d\t%d\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n",p,J,Q(J,1),QO(1,p,J),QO(2,p,J),QO(3,p,J),QO(4,p,J),QO(5,p,J),QO(6,p,J));
  end;
  mfprintf(fre9,"\n");
  end;
end;

if Flag_biomass_num(p) == 1 then

mfprintf(fre9,"\n");
mfprintf(fre9,"%s\n","Total");
mfprintf(fre9,"%.2f\t",sum(Q(1:N,1)));
for id=1:OrganType;
	mfprintf(fre9,"%.2f\t",QT(id,1));
end;
mfprintf(fre9,"\n");

end;
mclose(fre9);

//if exists('Flag_TCL') 
//      TCL_EvalFile(GL_SYS_DIR+'/inttcl/text_result.tcl');
//end;
clear Flag_TCL
//figure of biomass production in each cycle
// organ ID:  1 blade, 2 petiel, 3 internode, 4 female flower,  5 male flower, 6 layer, 7 root
    
    /// gl_disp_curve.sci

//clear S Nb_O Nb_BI DL MAT_EX q_O q_L
//if Flag_demo ==0 then
//   x_message('number of demand has been calculated '); 
//end
endfunction
