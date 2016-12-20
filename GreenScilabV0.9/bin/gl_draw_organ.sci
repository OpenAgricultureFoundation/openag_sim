

organfilename = xgetfile('*.smb', GL_SYS_DIR+'smb',title='open smb file');
[path,organfname,extension]=fileparts(organfilename);
disp(organfname)

Flag_windows=1;

//open the smb file
[fid, err] = mopen(organfilename, 'rb',0);
if err
  //disp("File "+filename+" does not exist!");
  return
else
  [P,nbfaces,Faces] = Draw_read_organ(fid,Flag_windows);  
  L=20;
  O=[0,0,0];
  
  //test different rotation matrice
  w3=3.14159/2;
  Vz=[cos(w3) -sin(w3) 0;sin(w3) cos(w3) 0; 0 0 1]; 
  ap=3.14159/2;
  Vy=[cos(ap) 0 sin(ap);0 1 0;-sin(ap) 0 cos(ap)];       //y-axis rotation matrix for axis angle
  Vx=[1 0 0; 0 cos(ap) sin(ap); 0 -sin(ap) cos(ap)];
  V=Vx;
  V=eye(3,3);
  //V=[0.866 -0.5 0; 0 0 -1; 0.5 -0.866 0]
  
  C=[0;0.6;0];

  [X,Y,Z,CP]=Draw_SMB(P,nbfaces,Faces,L,O,V,C);


  g=gcf();
  //g=scf();
  //g.figure_name=smb;
  g.visible='off';
  drawlater();

  for i=1:length(X)
    if size(X(i),2)>1 then //a single facet has problem of 'monotonous'
      plot3d(X(i),Y(i),list(Z(i),CP(i)))
            h=get("hdl");
        h.hiddencolor=-CP(i);
    end
  end

  g.visible='on';
  a=get("current_axes");  
  a.rotation_angles = [90,-90]  ;

  drawnow();

end
//close the file
mclose(fid);
