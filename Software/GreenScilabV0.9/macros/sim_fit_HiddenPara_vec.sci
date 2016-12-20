function [fvec] = sim_fit_HiddenPara_Vec(x,m)
//
// greenlab simulator for parameter estimization
//
//   ydata       -   total plant weight of all GCs
//   x           -   Hidden parameters
//   xdata       -   temperature and light environmental data for all GCs
//   m           - function number

disp(x)

[model_set] = sim_fit_Hidden(x)

//for the missing data, no fitting
for i=1:size(target_i,2)
 Y(target_i(i))=-1; // set them same as constant -1, so that they do not contribute to least square
end

fvec = model_set - target_set;


endfunction
