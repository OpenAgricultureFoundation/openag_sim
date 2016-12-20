function [XI, YI, ZI, CI]=Draw_Internode(XI, YI, ZI, CI,points,O,V,C)
//Compute the base points on a regular polygon
// D:diameter of internode
// L:Length of internode
// O: position of a internode
// V: rotation matrix(3*3) of a internode

//D=sqrt(D/pi)*2;

   N=size(points,2)/2;
   xyz=zeros(3,4,N);
 
   points=V*points;//rotate the points
   
   //shift the point
   points(1,:)=points(1,:)+O(1);
   points(2,:)=points(2,:)+O(2);
   points(3,:)=points(3,:)+O(3);
   
   for i=1:N-1
        //information of i-th face
        xyz(:,:,i)=[points(:,i) points(:,i+1) points(:,i+N+1) points(:,i+N)];      
   end
   xyz(:,:,N)=[points(:,N) points(:,1) points(:,N+1) points(:,N+N)];
   
   X=zeros(4,N);Y=zeros(4,N);Z=zeros(4,N);CP=[];
   X(:,:)=xyz(1,:,:);
   Y(:,:)=xyz(2,:,:);
   Z(:,:)=xyz(3,:,:);
   CP=addcolor(C)*ones(1,N);

   XI=[XI X];
   YI=[YI Y];
   ZI=[ZI Z];
   
   tmpc=addcolor(C);
   CI=[CI tmpc*ones(1,N)];

endfunction
