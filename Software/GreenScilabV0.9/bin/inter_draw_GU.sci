//to display a metamer according to the topological parameters

exec(GL_SYS_DIR+'bin/gl_read_tmp.sci');
//p=1;

gfigure=gcf();
//g=scf();
gfigure.figure_name='Growth Unit';
gfigure.visible='off';
drawlater();


     InternodeH =  sqrt(a_bI(pp)) * VI(pp) ^ ((1 + a_aI(pp)) / 2);  //if a_aI(p)=-1, I_H have nothing to do with qi
     InternodeS = sqrt(1 / a_bI(pp)) * VI(pp) ^ ((1 - a_aI(pp)) / 2);
     
     D=[InternodeH InternodeS];Vo=eye(3,3);C=Color_I(1,:);Oo=[0 0 0];
     

      Nf=8;// number of points for the polygon
      t=linspace(0,2*%pi,Nf);//discretize the angle
      bx=D(2)/2*cos(t); by=D(2)/2*sin(t); //base points coordinates, vectors
      bz1=zeros(1,Nf); //bottom
      bz2=D(1)*ones(1,Nf);//top
      points1=[bx ;by;bz1 ];//points on the bottom
      points2=[bx; by;bz2 ;];//points on the top   
      points=[points1 points2];
      XI=[]; YI=[]; ZI=[]; CI=[];

      filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_L+'.smb';
[fid, err] = mopen(filename, 'rb');//open the smb file
if err
  PL=[];nbfacesL=0;FacesL=[];return;//disp("File "+filename+" does not exist!");  
else
      [PL,nbfacesL,FacesL] = Draw_read_organ(fid,1);
end
[x_B,y_B,z_B]=Draw_SMB_new(PL,nbfacesL,FacesL);
mclose(fid);//close the file
      
      LeafS=VB(pp)/Th_B(pp);
      L=sqrt(LeafS);

sumi=0;//number of metamers
for bGU=pp:maxp+1
  for i=1:Nu_I(pp,bGU)    
    sumi=sumi+1;
    //1. Internode                               
      
      [XI, YI, ZI, CI]=Draw_Internode(XI, YI, ZI, CI,points,Oo,Vo,C);   
      Oo=Oo+[0 0 InternodeH];
      plot3d(XI,YI,list(ZI,CI)); 
      h=get("hdl");
      h.hiddencolor=-CI;      

    //2.leaves
    if Nu_O(1,pp,bGU)>0 then
      //O=[0,0,InternodeH];
      O=Oo;
      //V=eye(3,3);   /////QIrui
      C=Color_B(1,:);

      //leaf insertion angle
      aa=Ang_O(1,pp,bGU);
      //Vx=[sin(Ang_O(1,pp,bGU)) 0 cos(Ang_O(1,pp,bGU)) ;0 1 0;cos(Ang_O(1,pp,bGU)) 0 -sin(Ang_O(1,pp,bGU))];  
      Vy=[cos(aa) 0 sin(aa) ;0 1 0;-sin(aa) 0 cos(aa)];
      
      for i=1:Nu_O(1,pp,bGU)
        //phylotaxxy angle
        w=sumi*Ang_Ph(pp)+i*Ang_Ph(pp);
        Vz=[cos(w) -sin(w) 0;sin(w) cos(w) 0; 0 0 1];    
        V=eye(3,3);   // QIrui
        V=V*Vz*Vy;
        //[X,Y,Z,CP]=Draw_SMB(PL,nbfacesL,FacesL,L,O,V,C);     
        [X,Y,Z,CP]=Draw_SMB_transform(x_B,y_B,z_B,L,O,V,C); 
        
        for i=1:length(X)
          if size(X(i),2)>1 then //a single facet has problem of 'monotonous'
             plot3d(X(i),Y(i),list(Z(i),CP(i)));
             h=get("hdl");
              h.hiddencolor=-CP(i);    
          end
        end        
      end
    end
end
end
//3.female flowers


//4. male flowers

//e.color_mode=-e.color_mode;      




a=gca(); //get current axes
a.rotation_angles=[45,55]; 
a.isoview="on";
a.axes_visible=["off","off","off"];
gfigure.visible='on';
drawnow();
mdelete(GL_SYS_DIR+'parafiles'+SEPARATOR+'tempfile_disp.sci');
