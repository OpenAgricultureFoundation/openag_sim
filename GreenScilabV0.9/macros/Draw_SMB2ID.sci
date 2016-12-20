function [ID] = Draw_SMB2ID(Smb_I,Smb_L,Smb_Ff,Smb_Fm)

// Ouput variables initialisation (not found in input variables)
ID=[];

//  Copyright (c) 2003 LIAMA
//  File name: Draw_3D
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  get interger ID of smb filename from file smb/IDsmb.m
//  input: 4 strings, name of smbfile of internode, leaf, female organ, male organ. 
//  output: integer vecter, id of internode, leaf, female organ, male organ.the default value is 100,200,300,400 if these strings have no corresponding integers
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************

//set default value
ID = [100,200,300,400];

global GL_SYS_DIR
// open index table

[fidsmb, %v] = mopen(GL_SYS_DIR+'smb'+SEPARATOR+'IDsmb.sci','r');

if %v then
  fidsmb = -1; disp('file'+GL_SYS_DIR+'smb'+SEPARATOR+'IDsmb.sci' + ' read error.');
  abort
end

name = mfscanf(fidsmb,"%s");//read '0'
name = mfscanf(fidsmb,"%s");//read 'fbegin'

//sequential search of the table to find any match
while  name<>'fend'

  Id = mfscanf(fidsmb,"%s");  //read id in table
  name = mfscanf(fidsmb,"%s");  //read smb name in table

  if name==Smb_I then //internode
   ID(1,1) = evstr(Id) ;
  end;
  
  if name==Smb_L then //leaf
   ID(2) =  evstr(Id);
  end;
  
  if name==Smb_Ff then //female organ
   ID(3) = evstr(Id);
  end;
  
  if name==Smb_Fm then //male organ
   ID(4) = evstr(Id);
  end;

end;

mclose(fidsmb);
endfunction
