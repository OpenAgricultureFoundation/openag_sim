function Draw_Skeleton(para,Vs,Os,StrInf,StrId,NumStr,StrSz,data,Color_P)

  
StrID=StrId(para(1),para(2),para(3),para(4),para(5),para(6),para(7));  //find ID of substructure according to the parameter [p i 1 g m]

StrSzcum=cumsum(StrSz);

if StrID>1 then
   offset=StrSzcum(StrID-1);           
else        
   offset=0;   
end;        

for j=offset+1:offset+StrSz(StrID)    
   parao=data(j,2:8);
   V=matrix(data(j,9:20),3,4);   
   V=Vs*V;   
   Vo=V(1:3,1:3);   
   Oo=Os+V(1:3,4)';   
   D=data(j,21:22);   
   select data(j,1)
   case 1 then //internode         
      X=[Oo(1) Oo(1)+D(1)*Vo(1,1)];                                                   
      Y=[Oo(2) Oo(2)+D(1)*Vo(2,1)];                                 
      Z=[Oo(3) Oo(3)+D(1)*Vo(3,1)];        
      clr=addcolor(Color_P(parao(1),:));
      param3d1(X,Y,list(Z,clr*ones(1,2)))
      //h=line(X,Y,Z,'color',Color_P(parao(1),:));                    
      //set(h,'LineWidth',2);                          
   case 4 then //substructure        
      Draw_Skeleton(parao,Vo,Oo,StrInf,StrId,NumStr,StrSz,data,Color_P);      
   end   
end;

endfunction
