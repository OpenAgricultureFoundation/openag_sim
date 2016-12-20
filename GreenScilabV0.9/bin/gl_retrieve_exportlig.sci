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

 
if Flag_geo_lig==1
  if Flag_geo_full==0 //compute only plant geometry at age N
    i0=N;
  else
    i0=1;
  end      
  for age=i0:N
    para=[1, age, age, age, 1, 1,1];      
    exec(GL_SYS_DIR+'bin'+SEPARATOR+'Draw_str2lig.sci');          
  end            
  
end;
    


