

filename = xgetfile('*.smb', '',title='open smb file'); 

Flag_windows=1;

//open the smb file
[fid, err] = mopen(filename, 'rb',0);
if err
  //disp("File "+filename+" does not exist!");
  return
else
  [P,nbfaces,Faces] = Draw_read_organ(fid,Flag_windows);  
  L=20;
  O=[0,0,0];
  V=eye(3,3);
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
  drawnow();

end
//close the file
mclose(fid);
