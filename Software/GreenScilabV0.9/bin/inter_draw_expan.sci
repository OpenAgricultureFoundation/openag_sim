
// to show expansion curve of organs

xdel(winsid());

Val_exp=zeros(t_ex,1);
s=0;
for i = 1 : t_ex 
  Val_exp(i)= ((i-0.5) / t_ex) ^ ( b_exn - 1) * (1 - (i-0.5) / t_ex ) ^ (b_exp- 1) * (1 / t_ex);
//  s = s+ Val_exp(i);
end;
s = max(Val_exp);

for i=1:t_ex
  Val_exp(i) = Val_exp(i)/s;
end;

i=1:t_ex;
plot2d(i,Val_exp,style=13);
ax=gca();
ax.title.text="expansion curve";
ax.title.font_size=3;
ax.x_label.text="expansion time";
ax.x_label.font_size=2;
ax.y_label.text="expansion rate" ;
ax.y_label.font_size=2;  
ax.data_bounds=[1,0;t_ex,max(Val_exp)+0.3];
ax.children.children.thickness = 3;

