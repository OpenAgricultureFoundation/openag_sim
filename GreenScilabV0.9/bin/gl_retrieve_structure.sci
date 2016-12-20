//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Gl_retrieve_structure
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Display 3D, skeleton or linear file of plant occording to structure description file
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************


//StrFileName = xgetfile('*.str','\str', title='open str file');
StrFileName=GL_SYS_DIR+'str'+SEPARATOR+FileID+'.str';

[fidstr, err] = mopen(StrFileName, 'rb');
if err then
  disp(err)
  disp('.str file read error.');
  abort
end

//read data from str file
//disp(strcat(['Reading data from :',StrFileName,'  ...']));
[rFilepath,rFileID,rFileextension]=fileparts(realFile);
rStrFileName=GL_SYS_DIR+'str'+SEPARATOR+rFileID+'.str';
disp(strcat(['Reading data from :',rStrFileName,'  ...']));

IDSmb=zeros(1,4);//integer ID of organs

//read 10 data from the header
data=mget(10,'l', fidstr);

//data=[maxp N NumStr IDSmbInternode IDSmbLeaf IDSmbFemalFlower IDSmbMalFlower LifetimeInternode LifetimeLeaf LifetimeFlower];   
maxp=data(1);N=data(2); NumStr=data(3);IDSmb(1:4)=data(4:7);To=data(8:10);

//read second 10 data from the header
data=mget(10,'l', fidstr);//Tr
Tr=data(1:maxp);

//read second third data from the header
data=mget(10,'l', fidstr); //NumInit
NumInit=data(1:maxp);

//read second fourth data from the header
data=mget(10,'l', fidstr) ;//Nr
Nr=data(1:maxp);

//get organ smb file name according to their id
[Smb_I,Smb_L,Smb_Ff,Smb_Fm]=Draw_ID2SMB(IDSmb);

//load geometrical data of each organ symbal,Smb_I,Smb_L,Smb_Ff,Smb_Fm
exec(GL_SYS_DIR+'bin'+SEPARATOR+'Draw_load_SMB.sci');

//printf(strcat(['Number of structures :' string(NumStr) ' ...\n']));

//read structure information(StrInf) for NumStr*40 bytes
StrInf=zeros(NumStr,10); 
StrId=zeros(maxp,N,N,N,max(Tr),max(NumInit),nr);

for i=1:NumStr //for each substructure
   //read 10 data
   data=mget(10,'l', fidstr); //data=[4 p k j i r g m NO 0];4-substrucuture, p-phy_age of substructure
   //k-chr_age of substructure, j-upper j GUs in this substructure, i-chr_age of plant, r-random index(1 for deterministic case)
   //g-geometrical index(substructure can have several initial angles, m-reiteration order(1 for highest order))
   //NO-number of blockes in this substrcture
   
   //keep information for i-th substructure in StrInf(i,:)
   StrInf(i,:)=data;
   //Build a map StrId, so that given information of a substructure, it's index can be easily found.
   StrId(data(2),data(3),data(4),data(5),data(6),data(7),data(8))=i;
   
end;
printf('\n');

//number of blocks NO in each structure 
StrSz=StrInf(:,9)';
//sum of number of blocks NO in each structure 
StrSzSum=sum(StrSz);
printf(strcat(['Total number of data blocks :',string(StrSzSum),'.\n']));
printf('Reading data blocks ......\n');

//read block information(data) for NumStr*40 bytes
data=zeros(StrSzSum,22);
for i=1:StrSzSum //for each block
   // read 8 integer data
   temp=mget(8,'l', fidstr);
   data(i,1:8)=temp;
   
   //read 14 float data
   temp=mget(14,'f', fidstr);
   data(i,9:22)=temp;
   
   //when every 1/5 part of all blockes are read, disp info
   templenround=round(StrSzSum/5);
   if templenround > 0 then
    if i- round(i/templenround)*templenround==0 then
      printf(' %4d \n',i);       
    end;   
   end;
end;
clear temp

mclose (fidstr); //close .str file
printf('\n');


//global XI YI ZI CI

//prompt dialogue
///labels=['Phy_age(1-'+string(maxp) +')';'Chr_age plant:(1-'+string(N)+')';'Chr_age substructure:(1-'+string(N)+')(<=Chr_age of plant)';'Initial Angle(1-'+string(NumInit(1))+ ')';'Reiteration (1-'+string(Nr(1))+')'];
//labels=['PA','CA plant','CA sub','Init_Ang','Reiter Order'];
//labels=['PA','CA plant','CA sub'];//suppose Init_Ang=1 and Reiter Order=1
//init=['1';string(N);string(N)];      
//dlgTitle='choose a structure';   
//[ok,p,i,j]=getvalue(dlgTitle,labels,list("vec",1,"vec",1,"vec",1),init);
 
