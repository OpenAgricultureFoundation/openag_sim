// draw environment factors' curves,
// water_sequence, temperature_sequence, light_sequence, 
// QTW, E_temperature, E_light

//  Control of irrigation, betalaw parameters a,b, initial irrigation date datH2O, irrigation frequence freq

// temperature and light environmental conditions
 
   //  read environmental target from target file; NOW GENERATE FOR DEBUG 
       Qtw = [];
       et_val_c = [];
       el_val_c = [];
       xdel(winsid());
   [water_sequence_c, theta_sequence_c, light_sequence_c, NUM_c] = env_read_target();  // ADD water_sequence % read from target_file % add LIGHT_MAX, LIGHT_MIN
   //light_min=0;
   //N=1;
   //light_max=1000;
   //alpha=3;
   //bbeta=1;
   //theta_max=40;
   //theta_min=0;
   //theta_opt_c   = (alpha-1)/(alpha + bbeta -2) * (theta_max-theta_min) + theta_min;
   //light_opt_c   = 1000; // could be 400;

   // environmental data should be calculated wthin the range, warning message produced
      index = find(theta_sequence_c < theta_min);
      if mtlb_any(index) then
         warning('temperature less than THETA_MIN, calculating as THETA_MIN.');
         theta_sequence_c(index) = theta_min;
      end
      index = find(theta_sequence_c > theta_max);
      if mtlb_any(index) then
         warning('temperature biger than THETA_MAX, calculating as THETA_MAX.');
         theta_sequence_c(index) = theta_max;
      end

      index = find(light_sequence_c < light_min);
      if mtlb_any(index) then
         warning('light less than LIGHT_MIN, calculating as LIGHT_MIN.');
         light_sequence_c(index) = light_min;
      end
      index = find(light_sequence_c > light_max);
      if mtlb_any(index) then
         warning('light biger than LIGHT_MAX, calculating as LIGHT_MAX.');
         light_sequence_c(index) = light_max;
      end

   //  env_target end
   GC_index = zeros(1,NUM_c);
//   if Flag_sumt  then   // environmental daily sequence data
      //GC_index = daily2GC(theta_sequence, THETA_BASE, KSUMT);
//   end
   
   if NUM_c < N then
      disp("deeznuts")
      warning('lack of environment data, using optimal environment data.');
      //if Flag_environment(1) == 1 then
         water_sequence_c(NUM+1:N) = Qsw_max; // QSW_MAX
      //end
      //if Flag_environment(2) == 1 then
         theta_sequence_c(NUM+1:N) = theta_opt_c;
      //end
      //if Flag_environment(3) == 1 then
         light_sequence_c(NUM+1:N) = light_opt_c;
      //end
   end
   
   Qtw(1) = Qsw0;

for env_index = 1: N
    //et_val  = ones(size(theta));
    x       = (theta_sequence_c(env_index)-theta_min) ./ (theta_max-theta_min);
    xm      = (alpha-1)/(alpha+bbeta-2);
    Normbeta= xm^(alpha-1) .* (1-xm)^(bbeta-1);
    et_val_c(env_index)  = x.^(alpha-1) .* (1-x).^(bbeta-1) /Normbeta;
//    e_val   = e_val * et_val;

    //el_val  = ones(size(light));
    el_val_c(env_index)  = aa * (1-exp(-bb*light_sequence_c(env_index))); 
//    e_val   = e_val * el_val;

    Qtw(env_index+1) = Qtw(env_index)*(1 - c1_c - c2_c*water_sequence_c(env_index))+Qswmin*c1_c+Qswmax*c2_c*water_sequence_c(env_index);
    if Qtw(env_index+1)>Qswmax then
        Qtw(env_index+1) = Qswmax;
    end;
    if Qtw(env_index+1)<Qswmin then
        Qtw(env_index+1) = Qswmin;
    end;

end;


if waterF == 1 then
    i=1:N;
    plot2d(i,water_sequence_c(1:N)',style=[2]);
//    legends(['water irrigation'; 'water in plant'],[2 13], opt = "lr");
    a=gca();
  a.children.children(1).thickness=6;
//  	a.children.children(2).thickness=6;
  a.title.text="water irrigation" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="water" ;
  a.y_label.font_size=2;  
//  a.data_bounds=[1,0;N,max(water_sequence_c)];
end;

if temperatureF == 1 then
    i=1:N;
    subplot(1,2,1);
    plot(i,theta_sequence_c(1:N)');
    a=gca();
  a.children.children(1).thickness=6;
//  	a.children.children(2).thickness=6;
  a.title.text="temperature datum" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="temperature" ;
  a.y_label.font_size=2; 
  a.y_location = "right";
    subplot(1,2,2);
    plot(i,et_val_c);
    a=gca();
  a.children.children(1).thickness=6;
//  	a.children.children(2).thickness=6;
  a.title.text="temperature efficiency" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="efficiency E" ;
  a.y_label.font_size=2;  
end;

if lightF == 1 then
    i=1:N;
    subplot(1,2,1);
    plot(i,light_sequence_c(1:N)');
    a=gca();
  a.children.children(1).thickness=6;
//  	a.children.children(2).thickness=6;
  a.title.text="light intensity" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="light" ;
  a.y_label.font_size=2;  
  a.y_location = "right";
//  a.data_bounds=[1,0;N,max(light_max, max(el_val_c))];
    subplot(1,2,2);
    plot(i,el_val_c);
        a=gca();
  a.children.children(1).thickness=6;
//  	a.children.children(2).thickness=6;
  a.title.text="light efficiency" ;
  a.title.font_size=3;  
  a.x_label.text="Plant Age" ;
  a.x_label.font_size=2;
  a.y_label.text="efficiency E" ;
  a.y_label.font_size=2;  
    
end;


