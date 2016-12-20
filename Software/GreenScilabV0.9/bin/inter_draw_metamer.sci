//to display a metamer according to the topological parameters

exec(GL_SYS_DIR+'bin/gl_read_tmp.sci');
//p=1;b=2;  // b ----> bp

g=gcf();
//g=scf();
g.figure_name='metamer';
g.visible='off';
drawlater();

//1. Internode
             
     InternodeH =  sqrt(a_bI(pp)) * VI(pp) ^ ((1 + a_aI(pp)) / 2);  //if a_aI(p)=-1, I_H have nothing to do with qi
     InternodeS = sqrt(1 / a_bI(p)) * VI(pp) ^ ((1 - a_aI(pp)) / 2);
     
     D=[InternodeH InternodeS];
     Oo=[0 0 0];Vo=eye(3,3);C=Color_I(1,:);
     
      Nf=8;// number of points for the polygon
      t=linspace(0,2*%pi,Nf);//discretize the angle
      bx=D(2)/2*cos(t); by=D(2)/2*sin(t); //base points coordinates, vectors
      bz1=zeros(1,Nf); //bottom
      bz2=D(1)*ones(1,Nf);//top
      points1=[bx ;by;bz1 ];//points on the bottom
      points2=[bx; by;bz2 ;];//points on the top   
      points=[points1 points2];
         
      XI=[]; YI=[]; ZI=[]; CI=[];
      [XI, YI, ZI, CI]=Draw_Internode(XI, YI, ZI, CI,points,Oo,Vo,C);     
      plot3d(XI,YI,list(ZI,CI)); 
      h=get("hdl");
      h.hiddencolor=-CI;

//2.leaves
if Nu_O(1,pp,bp)>0 then

	filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_L+'.smb';
	//filename = GL_SYS_DIR+'smb'+SEPARATOR+'default.smb';
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
  	O=[0,0,InternodeH];
  	//V=eye(3,3);     // QIrui
  	C=Color_B(1,:);

  //leaf insertion angle
  	Vy=[cos(Ang_O(1,pp,bp)) 0 sin(Ang_O(1,pp,bp)) ;0 1 0;-sin(Ang_O(1,pp,bp)) 0 cos(Ang_O(1,pp,bp))];            
  	  	
  	for i=1:Nu_O(1,pp,bp)
    //phylotaxxy angle
    w=i*Ang_Ph(pp);
    //Vz=[cos(w/180*%pi) -sin(w/180*%pi) 0;sin(w/180*%pi) cos(w/180*%pi) 0; 0 0 1];       	    
    Vz=[cos(w) -sin(w) 0;sin(w) cos(w) 0; 0 0 1];          ////// QIrui
    	    
    V = eye(3,3);   //  QIrUI
    V=Vz*Vy;
	  //V=V*Vz*Vx;
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

//3.female flowers
if Nu_O(2,pp,bp)>0 then

  if Smb_Ff == "0" then
      Smb_Ff = "cube2";
  end;
  
	filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_Ff+'.smb';
	[fid, err] = mopen(filename, 'rb');//open the smb file
	if err
	   PL=[];nbfacesL=0;FacesL=[];return;//disp("File "+filename+" does not exist!");  
	else
	   [PL,nbfacesL,FacesL] = Draw_read_organ(fid,1);  

	end
	mclose(fid);//close the file
	
	D = VF(pp)^(1/3);
	O=[0,0,InternodeH];
  	//V=eye(3,3);     // QIrui
  	C=Color_Ff(2,:);

  //leaf insertion angle
  	//Vx=[sin(Ang_O(2,pp,bp)) 0 cos(Ang_O(2,pp,bp)) ;0 1 0;cos(Ang_O(2,pp,bp)) 0 -sin(Ang_O(2,pp,bp))];   
  	aa=Ang_O(2,pp,bp);
  	Vy=[cos(aa) 0 sin(aa) ;0 1 0;-sin(aa) 0 cos(aa)];
  	for i=1:Nu_O(2,pp,bp)
    //phylotaxxy angle
    	    w=i*Ang_Ph(pp);
    	    //Vz=[cos(w/180*%pi) -sin(w/180*%pi) 0;sin(w/180*%pi) cos(w/180*%pi) 0; 0 0 1];       	    
    	    Vz=[cos(w) -sin(w) 0;sin(w) cos(w) 0; 0 0 1];          ////// QIrui
    	    
    	    V = eye(3,3);   //  QIrUI
    	    //V=Vz*Vx;
	       V=V*Vz*Vy;
    	    [X,Y,Z,CP]=Draw_SMB(PL,nbfacesL,FacesL,D,O,V,C);     
    
	    for i=1:length(X)
  	      if size(X(i),2)>1 then //a single facet has problem of 'monotonous'
    		plot3d(X(i),Y(i),list(Z(i),CP(i)));
          	h=get("hdl");
      		h.hiddencolor=-CP(i);    
  	      end
	    end  
      

  	 end
end;


//4. male flowers
if Nu_O(3,pp,bp)>0 then

  if Smb_Fm == "0" then
      Smb_Fm = "male3";
  end;
  
	filename = GL_SYS_DIR+'smb'+SEPARATOR+Smb_Fm+'.smb';
	[fid, err] = mopen(filename, 'rb');//open the smb file
	if err
	   PL=[];nbfacesL=0;FacesL=[];return;//disp("File "+filename+" does not exist!");  
	else
	   [PL,nbfacesL,FacesL] = Draw_read_organ(fid,1);  

	end
	mclose(fid);//close the file
	
	
	D = VF(pp)^(1/3);
	O=[0,0,InternodeH];
  	//V=eye(3,3);     // QIrui
  	C=Color_Fm(1,:);

  //leaf insertion angle
  	Vx=[sin(Ang_O(3,pp,bp)) 0 cos(Ang_O(3,pp,bp)) ;0 1 0;cos(Ang_O(3,pp,bp)) 0 -sin(Ang_O(3,pp,bp))];  

  	for i=1:Nu_O(3,pp,bp)
    //phylotaxxy angle
    	    w=i*Ang_Ph(pp);
    	    //Vz=[cos(w/180*%pi) -sin(w/180*%pi) 0;sin(w/180*%pi) cos(w/180*%pi) 0; 0 0 1];       	    
    	    Vz=[cos(w) -sin(w) 0;sin(w) cos(w) 0; 0 0 1];          ////// QIrui
    	    
    	    V = eye(3,3);   //  QIrUI
    	    //V=Vz*Vx;
	    V=V*Vz*Vx;
    	    [X,Y,Z,CP]=Draw_SMB(PL,nbfacesL,FacesL,D,O,V,C);     
    
	    for i=1:length(X)
  	      if size(X(i),2)>1 then //a single facet has problem of 'monotonous'
    		plot3d(X(i),Y(i),list(Z(i),CP(i)));
          	h=get("hdl");
      		h.hiddencolor=-CP(i);    
  	      end
	    end  
      

  	 end
end;
//e.color_mode=-e.color_mode;      
a=gca(); //get current axes
a.rotation_angles=[45,55]; 
a.isoview="on";
a.axes_visible=["off","off","off"];
g.visible='on';
drawnow();
mdelete(GL_SYS_DIR+'parafiles'+SEPARATOR+'tempfile_disp.sci');
