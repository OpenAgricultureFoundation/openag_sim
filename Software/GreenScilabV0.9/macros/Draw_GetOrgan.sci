function [NO,ID,Age,gs,mr,V,O,Sz] = Draw_GetOrgan(NO,ID,Age,gs,mr,V,O,Sz,id,age,g,m,v,o,sz)



NO=NO+1;
ID(NO)=id;

Age(NO,1:length(age)) = age;

gs(NO)=g;    
mr(NO)=m; 

for i=1:3
for j=1:3
V(NO,i,j)=v(i,j);
end
end
//V(NO,:,:) = v;
  

O(NO,1:length(o)) = o;
Sz(NO,1:length(sz)) = sz;
endfunction


