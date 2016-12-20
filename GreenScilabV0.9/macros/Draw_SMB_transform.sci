function [X,Y,Z,CP]=Draw_SMB_transform(X,Y,Z,L,O,V,C) 

 CP=list();

for i=1:length(X)


  np=size(X(i),1); nf=size(X(i),2);  len=np*nf;
  
  P=[matrix(X(i),1,len); matrix(Y(i),1,len); matrix(Z(i),1,len)];
  
  P=V*P;
  P=L*P;
 
  
  P(1,:)=P(1,:)+O(1);	//x-shift
  P(2,:)=P(2,:)+O(2);	//y-shift
  P(3,:)=P(3,:)+O(3);	//z-shift

  X(i)=matrix(P(1,:),np,nf);
  Y(i)=matrix(P(2,:),np,nf);
  Z(i)=matrix(P(3,:),np,nf);
  
  CP(i)= ones(1,nf)*addcolor(C);
end

endfunction
