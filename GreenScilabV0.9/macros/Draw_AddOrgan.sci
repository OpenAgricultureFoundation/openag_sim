function Draw_AddOrgan(fidBl,OrganID,age,r,g,m,M,O,D)

// add organ information to structure description file fid
//20*4=80 bytes
//age:p,k,j,i
data1=[OrganID age(1) age(2) age(3) age(4) 1 g m] ; 

for tmpi=1:length(data1)
    mput(data1(tmpi),'l',fidBl);
end

//rotation matrix
data2=matrix(M,1,9) ;                       

//shift vector
data3=matrix(O,1,3) ;                       

//scale factor
data4=matrix(D,1,2) ;                       


data=[data2 data3 data4];

for tmpi=1:length(data)
    mput(data(tmpi),'f',fidBl);
end

//mput(data,'f',fid);  //count=fwrite(fid,data,'float')  ;          

endfunction
