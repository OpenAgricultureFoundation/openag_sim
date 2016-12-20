function [water_sequence, theta_sequence, light_sequence, GC_index] = gl_env(Flag_environment, Flag_sumt, Omega, aux_paras,THETA_BASE, KSUMT, N,envLoc);


//  Control of irrigation, betalaw parameters a,b, initial irrigation date datH2O, irrigation frequence freq


water_sequence = [];
theta_sequence = [];
light_sequence = [];
GC_index=[];

GC_index=[];

// temperature and light environmental conditions
printf 'testing flag';
if or(Flag_environment) then   
 
   //  read environmental target from target file; NOW GENERATE FOR DEBUG 
   [water_sequence, theta_sequence, light_sequence, NUM] = env_read_target(envLoc);  // ADD water_sequence % read from target_file % add LIGHT_MAX, LIGHT_MIN
   //disp(water_sequence);
   //disp("fight it");
   //disp(theta_sequence);
   //disp(light_sequence);
   //disp(NUM);
   
   theta_opt   = (Omega(5)-1)/(Omega(5) + Omega(6) -2) * (aux_paras(4)-aux_paras(3)) + aux_paras(3);
   light_opt   = 1000; // could be 400;
//   if Flag_environment(2) == 0 then
      //theta_sequence = theta_opt * ones(size(theta_sequence));
//      theta_sequence = theta_opt * ones(theta_sequence);
//   end
//   if Flag_environment(3) == 0 then
      //light_sequence = light_opt * ones(size(light_sequence));
//      light_sequence = light_opt * ones(light_sequence);
//   end
   
   // environmental data should be calculated wthin the range, warning message produced
//   if Flag_environment(2) == 1 then
//      index = find(theta_sequence < aux_paras(3));
//      if or(index) then
//         warning('temperature less than THETA_MIN, calculating as THETA_MIN.');
//         theta_sequence(index) = aux_paras(3);
//      end
//      index = find(theta_sequence > aux_paras(4));
//      if or(index) then
///         warning('temperature biger than THETA_MAX, calculating as THETA_MAX.');
//         theta_sequence(index) = aux_paras(4);
//      end
//   end
//   if Flag_environment(3) == 1 then
 //     index = find(light_sequence < aux_paras(5));
//      if or(index) then
 //        warning('light less than LIGHT_MIN, calculating as LIGHT_MIN.');
 //        light_sequence(index) = aux_paras(5);
 //     end
 //     index = find(light_sequence > aux_paras(6));
 //     if or(index) then
 //        warning('light biger than LIGHT_MAX, calculating as LIGHT_MAX.');
 //        light_sequence(index) = aux_paras(6);
  //    end
//   end
   
   //  env_target end
   GC_index = zeros(1,NUM);
   if Flag_sumt  then   // environmental daily sequence data
      //GC_index = daily2GC(theta_sequence, THETA_BASE, KSUMT);
   end
   
   if NUM < N then
      warning('lack of environment data, using optimal environment data.');
      //if Flag_environment(1) == 1 then
         water_sequence(NUM+1:N) = aux_paras(2); // QSW_MAX
      //end
      //if Flag_environment(2) == 1 then
         theta_sequence(NUM+1:N) = theta_opt;
      //end
      //if Flag_environment(3) == 1 then
         light_sequence(NUM+1:N) = light_opt;
      //end
   end

end

endfunction
