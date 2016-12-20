

// display biomass production, size of organ, number....

//%%%%%%%% curve of biomass repartition between organs QO(id,p,J) %%%%%%%
//if Flag_demo==0 then
//   x_message('the information will be shown in the workspace of SCILAB');
//end

f = scf() ;
f.figure_name='Environement condition';

[index_env] = find(Flag_environment);
size_index_env = size(index_env,2);
index_env(size_index_env+1) = 4;


i=1:N;data=[];
for id = 1:(size_index_env+1)
    select index_env(id)
    case 1 then data=water_sequence(i); titletext='Water';ylabeltext='W';
    case 2 then data=theta_sequence(i);titletext='Temperature';ylabeltext='T';
    case 3 then data=light_sequence(i);titletext='Light';ylabeltext='L';
    case 4 then data =E(i);titletext='Environement factor';ylabeltext='E';
    end
       
    if size_index_env == 1 then       
        subplot(1,2,id)
        plot(i,data)
        a=gca();
        a.children(1).children.thickness=6;
        a.title.text=titletext ;
        a.title.font_size=3;
        a.x_label.text="Plant age" ;
        a.x_label.font_size=2;
        a.y_label.text=ylabeltext ;
        a.y_label.font_size=2; 
    elseif size_index_env == 0 then
        subplot(1,1,id)
        plot(i,data)
         a=gca();
        a.children(1).children.thickness=6;
        a.title.text=titletext ;
        a.title.font_size=3;
        a.x_label.text="Plant age" ;
        a.x_label.font_size=2;
        a.y_label.text=ylabeltext ;
        a.y_label.font_size=2;
    else
        subplot(2,2,id)
        plot(i,data)
         a=gca();
        a.children(1).children.thickness=6;
        a.title.text=titletext ;
        a.title.font_size=3;
        a.x_label.text="Plant age" ;
        a.x_label.font_size=2;
        a.y_label.text=ylabeltext ;
        a.y_label.font_size=2;
    end
end

