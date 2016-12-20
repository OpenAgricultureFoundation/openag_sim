//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_read_lig
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Read data from lig tree and draw it
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************/

//color of organ
Color_I=[0.3 0.5 0.1;0.9 0.6 0.4];
Color_B=[0.1 0.7 0.1;1 1.0 0.1];
Color_Ff=[0.6 1.0 0.4;1 0 0];

//organ description
Smb_L='default';   //leaf
Smb_Ff='cube2';     //flower

//flag to tell whether it's windows(1) or unix(0) format. For a new lig file, it is unknown
if MSDOS then
  Flag_windows=1;
else
  Flag_windows=0;
end

//Leaf  
filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_L+'.smb';
[fid, err] = mopen(filename, 'rb');//open the smb file
if err
  PL=[];nbfacesL=0;FacesL=[];//disp("File "+filename+" does not exist!");  
else
  [PL,nbfacesL,FacesL] = Draw_read_organ(fid,1);  
end
[x_B,y_B,z_B]=Draw_SMB_new(PL,nbfacesL,FacesL) ;
mclose(fid);//close the file


//Female flower
filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_Ff+'.smb';
[fid, err] = mopen(filename, 'rb');//open the smb file
if err
  PFf=[];nbfacesFf=0;FacesFf=[];//disp("File "+filename+" does not exist!");  
else
  [PFf,nbfacesFf,FacesFf]  = Draw_read_organ(fid,1);
end
[x_Ff,y_Ff,z_Ff]=Draw_SMB_new(PFf,nbfacesFf,FacesFf) ;
mclose(fid);//close the file


//open a lig file
FileName = xgetfile('*.lig', GL_SYS_DIR+'lig',title='open lig file');        
[fid, err] = mopen(FileName,'rb');
if err
  abort
end

//read hearder (80 byte) 
[temp]=mget(80,'uc',fid);

//new an temporary file 
[fidtmp, err] = mopen(GL_SYS_DIR+'lig'+SEPARATOR+'temporary.lig', 'wb');

num_org=0; //organ number in linear file

//read the first organ (76 bytes, 19 values)
[temp]=mget(76,'uc',fid);

while length(temp)>0  
    
    //count organ number
    num_org=num_org+1;
    
    if Flag_windows==1    //unix format, swap data                        
        
        temp1=temp;
        
    else
        
        
      for j=1:19      //total 19 values for an organ   
          
         tt=temp(4*j-3:4*j); //each value occupies 4 bytes
         
         //tt1=flipud(tt);       //flip the bytes.Eg: [1 2 3 4] -> [4 3 2 1]  
         tthalf1=tt(1:2);tthalf2=tt(3:4);
         tt1=[tthalf1 tthalf2];
         
         temp1(4*j-3:4*j)=tt1;         
         
      end  
        
    end
    
    //write data into the temporary file. They are written byte by byte
    mput(temp1,'uc',fidtmp);
    
    //read the next organ
    [temp]=mget(76,'uc',fid);
    
end   

// close all file
mclose(fidtmp);mclose(fid);

//open the temorary file again as read-only
[fidtmp, err] = mopen(GL_SYS_DIR+'lig'+SEPARATOR+'temporary.lig', 'rb');

//create a figure
f=scf();
f.visible='off';
drawlater();

   	  XI=[];YI=[];ZI=[];CI=[];   	
   	  XB=list();YB=list();ZB=list();CB=[];
   	  XFf=list();YFf=list();ZFf=list();CFf=[];
   	  XFm=list();YFm=list();ZFm=list();CFm=[];

