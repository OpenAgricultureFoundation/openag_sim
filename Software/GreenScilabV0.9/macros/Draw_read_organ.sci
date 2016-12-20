function [P,nbfaces,Faces] = Draw_read_organ(fid,Flag_windows)

// Ouput variables initialisation (not found in input variables)
P=[];
nbfaces=0;
Faces=[];


//****************************************
//  Copyright (c) 2003 LIAMA
//  File name: Draw_read_organ
//  Author: Kang Mengzhen   Version: 1.0   Date: 2003-6-20
//  Read points and their connection from a smb file. If file doesn't exist, return empty matrix
//  Input: smb file name
//  Output: P-point position, nbfaces-number of faces, Faces-number of points in each face(Faces(1).entries) and their indexFaces(2).entries
//History:
//Author           time        version     description
//Kang Mengzhen   
//****************************************

//flag to tell whether it's windows(1) or unix(0) format. For a new lig file, it is unknown
//if MSDOS then
//  Flag_windows=1;
//else
//  Flag_windows=0;
//end


if Flag_windows==1 then
  ltype='l';
  ustype='us';
  ftype='f';
else
  ltype='lb';
  ustype='usl';
  ftype='fb';
end    
    

  
	//read number of surfaces
	nbfaces = mget(1,ltype,fid); 
	
	//read number of points
	nbtot = mget(1,ltype,fid); 
	
	//Faces is a list structure
	Faces=list();
	
	sumbyte = 64;

	for n_face = 1:nbfaces; //for each surface   

 		//read number of points in this surface
 		 nbpts= mget(1,ltype,fid); 

		 type1 = mget(1,ustype,fid); 
		 dim = mget(1,ustype,fid); 

		for f_point = 1:nbpts; //for each point in this surface
 
 			 col = mget(1,ltype,fid); 
 			 
 			 //get index of this point
 			 index(1,f_point) =mget(1,ltype,fid);
 
 			 att = mget(1,ustype,fid);
 		end;

 		temp=list();
  		 //keep number of points 'nbpts' in surface n_face
 		temp(1)= nbpts;
 		//keep the index of all nbpts points in surface n_face
		temp(2)= index;

        Faces(n_face) =temp;
        
        if meof(fid)>0 then
            disp('end of smb file');
            return
         end
	end;

   //disp(nbtot)
	points = [];
	for n = 1:nbtot; //for all points in this organ smb file  
		 points(1,n) = mget(1,ftype,fid);

		 points(2,n) = mget(1,ftype,fid);

		 points(3,n) = mget(1,ftype,fid);

		 //read x,y,z position of point n
 		 points(4,n) = mget(1,ftype,fid);

		 points(5,n) = mget(1,ftype,fid);
 
		 points(6,n) = mget(1,ftype,fid);

		 u = mget(1,ftype,fid);
	
		 v = mget(1,ftype,fid);

 		d = mget(1,ftype,fid);
	end;

//keep xyz position of all points in this organ file
P(1:3,1:nbtot) = points(4:6,:);


V0 = [0 0 -1;0 1 0;1 0 0]; //rotate 270 degree around y axis	to let the primary direction of the leaves in the z direction

P=V0*P;

endfunction
