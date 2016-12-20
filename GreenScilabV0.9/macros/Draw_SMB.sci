//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_SMB
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Draw an organ 
//  Input: xyz position of P points, number of faces, number of points in each face and their index, L-Scale, O-Origin
//  V-Roatation matrix,C-color
//  History:
//  Author           time        version     description
//  Kang Mengzhen   
//****************************************
function [X,Y,Z,CP]=Draw_SMB(P,nbfaces,Faces,L,O,V,C) 

//global XB YB ZB CB XFf YFf ZFf CFf XFm YFm ZFm CFm

//X=[];Z=[];Y=[];CP=[];

X=list();Z=list();Y=list();//they are lists
CP=list();

NP=[];//different number of points in this smb;some smb an contain facet of four, or 9 points

if size(P)>0 then

   P=V*P; 					//roation
   
   P=L*P;					//scaling, L is a scalar

   
   P(1,:)=P(1,:)+O(1);	//x-shift
   P(2,:)=P(2,:)+O(2);	//y-shift
   P(3,:)=P(3,:)+O(3);	//z-shift
   
   for i = 1:nbfaces   		//for each face i in the smb
   
      np=Faces(i)(1); 			//number of points in face i 
      
      //x,y,z are xyz position of np poitns in this face
      x = zeros(1,np);y = zeros(1,np);z = zeros(1,np);      
      for j = 1:np	//for each point j in face i
         n = Faces(i)(2)(j)+1;//n is the index of point j      
         x(j) = P(1,n);       //get x-position of j-th point
         y(j) = P(2,n);			//get y-position of j-th point
         z(j) = P(3,n);			//get z-position of j-th point
      end   
      x=real(x);y=real(y);z=real(z);
      x=x';
      y=y';
      z=z';      
      
      //disp(size(x))
      
      if i==1
        NP=[np];
      end
      
      class=find(NP==np);//indice of np in vectror NP
      
      if class>0 //such number of points has already exist
        //find the corresponding 
        choice=class;
      else //a new class of facets
        NP=[NP np]; 
        choice=length(NP);
      end
      
      //disp(choice)
      //disp(X(choice))
      if length(X)<choice then //the first element for class 'choice'
        X(choice)=x;Y(choice)=y;Z(choice)=z;CP(choice)= addcolor(C);
      else        
        X(choice)=[X(choice) x];Y(choice)=[Y(choice) y];Z(choice)=[Z(choice) z];CP(choice)=[CP(choice) addcolor(C)];
      end
      end
end

endfunction