//if  ~ ok then        
//   p=0;i=0;j=0;
//end      

//while i>0           
   
   //parameter for slected substructure, 7 charactors
   //para=[p, j, j, i, 1, 1,1];        

  
p=1;  
if Flag_geo_3D(p)==1 then// draw 3D   
 	CurT=timer();

  f=scf();
  f.visible='off';
  drawlater();

 	if Flag_geo_full==0 then //compute only plant geometry at age N
    i0=N;
  else
    i0=1;
  end
 	   	  
 	mode_boundary=2; 	  
 	  
 	for i=i0:N
 	  
   	  para=[1, i, i, i, 1, 1,1];
   	
   	  XI=[];YI=[];ZI=[];CI=[];   	
   	  XB=list();YB=list();ZB=list();CB=[];
   	  XFf=list();YFf=list();ZFf=list();CFf=[];
   	  XFm=list();YFm=list();ZFm=list();CFm=[];
  	   	
      V=eye(3,3);O=zeros(1,3);

      [XI, YI, ZI, CI, XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm]=Draw_3D(para,V,O,StrInf,StrId,NumStr,StrSz,data,x_B,y_B,z_B,x_Ff,y_Ff,z_Ff,x_Fm,y_Fm,z_Fm,To,XI, YI, ZI, CI, XB, YB, ZB, CB, XFf, YFf, ZFf, CFf, XFm, YFm, ZFm, CFm);

      //draw internodes
      n=size(XI,2);
    	 plot3d(XI,YI,list(ZI,CI),flag=[mode_boundary,4,0]);  // QR 2005 12//
	    
	    e=gce();      e.hiddencolor=-1;      //e.color_mode=-e.color_mode;  
        
	    if Flag_geo_leaf==1//draw leaves	  	   
	       for i = 1:length(XB);   		//for each face i in the smb
      		    x=XB(i);      		    y=YB(i);      		    z=ZB(i);      		
  	   		     plot3d(x,y,list(z,CB(i)),flag=[mode_boundary,4,0])  //QR 2005 12
            //plot3d(x,y,list(z,CB(i)))  //QR 2005 12 	        	   		
            h=get("hdl");
            h.hiddencolor=-CB(i);            
	       end
		     e=gce();		     e.hiddencolor=-1;		     //e.color_mode=-e.color_mode;  	  	       		     
		  end		  

    
	    if Flag_geo_fruit==1//draw female flower	  
	      for i = 1:length(XFf);   		//for each face i in the smb
      		  x=XFf(i);      		y=YFf(i);    		  z=ZFf(i);
      	  	drawlater();
	   		   plot3d(x,y,list(z,CFf(i)),flag=[mode_boundary,4,0])  // QR 2005 12
	 	      e=gce();	       e.hiddencolor=-1;

          h=get("hdl");
          h.hiddencolor=-CFf(i);    
  	       
 	        //e.color_mode=-e.color_mode;   	   		
	      end

    
	      //draw male flower
	      for i = 1:length(XFm);   		//for each face i in the smb
      	  	x=XFm(i);
    		    y=YFm(i);
    		    z=ZFm(i);
    		    drawlater();
	   		   plot3d(x,y,list(z,CFm(i)),flag=[mode_boundary,4,0])  // QR 2005 12
		      e=gce();
	        e.hiddencolor=-1;
	       //e.color_mode=-e.color_mode;   	   		
	      end
 	   end

   
     a=get("current_axes");
     a.cube_scaling="off";
     //a.isoview="on" ;
     //a.axes_visibles="off";
    
     [parts,fname,extension] = fileparts(realFile);
     ind_fname = strindex(fname, 'maize');
     if ind_fname == [] then
       a.rotation_angles = [90,90]  ;
     else
       a.rotation_angles = [90,0]  ;
     end;
    
     a.margins=[0 0 0 0];
     a.axes_visible=['on' 'on' 'on'];
    
     clear XI YI ZI CI XB YB ZB CB XFf YFf ZFf CFf XFm YFm ZFm CFm
   end
        f.visible='on';
     f.rotation_style = "multiple";
    
     drawnow();
     //PassT=timer()-CurT;
     printf(strcat(['3D: ',string(timer()),' seconds.\n']));
     //h.color_mode=-2;

 end//draw 3D
   

