//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_Load_SMB
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Read points and their connection from smb files of internode, leaf, female flower and male flower
//  Draw each organ if necessary
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************


//get points' xyz position, number of surface and index of points in each surface of an organ smb file
//internode
filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_I+'.smb';
[fid, err] = mopen(filename, 'rb');//open the smb file
if err
  PI=[];nbfacesI=0;FacesI =[];
  //disp("File "+filename+" does not exist!");  
else
   Draw_read_organ(fid,1);
end
mclose(fid);//close the file
  
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


//Male flower
filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_Fm+'.smb';
[fid, err] = mopen(filename, 'rb');//open the smb file
if err
  PFm=[];nbfacesFm=0;FacesFm=[];//disp("File "+filename+" does not exist!");  
else
  [PFm,nbfacesFm,FacesFm] = Draw_read_organ(fid,1);
end
[x_Fm,y_Fm,z_Fm]=Draw_SMB_new(PFm,nbfacesFm,FacesFm);
mclose(fid);//close the file

