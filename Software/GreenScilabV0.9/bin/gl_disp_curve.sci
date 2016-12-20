function []=writeTo(directory,iteration)

//output curve
QO_T=zeros(OrganType,N+1); QO_T(:,:)=sum(QO,2);//biomass for organs in each cycle
dim1=size(QO_T);
//disp(dim1);
QST=cumsum(Q);//accumulated biomass production
dim2=size(QST);
//disp(dim2);
QO_TS=zeros(OrganType,N+1); //accumulated biomass for organs in each cycle
for id=1:OrganType;      
    QO_TS(id,:)=cumsum(QO_T(id,:));
end;  
dim3=size(QO_TS);
//disp(dim3);
QV=QO_TS(3,:);//biomass or volume of internode= pith+layer
QV(1,2:N)=QV(1,2:N)+QO_TS(6,1:N-1);
dim4=size(QV);
//disp(dim4);

QTp=zeros(OrganType,maxp); QTp(:,:)=sum(QO,3);
dim5=size(QTp);
//disp(dim5);
QT=zeros(OrganType,1);QT(:,1)=sum(QTp,2);
dim6=size(QT);
//disp(dim6);

Color_O = [0.2,0.6,0.4;0.2,0.9,0.4;0.6,0.2,0;1,0,0;1,1,0;1,0.5,0;0,0.2,0.4];

if Flag_biomass_fig==1 then

  //f = scf() ;
  //f.figure_name='Biomass repartition';
  
  //total
  ////i = 1:size(Q,1);
  ///********** MODIFIED ***********
    //i = 1 : (size(Q,1)-1);
    //for j = 1 : (size(Q,1)-1)
    //  TQ(j)=Q(j+1);
    //end*
    ////i=1:N;
   ////h=plot2d(i,Q(1:N),style=1);  
   //  h=plot2d(i,TQ,style=1);
  ///************  END ************8   
  
  //organs
  //disp(QO_T);
  [fres1,err]=mopen(directory+string(iteration)+"BiomassRepartition.sci","w");
  disp("the following is fres");
  disp(fres1);
  disp(err);
  disp("end fres");
  mfprintf(fres1,"%6s %6s %6s %6s %6s %6s","blade","petiole","pith","female fruit","male fruit","ring");
  mfprintf(fres1,"\n");
  mfprintf(fres1,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_T(:,1:7));
  mfprintf(fres1,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_T(:,8:14));
  mfprintf(fres1,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_T(:,15:21));
  mfprintf(fres1,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_T(:,22:28));
  mclose(fres1);
  //i = 1:N;
      //plot2d(i,QO_T(1,i),style=13);  // green blade
      
  //i = 1:N;
      //plot2d(i,QO_T(2,i),style=18);  //green  petiole
  //i = 1:N;
      //plot2d(i,QO_T(3,i),style=26);  //brown  pith(internode)  
  //i = 2:N;
      //plot2d(i,QO_T(4,i),style=21);   //red  female fruit
  //i = 2:N;
  //    plot2d(i,QO_T(5,i),style=2);   //blue  male fruit
  //i = 2:N;
   //   plot2d(i,QO_T(6,i),style=22);  //purple ring
  
  
  
 // i = 1:N; 
 // for id = 1:6;
 //   if id<4 then
 //     plot2d(i,QO_T(id,i),style=id+1);
 //   else
 //      i = 2:N; 
 //      plot2d(i,QO_T(id,i),style=id+1);
 //   end;
 // end;

  //a=gca();
//  a.children(1).children.thickness=4;
//  for i=2:7;
//  	a.children(i).children.thickness=3;
//  end
//  a.title.text="Biomass production and repartition" ;
//  a.title.font_size=3;  
//  a.x_label.text="Plant Age" ;
//  a.x_label.font_size=2;
//  a.y_label.text="Biomass" ;
//  a.y_label.font_size=2;  
//  a.data_bounds=[1,0;N,max(Q)];
//  if N>=3
//    if Q(2) > Q(3) then
//       legends(["total";"blade";"petiel";"pith";"female flower";"male flower";"ring"],[1 13 18 26 21 2 22],opt="ur");
//    else
//       legends(["total";"blade";"petiel";"pith";"female flower";"male flower";"ring"],[1 13 18 26 21 2 22],opt="ul");
//    end;
//  else
//    legends(["total";"blade";"petiel";"pith";"female flower";"male flower";"ring"],[1 13 18 26 21 2 22],opt="ur");
//  end;
end 


