function [X,Y,Z]=fruit(L1,L2,O,V,C)

//Compute the base points to describe a fruit
//input:
//L:	scale in x direction
//l:	scale in y direction
//O:	starting point of fruit
//v:	vector of fruit
//output:
//fx,fy,fz:points in a fruit

//Compute the rotation angles

N=30;
rz=(L1/3.14/0.618/0.618*0.75)^(1/3);

//rx=1*rz;
rx=0.618*rz;
ry=rx;

//[x,y,z]=ellipsoid(0,0,0,rx,ry,rz,N);
//r=(L1*0.75/3.14)^(1/3);

[x,y,z]=sphere(N);

x=rx*x;y=ry*y;z=rz*z;

x=x;z=z+rz;

M=zeros(3,N+1,N+1);

M(1,:,:)=x;M(2,:,:)=y;M(3,:,:)=z;
M=reshape(M,3,(N+1)*(N+1));
V1=[0 0 1; 0 1 0;1 0 0];
M=V1*M;
M=V*M;
M=reshape(M,3,N+1,N+1);
M(1,:,:)=M(1,:,:)+O(1);M(2,:,:)=M(2,:,:)+O(2);M(3,:,:)=M(3,:,:)+O(3);
x(:,:)=M(1,:,:);y(:,:)=M(2,:,:);z(:,:)=M(3,:,:);

surface_handle=surf(x(:,:),y(:,:),z(:,:));
set(surface_handle,'FaceColor',C,'EdgeColor','none');
endfunction
