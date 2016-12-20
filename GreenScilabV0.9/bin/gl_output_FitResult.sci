// display calibration results with figures


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//                 display target and fit curve
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NumFig=0;hd=[];
for typ=1:TargetType
  for p=1:maxp              
    if C_Tar(typ,p)==1 then
       NumFig=NumFig+1;
       f= scf() ;
       hd=[hd f];
    end
  end
end

sump=0;sumt=0;
for h=1:NumPlt
  age=CASample(h);
  NumFig=0;
  for p=1:maxp          

    select LoDSample(h,p)

    case 0 //detailed data
      for typ=1:TargetType
        len=min(age,Nu_Ma(p))-PosLowestGU(1,p)+1;
        pos=1+PosLowestGU(1,p)-1:len+PosLowestGU(1,p)-1;
        if C_Tar(typ,p)==1 then
          NumFig=NumFig+1;
      			 f = scf(hd(NumFig)) ;    			
      			 //f = scf() ;    			
      			 //f.visible='off';
      			 temp_theo=matrix(model_set(sumt+1:sumt+len),1,len);
          plot(pos, temp_theo,style=2);
      			       			
          temp_target=matrix(target_set(sumt+1:sumt+len),1,len);
          plot(pos,temp_target(1,:),'ro+' );
          sumt=sumt+len;


          FigureName=['Blade Weight' 'Petiole Weight' 'Internode Weight' 'Female Weight' 'Male Weight' 'Blade Area' 'Internode Area' 'Internode Length'];
          AxisName=['Weight(g)' 'Weight(g)' 'Weight(g)' 'Weight(g)' 'Weight(g)' 'Area(cm^2)'  'Area(cm^2)'  'Length(cm)'];

          f.figure_name=strcat(['Fitting Results on ' FigureName(typ) ' of PA ' string(p)]);
          a=gca();
          a.x_label.text="Phytomer rank" ;
          a.y_label.text=AxisName(typ);
          a.y_label.font_size=3;
          a.x_label.font_size=3;
          a.title.text=FigureName(typ);
          a.title.font_size=4;
          a.children(2).children(1).thickness=3;
          a.data_bounds(1,2)=0;//the minimum value of y axis is 0
          //f.visible='on';
        end      	
      end//typ

    case 1 //compartment data
      for typ=1:TargetType
        if C_Tar(typ,p)==1 then
          NumFig=NumFig+1
      		  f = scf(hd(NumFig)) ;    			
        		temp_theo=model_set(sumt+1);//the model output
        		temp_target=target_set(sumt+1);//
          plot(age, temp_theo,'*' )
          plot(age, temp_target,'ro+' )
          sumt=sumt+1;
          
          FigureName=['Blade Weight' 'Petiole Weight' 'Internode Weight' 'Female Weight' 'Male Weight' 'Blade Area' 'Internode Area' 'Internode Length'];
          AxisName=['Weight(g)' 'Weight(g)' 'Weight(g)' 'Weight(g)' 'Weight(g)' 'Area(cm^2)'  'Area(cm^2)'  'Length(cm)'];

          f.figure_name=strcat(['Fitting Results on ' FigureName(typ) ' of PA ' string(p)]);
          a=gca();
          a.x_label.text="Phytomer rank" ;
          a.y_label.text=AxisName(typ);
          a.y_label.font_size=3;
          a.x_label.font_size=3;
          a.title.text=FigureName(typ);
          a.title.font_size=4;
          a.children(2).children(1).thickness=3;
          a.data_bounds(1,2)=0;//the minimum value of y axis is 0
          
          
          
        end
      end
    end
  end
end

