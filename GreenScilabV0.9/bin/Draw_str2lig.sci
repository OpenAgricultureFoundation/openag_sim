//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_str2lig
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Create linear file from structure description file and generate .inf file
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************


//flag to tell whether the lig file is in windows(1) or unix(0) format. 
//Flag_windows is read from the file

V=eye(3,3); O=zeros(1,3); n=0;Maxb=[0 0 0];Minb=[0 0 0]; VT=0;

//new an empty temorary file 
[fidtmp, err] = mopen(GL_SYS_DIR+'lig'+SEPARATOR+'temporary.lig', 'wb');

mprintf('Created number of internode ...\n');

//retrive data recursively and write data into the temporary file. Get number of organ n, bounding box Maxb and Minb, get volume of all internodes
[n,Maxb,Minb]=Draw_Lig(para,V,O,StrInf,StrId,NumStr,StrSz,data,Color_P,fidtmp,n,Maxb,Minb,Flag_leaf,Flag_fruit);

//close the temparary file
mclose(fidtmp);

//print volume of internode the screen
//mprintf('Volume of internode:%8.2f\n',VT);

//create lig file named testfilename_p_i.lig
//LigFileName=GL_SYS_DIR+'lig'+SEPARATOR+rFileID+'_' +string(para(1))+'_' +string(para(4))+ '.lig';
LigFileName=GL_SYS_DIR+'lig'+SEPARATOR+rFileID+'_' +string(para(2))+'.lig';

[fid, err]=mopen(LigFileName,'wb');         

//************* read and write header information **********************
//open header file
[fidhead,err]=mopen(GL_SYS_DIR+'lig'+SEPARATOR+'header.lig','r');
if err then
  disp('.lig header file does not exist!');
  abort
end

//read data (80 bytes)
//[temp]=mget(80,'schar',fidhead);
[temp]=mget(80,'uc',fidhead);


//write into the linear file
//count=fwrite(fid,temp,'schar');
mput(temp,'uc',fid);

//close the hearder file
mclose(fidhead);

//************* read data from the temrorary file and write it into the linear file
//open the temporary file again as read only
fidtmp=mopen('lig/temporary.lig','rb');   

//read the first organ (76 bytes)
//[temp,k]=fread(fidtmp,76,'schar');
[temp]=mget(76,'uc',fidtmp);

//read repeatly the temporary file until each organ is read and write
while length(temp)>0   
    
   if Flag_windows==1      
       
      temp1=temp;     //read and write sequentially
      
   else               //write data in unix format, exchange the  byte 
       
      for j=1:19      //total 19 values for an organ   
          
         tt=temp(4*j-3:4*j); //each value occupies 4 bytes
         
         //tt1=flipud(tt);       //flip the bytes.Eg: [1 2 3 4] -> [4 3 2 1]  
         tthalf1=tt(1:2);tthalf2=tt(3:4);
         tt1=[tthalf1 tthalf2];
         
         temp1(4*j-3:4*j)=tt1;         
         
      end               
      
   end
   
   //write data(mey be exchanged) into the linear file. They are written byte by byte
   //fwrite(fid,temp1,'schar');      
   mput(temp1,'uc',fid);
   
   //read the next organ
   //[temp,k]=fread(fidtmp,76,'schar');   
   [temp]=mget(76,'uc',fidtmp);
   
end   

//close the lig file
mclose(fid);

//close the temprary file
mclose(fidtmp);

//delete the temprary file from hard disk
//delete lig/temporary.lig;

//print the liear file name on screen
disp(LigFileName);       



//************** cerate an information .inf file
//name of file
DspFileName=GL_SYS_DIR+'lig'+SEPARATOR+rFileID+'_' +string(para(2))+'.dsp';

//open the .dsp file
fid=mopen(DspFileName,'w');             

//write data
mfprintf(fid,'#this file describes the information for visualization of plant\n');  
mfprintf(fid,'#each line is a description for one type of organ\n');
mfprintf(fid,'#organtype	organtype_id	if_is_branch	smb_file_path	r	g	b\n');

//mfprintf(fid,'#organtype\t 4%d \t	4%d\t' +	'cylinder2.smb'+' %8.3f  %8.3f %8.3f',1,1,Color_I(1,1),Color_I(1,2),Color_I(1,3));
mfprintf(fid,'organtype\t %4d \t	%4d\t' +	'internode.smb\t'+' %8.3f  %8.3f %8.3f\n',1,1,Color_I(1,1),Color_I(1,2),Color_I(1,3));

mfprintf(fid,'#organtype\t %4d \t	%4d\t' +	Smb_L+'.smb'+' %8.3f  %8.3f %8.3f\n',10,1,Color_B(1,1),Color_B(1,2),Color_B(1,3));
//mfprintf(fid,'organtype\t %4d \t	%4d\t' +	'default.smb\t'+' %8.3f  %8.3f %8.3f\n',10,1,Color_B(1,1),Color_B(1,2),Color_B(1,3));

mfprintf(fid,'#organtype\t %4d \t	%4d\t' +	Smb_Ff+'.smb'+' %8.3f  %8.3f %8.3f\n',20,1,Color_Ff(1,1),Color_Ff(1,2),Color_Ff(1,3));
//mfprintf(fid,'organtype\t %4d \t	%4d\t' +	'cube2.smb\t'+' %8.3f  %8.3f %8.3f\n',20,1,Color_Ff(1,1),Color_Ff(1,2),Color_Ff(1,3));

mclose(fid);
disp(DspFileName);       
printf('Done.\n')  

//we need to add organs of different color
//and male organ

//mfprintf(fid,' %8.3f  %8.3f %8.3f\n',Maxb);       
//mfprintf(fid,' %8.3f  %8.3f %8.3f\n',Minb);
//mfprintf(fid,' entre-noeud    1         entn105   1\n');       
//mfprintf(fid,'     feuille   10         feui102  23\n');
//mfprintf(fid,'     fruit     20         frui102  23\n');       
//
////close information file
//
//
////print the information file name on screen
//disp(InfFileName);       
//
       
       
