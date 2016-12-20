//display leaf area index case of field crop
if Flag_disp_LAI==1 then

B_ST=zeros(1,N);
for J=1:N
  for p = 1:maxp;
    for i = 1:J;
      if B_S(p,i,J)>0 & i<=Tu_O(1,1,p) then // leaf exist and still function
        B_ST(J)=B_ST(J)+B_S(p,i,J)*Nb_O(1,1,i,J,J,p);
      end;
    end;
  end
end



if Flag_field==1 then

  LAI=zeros(1,N);
  for J=1:N
    LAI(J)=B_ST(J)/Sp;
  end;

  f = scf() ;
  f.figure_name='leaf area index';
  J=1:N;
  h=plot2d(J,LAI,style=1);  

  a=gca();
  a.children(1).children.thickness=4;
  a.title.text="Leaf area index" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="LAI" ;
  a.y_label.font_size=2;  
  a.data_bounds=[1,0;N,max(LAI)];

else

  f = scf() ;
  f.figure_name='Plant leaf area ';
  J=1:N;
  h=plot2d(J,B_ST,style=1);  

  a=gca();
  a.children(1).children.thickness=4;
  a.title.text="Leaf area" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="Leaf area (cm2)" ;
  a.y_label.font_size=2;  
  a.data_bounds=[1,0;N,max(B_ST)];
end

end
