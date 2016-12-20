//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_Lig
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Retrieve data from str file and write into a Linear file. Linear file describes position, orientation, size, age of each organ
//History:
//Author           time        version     description
//Kang Mengzhen   2003-6-20      1.1        keep each direction as normalized vector.
//****************************************

function [n,Maxb,Minb,]=Draw_Lig(para,Vs,Os,StrInf,StrId,NumStr,StrSz,data,Color_P,fid,n,Maxb,Minb,Flag_leaf,Flag_fruit);

//find ID of substructure according to the parameter  [p i j j 1 g m]
StrID=StrId(para(1),para(2),para(3),para(4),para(5),para(6),para(7)); 

//find the position of the substructure offset according the its id
StrSzcum=cumsum(StrSz);
if StrID>1 then
   offset=StrSzcum(StrID-1);           
else        
   offset=0;   
end        

for j=offset+1:offset+StrSz(StrID)    
    
   organid=data(j,1);
   
   parao=data(j,2:8);//ID of organs in this structure. [p k j i 1 g m ]
   
   V=matrix(data(j,9:20),3,4);  //original position and deirection 
   //mutipication of rotation matrix
   V=Vs*V;             
   // rotation matrix
   Vo=V(1:3,1:3);  //orientation matrix    
   
   // shift vector
   Oo=Os+V(1:3,4)'; //shifted position 
      
   //Maxb=max([Maxb;Oo],[],1)
   Maxb=max(Maxb,Oo);//bounding box      
   //Minb=min([Minb;Oo],[],1);
   Minb=min(Maxb,Oo);//bounding box
      
   data1=[organid 0 0 0];          // organid, 0 0 0              

   //for the main vector, multiply by the length
   select organid             
   case 1 //internodes  
     OrgScale=data(j,21);     
   case 10 //leaf
     OrgScale=data(j,21);   
   case 20 //flower
     OrgScale=data(j,21);
   case 4 //substructure         
     OrgScale=1;      
   end    
   
   //Vo =Vo* [0 0 1;0 1 0;1 0 0];//to rotate the smb. this should be done in TJ software
   //V=[0 0 -1;0 1 0;1 0 0];      
   //disp(Vo)
   
   //Vo=Vo';
   //Vo(1,:)=Vo(1,:)*OrgScale;                               
   //Vo=Vo';

   //Vo=Vo';

   if organid==4 then
      [n,Maxb,Minb]=Draw_Lig(parao,Vo ,Oo,StrInf,StrId,NumStr,StrSz,data,Color_P,fid,n,Maxb,Minb,Flag_leaf,Flag_fruit);  
   else
     mput(data1,'i',fid); 
     Vo(:,1)=Vo(:,1)*OrgScale;//the primary direction
     V=[Vo  Oo'];     // a 3*4 matrix [x1 x2 x3 x4;y1 y2 y3 y4;z1 z2 z3 z4];

     V=matrix(V',1,12);                               
     
     //disp(V)
     
     data2=[V data(j,22) data(j,22) 0];//write position and orietation, section area for internode etc. into the linear file, total 15 data, 'float'
   
     mput(data2,'f',fid);

     n=n+1;                
      
   end         
   
   if n/1000-int(n/1000)==0      
      mprintf(' %4d \n',n);             
   end                    
   
end

endfunction
