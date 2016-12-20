//  Copyright (c) 2003 LIAMA
//  File name: Draw_3D
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Draw 3D structure of plant
//  Input: para-parameters for current structure, Vs-rotation matrix, Os-shift vector, StrInf-substructure information matrix
//  StrId-substructure index matrix, NumStr-number of substructure in full plant, StrSz-number of blocks in each substructure
//  data-data in all blockes, PL,nbfacesL,FacesL,PFf,nbfacesFf,FacesFf,PFm,nbfacesFm,FacesFm-smb info for leaf, femal and mal organ
//  Tu_O-life time of organs
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************

function [XI, YI, ZI, CI, XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm]=Draw_3D(para,Vs,Os,StrInf,StrId,NumStr,StrSz,data,x_B,y_B,z_B,x_Ff,y_Ff,z_Ff,x_Fm,y_Fm,z_Fm,Tu_O,XI, YI, ZI, CI,XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm)

//find ID of substructure according to the parameter [p i j j 1 g m]
StrID=StrId(para(1),para(2),para(3),para(4),para(5),para(6),para(7)); 

//find the position of the substructure offset according the its id
StrSzcum=cumsum(StrSz); 
if StrID>1 then //if this substructure exist
   offset=StrSzcum(StrID-1);        
else        
   offset=0;
end   

for j=offset+1:offset+StrSz(StrID) //read the organs inside the substructure 
   parao=data(j,2:8);//ID of organs in this structure. [p k j i 1 g m ]
   V=matrix(data(j,9:20),3,4);   
   //mutipication of rotation matrix
   V=Vs*V;   
   // rotation matrix
   Vo=V(1:3,1:3);   
   // shift vector
   Oo=Os+V(1:3,4)';   
   //size of organs
   D=data(j,21:22); 
   
   select data(j,1)       
       
   case 1 then //internode
      if parao(2)<=Tu_O(2)  then // living internode
         C=Color_I(1,:);//+(parao(2)-1)*(Color_I(2,:)-Color_I(1,:))/Tu_fI; 
      else         
         C=Color_I(2,:);  
      end           
      
      N=6;// number of points for the polygon
      t=linspace(0,2*%pi,N);//discretize the angle
      bz=D(2)/2*cos(t); by=D(2)/2*sin(t); //base points coordinates, vectors
      bx1=zeros(1,N); //bottom
      bx2=D(1)*ones(1,N);//top
      points1=[bx1 ;by ;bz];//points on the bottom
      points2=[bx2 ;by; bz];//points on the top   
      points=[points1 points2];
            
      //V=[0 0 1;0 1 0;1 0 0];      
      //points=V*points;
      
      [XI, YI, ZI, CI]=Draw_Internode(XI, YI, ZI, CI,points,Oo,Vo,C);     
      
   case 10  //leaves  
      if   size(PL,1)>0          
         if parao(2)<=Tu_O(1) then
            C=Color_B(1,:);//+(parao(2)-1)*(Color_B(2,:)-Color_B(1,:))/Tu_fB;
         else
            C=Color_B(2,:);
         end 
         
         //[X,Y,Z,CP]=Draw_SMB_transform(x_B,y_B,z_B,sqrt(D(1)),Oo,Vo,C); //info of one leaf                       
         //[X,Y,Z,CP]=Draw_SMB_transform(x_B,y_B,z_B,D(1)/10,Oo,Vo,C); //info of one leaf                       
         [X,Y,Z,CP]=Draw_SMB_transform(x_B,y_B,z_B,D(1),Oo,Vo,C); //info of one leaf. D is the length of blade, computed in gl_draw_phy
            
         if length(XB)==0 // if XB is empty
            XB=X;YB=Y;ZB=Z;CB=CP;
         else
            for i=1:length(X) //for each kind of facet         
              XB(i)=[XB(i) X(i)];YB(i)=[YB(i) Y(i)];ZB(i)=[ZB(i) Z(i)];CB(i)=[CB(i) CP(i)];            
            end
         end
            //NoFace=length(XB);//number of existing facets
            //for a=1:nbfacesL
            //  XB(NoFace+a)=X(a);
            //  YB(NoFace+a)=Y(a);
            //  ZB(NoFace+a)=Z(a);
              //YB(a)=[YB(a) Y(:,a)];
              //ZB(a)=[ZB(a) Z(:,a)];
            //end
            

         //end
        
      end            
      
   case 20//fruits       
      if parao(2)<=Tu_O(3) then       
         C=Color_Ff(1,:);//+(parao(2)-1)*(Color_F(2,:)-Color_F(1,:))/Tu_fF;                     
      else                     
         C=Color_Ff(2,:);                     
      end                           
      if  size(PFf,1)>0  then //& Flag_geo_fruit(parao(1))==1        
         
         [X,Y,Z,CP]=Draw_SMB_transform(x_Ff,y_Ff,z_Ff,(D(1))^(1/3),Oo,Vo,C); 
         
        if length(XFf)==0 // if XB is empty
            XFf=X;YFf=Y;ZFf=Z;CFf=CP;
         else
            for i=1:length(X) //for each kind of facet         
              XFf(i)=[XFf(i) X(i)];YFf(i)=[YFf(i) Y(i)];ZFf(i)=[ZFf(i) Z(i)];CFf(i)=[CFf(i) CP(i)];            
            end
         end
         
         //XFf=[XFf X];YFf=[YFf Y];ZFf=[ZFf Z];CFf=[CFf CP];     
         
