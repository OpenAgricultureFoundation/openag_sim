function [Smb_I,Smb_L,Smb_Ff,Smb_Fm] = Draw_ID2SMB(ID)

// Ouput variables initialisation (not found in input variables)
Smb_I=[];
Smb_L=[];
Smb_Ff=[];
Smb_Fm=[];

//get string of smb filename according to their id
//input: integer vecter, id of internode, leaf, female organ, male organ
//output: 4 strings, name of smbfile of internode, leaf, female organ, male organ. the default value is '0','default','0','0'

Smb_I = "0";Smb_L = "default";Smb_Ff = "0";Smb_Fm = "0";//default value

[fidsmb, %v] = mopen(GL_SYS_DIR+'smb'+SEPARATOR+'IDsmb.sci','r');

if %v then
  fidsmb = -1; disp('file'+GL_SYS_DIR+'smb'+SEPARATOR+'IDsmb.m' + ' read error.');
  abort
end


  name = mfscanf(fidsmb,"%s");  //read '0'

  name = mfscanf(fidsmb,"%s");  //read 'fbegin'
  
  while name<>'fend'

    Id = mfscanf(fidsmb,"%s");

    name = mfscanf(fidsmb,"%s");

    if evstr(Id)==ID(1) then
      Smb_I = name;
    end;

    if evstr(Id)==ID(2) then
      Smb_L = name;
    end;

    if evstr(Id)==ID(3) then
      Smb_Ff = name;
    end;

    if evstr(Id)==ID(4) then
      Smb_Fm = name;
    end;
  end;
  mclose(fidsmb);

endfunction
