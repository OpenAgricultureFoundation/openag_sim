//get current path and then smb file name
global GL_SYS_DIR

filename = GL_SYS_DIR+'smb'+SEPARATOR+smb+'.smb';

//open the smb file
[fid, err] = mopen(filename, 'rb');
if err
  //disp("File "+filename+" does not exist!");
  return
else
  [P,nbfaces,Faces] = Draw_read_organ(fid,1);  
  L=20;
  O=[0,0,0];
  V=eye(3,3);
  C=[0;0.6;0];

  [X,Y,Z,CP]=Draw_SMB(P,nbfaces,Faces,L,O,V,C);


  g=gcf();
  //g=scf();
  g.figure_name=smb;
  g.visible='off';
  drawlater();

  for i=1:length(X)
    if size(X(i),2)>1 then //a single facet has problem of 'monotonous'
      plot3d(X(i),Y(i),list(Z(i),CP(i)),alpha=35,theta=45,flag=[2,4,0])
            h=get("hdl");
        h.hiddencolor=-CP(i);
    end
  end

  g.visible='on';
  drawnow();

end
//close the file
mclose(fid);