if Flag_bioprod_fig==1 then 
  // draw the value of Q(n-1) / D(n) 
  //f = scf() ;
//  f.figure_name='Production / Demand';
  
  //total
  ////i = 1:size(Q,1);
  ///********** MODIFIED ***********
    //i = 1 : (size(Q,1)-1);
    //for j = 1 : (size(Q,1)-1)
   //   TQ(j)=Q(j);
   // end
   [fres2,err]=mopen(directory+string(iteration)+"prodDemand.sci","w");
    QD=[];
    for k=1:length(Demand)
        if Demand(1,k) == 0
           break
        end
    end
    if k<length(Demand)
       for j=1:k-1
           QD(j)=Q(j)/Demand(1,j);
       end
    else
       if Demand(1,k)==0
          for j=1:k-1
              QD(j)=Q(j)/Demand(1,j);
          end
       else
          for j=1:length(Demand)
              QD(j)=Q(j)/Demand(1,j);
          end
       end
    end
    i=1:length(QD);
   ////h=plot2d(i,Q,style=1);  
     
     mfprintf(fres2,"%6s","Q/D");
     mfprintf(fres2,"%6.5f\n",QD);
     mclose(fres2);
     //h=plot2d(i,QD,style=1);
  ///************  END ************8   
  
  //a=gca();
//  a.children(1).children.thickness=4;
//  a.title.text="Biomass production devided by Demand" ;
//  a.title.font_size=3;  
//  a.x_label.text="Plant Age" ;
//  a.x_label.font_size=2;
//  a.y_label.text="Q/D" ;
//  a.y_label.font_size=2;  
//  a.data_bounds=[1,0;N,max(QD)];
end;

if Flag_biomass_fig_a==1 then

  //f = scf() ;
  //f.figure_name='Accumulated Biomass repartition';
  
  //total
  i = 1:size(QST,1);
  ///********** MODIFIED ***********
  //i = 1 : (size(QST,1)-1);
  //  for j = 1 : (size(QST,1)-1)
  //    TSQ(j)=QST(j);
  //  end
    
  //h = plot2d(i,QST,style=1);
  //h = plot2d(i,TSQ,style=1);  
  ///*********  END ****************
  [fres3,err]=mopen(directory+string(iteration)+"accumulatedBiomassRepartition.sci","w");
  //disp(fres3);
  mfprintf(fres3,"%6s %6s %6s %6s %6s %6s","blade","petiole","pith","female fruit","male fruit","ring");
  mfprintf(fres3,"\n");
  mfprintf(fres3,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_TS(:,1:7));
  mfprintf(fres3,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_TS(:,8:14));
  mfprintf(fres3,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_TS(:,15:21));
  mfprintf(fres3,"%6.5f %6.5f %6.5f %6.5f %6.5f %6.5f\n",QO_TS(:,22:28));
  mclose(fres3);
  //organs
  
//  i = 1:N;
//      plot2d(i,QO_TS(1,i),style=13);  // green blade
//  i = 1:N;
//      plot2d(i,QO_TS(2,i),style=18);  //green  petiole
//  i = 1:N;
//      plot2d(i,QO_TS(3,i),style=26);  //brown  pith(internode)  
//  i = 2:N;
//      plot2d(i,QO_TS(4,i),style=21);   //red  female fruit
//  i = 2:N;
//      plot2d(i,QO_TS(5,i),style=2);   //blue  male fruit
//  i = 2:N;
//      plot2d(i,QO_TS(6,i),style=22);  //purple ring
  
  
  //i = 1:N;
  //for id = 1:6;
  //  if id<4 then
  //    h = plot2d(i,QO_TS(id,i),style=id+1);
  //  else
  //     i = 2:N; 
  //    h = plot2d(i,QO_TS(id,i),style=id+1);
 //   end;
 // end;
  
  //a=gca();