//         NoFace=length(XFf);//number of existing facets
//            for a=1:nbfacesFf
//              XFf(NoFace+a)=X(a);
//              YFf(NoFace+a)=Y(a);
//              ZFf(NoFace+a)=Z(a);            
//              //XFf(a)=[XFf(a) X(:,a)];
//              //YFf(a)=[YFf(a) Y(:,a)];
//              //ZFf(a)=[ZFf(a) Z(:,a)];
//            end              
      else
         //Draw_fruit(D(1),D(1),Oo,Vo,C);
      end                        
      
   case 30//male organ       
      if parao(2)<=Tu_O(3)    then    
         C=Color_Fm(1,:);//+(parao(2)-1)*(Color_F(2,:)-Color_F(1,:))/Tu_fF;                     
      else                     
         C=Color_Fm(2,:);                     
      end          
      
      if  size(PFm,1)>0 then    
      
         [X,Y,Z,CP]=Draw_SMB_transform(x_Fm,y_Fm,z_Fm,(D(1))^(1/3),Oo,Vo,C); 
         
        if length(XFm)==0 // if XFm is empty
            XFm=X;YFm=Y;ZFm=Z;CFm=CP;
         else
            for i=1:length(X) //for each kind of facet         
              XFm(i)=[XFm(i) X(i)];YFm(i)=[YFm(i) Y(i)];ZFm(i)=[ZFm(i) Z(i)];CFm(i)=[CFm(i) CP(i)];            
            end
         end
//         NoFace=length(XFm);//number of existing facets
//            for a=1:nbfacesFm
//              XFm(NoFace+a)=X(a);
//              YFm(NoFace+a)=Y(a);
//              ZFm(NoFace+a)=Z(a);             
//              //XFm(a)=[XFm(a) X(:,a)];
//              //YFm(a)=[YFm(a) Y(:,a)];
//              //ZFm(a)=[ZFm(a) Z(:,a)];
//            end
//            CFm=[CFm CP];         
         
      end                              
      
   case 4 //substructure     
      [XI, YI, ZI, CI,XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm]=Draw_3D(parao,Vo,Oo,StrInf,StrId,NumStr,StrSz,data,x_B,y_B,z_B,x_Ff,y_Ff,z_Ff,x_Fm,y_Fm,z_Fm,Tu_O,XI, YI, ZI, CI,XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm);   
   end               
end
clear StrID
clear StrSzcum
endfunction