//read data, total num_org organs
for i=1:num_org
    
    //read 4 data that represent organ id, chronological age of organ,chronological age of structure, 0
    [data1]=mget(4,'l',fidtmp);

    //read 15 data that represent rotation matrix and other three data
    [data]=mget(15,'f',fidtmp);
    
    //id of organ
    id_org=data1(1);
    
    //position and orientation 
    tmp=matrix(data(1:12),4,3);
    tmp=tmp';
    
    //orientation of organ
    m_rot=tmp(1:3,1:3);
            
    //length of internode, or area of leaf, or volume of fruit
    sz1=data(13);
    D=sz1;
    //section area of internode
    sz2=data(14);
    
    //position of organ
    org=tmp(:,4);
    Oo=org;Vo=m_rot;
    
    select id_org       //judge organ id
    case 1              //internode
        
      C=Color_I(1,:);
        
      Np=6;// number of points for the polygon
      t=linspace(0,2*%pi,Np);//discretize the angle
      bz=sz2/2*cos(t); by=sz2/2*sin(t); //base points coordinates, vectors
      bx1=zeros(1,Np); //bottom
      bx2=sz1*ones(1,Np);//top
      points1=[bx1 ;by ;bz];//points on the bottom
      points2=[bx2 ;by; bz];//points on the top   
      points=[points1 points2];
      
       // Draw_Internode(sz1,sz2,org,m_rot,C);     
       [XI,YI,ZI,CI]=Draw_Internode(XI, YI, ZI, CI,points,org,m_rot,C);   
       
    case 10  //leaves  
        
        if   size(PL,1)>0 then     //if the smb exist    
            
            C=Color_B(1,:);//+(parao(2)-1)*(Color_B(2,:)-Color_B(1,:))/Tu_fB;
            
            [X,Y,Z,CP]=Draw_SMB_transform(x_B,y_B,z_B,D(1),Oo,Vo,C); //info of one leaf. D is the length of blade, computed in gl_draw_phy
            
            if length(XB)==0 // if XB is empty
              XB=X;YB=Y;ZB=Z;CB=CP;
            else
              for i=1:length(X) //for each kind of facet         
                XB(i)=[XB(i) X(i)];YB(i)=[YB(i) Y(i)];ZB(i)=[ZB(i) Z(i)];CB(i)=[CB(i) CP(i)];            
              end
            end
            
            
        end 
        
    case 20//fruits               
        
        C=Color_Ff(1,:);//+(parao(2)-1)*(Color_F(2,:)-Color_F(1,:))/Tu_fF;                     
         
        [X,Y,Z,CP]=Draw_SMB_transform(x_Ff,y_Ff,z_Ff,(D(1))^(1/3),Oo,Vo,C); 
         
        if length(XFf)==0 // if XB is empty
            XFf=X;YFf=Y;ZFf=Z;CFf=CP;
        else
            for i=1:length(X) //for each kind of facet         
              XFf(i)=[XFf(i) X(i)];YFf(i)=[YFf(i) Y(i)];ZFf(i)=[ZFf(i) Z(i)];CFf(i)=[CFf(i) CP(i)];            
            end
        end
    end    
end

//draw internodes
n=size(XI,2)
plot3d(XI,YI,list(ZI,CI),flag=[mode_boundary,4,0]);  
	
e=gce();      e.hiddencolor=-1;      //e.color_mode=-e.color_mode;

for i = 1:length(XB);   		//for each face i in the smb
	x=XB(i);      		    y=YB(i);      		    z=ZB(i);      		
	plot3d(x,y,list(z,CB(i)),flag=[mode_boundary,4,0])  
  h=get("hdl");
  h.hiddencolor=-CB(i);
end
e=gce();		     e.hiddencolor=-1;		     //e.color_mode=-e.color_mode;  	  	       		


for i = 1:length(XFf);   		//for each face i in the smb
	x=XFf(i);      		y=YFf(i);    		  z=ZFf(i);
	drawlater();
	plot3d(x,y,list(z,CFf(i)),flag=[mode_boundary,4,0])  // QR 2005 12
	e=gce();	       e.hiddencolor=-1;

  h=get("hdl");
  h.hiddencolor=-CFf(i);
end


    clear XI YI ZI CI XB YB ZB CB XFf YFf ZFf CFf XFm YFm ZFm CFm
 

a=get("current_axes");
a.cube_scaling="off";
//a.isoview="on" ;
//a.axes_visibles="off";
a.margins=[0 0 0 0];
a.axes_visible=['on' 'on' 'on'];
a.rotation_angles = [90,0]  ;
  
f.visible='on';
drawnow();