//  a.children(1).children.thickness=4;
//  for i=2:7;
//  	a.children(i).children.thickness=3;
//  end
//  a.title.text="Accumulated biomass production and repartition" ;
//  a.title.font_size=3;  
//  a.x_label.text="Plant Age" ;
//  a.x_label.font_size=2;
//  a.y_label.text="Biomass" ;
//  a.y_label.font_size=2;  
//  a.data_bounds=[1,0;N,max(QST)];
//  legends(["total";"blade";"petiel";"pith";"female flower";"male flower";"ring"],[1 13 18 26 21 2 22],opt="ul")
  
end;


//display leaf area index case of field crop
if Flag_disp_LAI==1 then
  
  B_ST=zeros(1,N);
  for J=1:N
    for p = 1:maxp;
      for i = 1:J;
        if B_S(p,i,J)>0 & i<=Tu_O(1,1,p) then // leaf exist and still function
          B_ST(J)=B_ST(J)+B_S(p,i,J)*Nb_O(1,1,i,J,J,p);
        end;
      end;
    end
  end
  


  if Flag_field==1 then

    LAI=zeros(1,N);
    for J=1:N
      LAI(J)=B_ST(J)/Sp;
    end;

    //f = scf() ;
    //f.figure_name='leaf area index';
    J=1:N;
    dimTest=size(LAI(1));
    //disp(LAI(:));
    [fres4,err]=mopen(directory+string(iteration)+"LeafAreaIndex.sci","w");
    mfprintf(fres4,"%6s","LAI");
    mfprintf(fres4,"\n");
    mfprintf(fres4,"%6.5f\n",LAI(:));
    mclose(fres4);
    //h=plot2d(J,LAI,style=1);

    //a=gca();
//    a.children(1).children.thickness=4;
//    a.title.text="Leaf area index" ;
//    a.title.font_size=3;
//    a.x_label.text="Plant Age" ;
//    a.x_label.font_size=2;
//    a.y_label.text="LAI" ;
//    a.y_label.font_size=2;
//    a.data_bounds=[1,0;N,max(LAI)];

  else

    //f = scf() ;
//    f.figure_name='Plant leaf area ';
//    J=1:N;
//    h=plot2d(J,B_ST,style=1);
//
//    a=gca();
//    a.children(1).children.thickness=4;
//    a.title.text="Leaf area" ;
//    a.title.font_size=3;
//    a.x_label.text="Plant Age" ;
//    a.x_label.font_size=2;
//    a.y_label.text="Leaf area (cm2)" ;
//    a.y_label.font_size=2;
//    a.data_bounds=[1,0;N,max(B_ST)];
  end

end



//%%%%%%%%     curve of size of organs B_S,I_H,I_S,F_V %%%%%%%

//for p=1:maxp
//  //[fres,err]=mopen(directory+string(iteration)+"OrganSizes.sci","w");
//  //mfprintf(fres,"%6s","Blade Surface");
//  
//  if Flag_size_fig_phy(p)==1 then
//
//	  f = scf() ;
// 	  f.figure_name=strcat(['Organ size--Physiological age-',string(p)]);
// 	  f.visible='off';
// 	  
//    //blade surface 
//    subplot(2,2,1); 
//
//    for J=1:N  ;
//      i = 1:J;
//      //mfprintf(fres,"%6.5f\n",B_S(p,i,J));
//      h = plot2d(J-i+1,B_S(p,i,J),style=13);
//       a=gca();
//       a.children(1).children.thickness=4;
//        a.y_location="right";
//      a.x_label.text="Plant Age" ;
//      a.y_label.text="leaf surface" ;
//      a.data_bounds=[1,0;N,max(B_S(p,:,J))];
//    end;
//    //internode length 
//    subplot(2,2,2); 
//    for J=1:N ;
//      i = 1:J;
//      //mfprintf(fres,"\n");
//      //mfprintf(fres
//      h = plot2d(J-i+1,I_H(p,i,J),style=26);
//      a=gca();
//      a.children(1).children.thickness=4;
//     
//      a.x_label.text="Plant Age" ;
//      a.y_label.text="I_H" ;
//      a.data_bounds=[1,0;N,max(I_H(p,:,J))];
//    end;
//    //internode section area
//    subplot(2,2,4);  
//    for J =1:N;
//      i = 1:J;
//      h = plot2d(J-i+1,I_S(p,i,J,J),style=26);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.x_label.text="Plant Age" ;
//      a.y_label.text="I_Section_area" ;
//      a.data_bounds=[1,0;N,max(I_S(p,:,J,J))];
//    end;
//  
//    //fruit volume
//    subplot(2,2,3);
//    for J = 1:N;
//      i = 1:J;
//      h =plot2d(J-i+1,Ff_V(p,i,J),style=21);
//      a=gca();
//      a.children(1).children.thickness=4;
//       a.y_location="right";
//      a.x_label.text="Plant Age" ;
//      a.y_label.text="V_Ff" ;
//    end;
//	f.visible='on';
//	
//  end; 
//  
//end;
//if Flag_demo==0 then
//   x_message('Curve   Finished');
//end


//for p=1:maxp
//
//  if Flag_biomass_fig_phy(p)==1 then
//
//	  f = scf() ;
// 	  f.figure_name=strcat(['Organ weight--Physiological age-',string(p)]);
// 	  f.visible='off';
// 	  
//    //blade weight 
//    subplot(3,2,1); 
//    for J=1:N ;//plant age
//      i = 1:min(J,Nu_Ma(p)); //pos
//      h = plot2d(i,matrix(q_O(1, p,J-i+1, J),1,min(J,Nu_Ma(p))),style=13);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="right";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Blade weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(q_O(1, p,J-i+1, J))];
//    end;
//    
//    //petiole weight 
//    subplot(3,2,2); 
//    for J=1:N ;//plant age
//      i = 1:min(J,Nu_Ma(p)); //pos
//      h = plot2d(i,matrix(q_O(2, p,J-i+1, J),1,min(J,Nu_Ma(p))),style=13);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="left";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Petiole weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(q_O(2, p,J-i+1, J))];
//    end;
//    //pith weight 
//    subplot(3,2,3); 
//    for J=1:N ;//plant age
//      i = 1:min(J,Nu_Ma(p)); //pos
//      h = plot2d(i,matrix(q_O(3, p,J-i+1, J),1,min(J,Nu_Ma(p))),style=26);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="right";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Pith weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(q_O(3, p,J-i+1, J))];
//    end;
//    //internode weight 
//    subplot(3,2,4); 
//    for J=1:N ;//plant age
//      data=[];
//      for i = 1:min(J,Nu_Ma(p));//pos
//         ageGU=J-i+1;
//         QL=0;//weight of layer in this GU
//         for k=0:ageGU-1
//            QL=QL+q_L(p,ageGU-k,J-k,J-k);
//         end
//         tmp=q_O(3, p,ageGU,J)+QL;
//         data=[data tmp];
//      end
//      i = 1:min(J,Nu_Ma(p));
//      h = plot2d(i,data,style=26);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="left";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Internode weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(data)];
//    end;
//    //female weight 
//    subplot(3,2,5); 
//    for J=1:N ;//plant age
//      i = 1:min(J,Nu_Ma(p)); //pos
//      h = plot2d(i,matrix(q_O(4, p,J-i+1, J),1,min(J,Nu_Ma(p))),style=21);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="right";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Female weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(q_O(4, p,J-i+1, J))];
//    end;
//    subplot(3,2,6); 
//    for J=1:N ;//plant age
//      i = 1:min(J,Nu_Ma(p)); //pos
//      h = plot2d(i,matrix(q_O(5, p,J-i+1, J),1,min(J,Nu_Ma(p))),style=21);
//      a=gca();
//      a.children(1).children.thickness=4;
//      a.y_location="left";
//      a.x_label.text="Phytomer rank" ;
//      a.y_label.text="Male weight(g)" ;
//      a.data_bounds=[1,0;min(N,Nu_Ma(p)),max(q_O(5, p,J-i+1, J))];
//    end;
//
//    f.visible='on';
//  end; 
//  
//end;
endfunction
