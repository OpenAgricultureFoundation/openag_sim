//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%  For model hidden parameters
//% 2004. 8. Mengzhen KANG,Wulin
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//clear all; close all;

//exec('bin/gl_begin.sci');

xdel(winsid()); //close all graphics window

disp('Using lsqr to estimate GreenLab model parameters.');

//exec(INTER_SYS_DIR+'/bin/glob_declare.sci');
exec(GL_SYS_DIR+'bin'+SEPARATOR+'glob_declare.sci');

// Read parameter file
//if exists('Flag_TCL')//under interface mode
//if 0
if exists('Flag_TCL')
    FileName=ParaFileName;
else //command line mode   
    FileName = xgetfile('*.sci', GL_SYS_DIR+'parafiles',title='open parameter file');        
end
   realFile = FileName;

[Filepath,FileID,Fileextension]=fileparts(FileName);//get file ID 

[fid, %v] = mopen(FileName, 'r');
if %v then
  disp('Parameter file read error.');
  abort;
end

exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_read.sci');
mclose(fid);

// Read target file
if exists('Flag_TCL')//under interface mode
    FileName=DataFileName;
else //command line mode   
    FileName = xgetfile('*.dat', GL_SYS_DIR+'targetfiles',title='open target file');        
end
realFile = FileName;

[fid, %v] = mopen(FileName, 'r');
if %v then
  disp('Target file read error.');
  abort;
end

exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_read_target.sci');

//Load climate data
fun = GL_SYS_DIR+'bin'+SEPARATOR+'env_fun.sci';

[water_sequence, theta_sequence, light_sequence, GC_index] = gl_env(Flag_environment, Flag_sumt, Omega, aux_paras,THETA_BASE, KSUMT, N);

// organ ID:  1 blade, 2 petiel, 3 internode, 4 female flower,  5 male flower, 6 layer, 7 root
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%   T O P O L O G Y  O F    P L A N T ---- C O M P U T I N G    A U T O M A T O N
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printf('Determinist Topological computation ...');timer();

if ~exists('Flag_TCL') then
  Flag_C_code = 1;
  Flag_Sci_code = 0;
end

if Flag_C_code == 1 then
// c
  StateO = Gl_StateOccupy(Tu_O);
  [S,Nb_BI,DL,Nb_O] = topo(N,maxp,nr,RingOption,Nu_Ma,st_j,b_o,br_a,re_a,Flag_pruning,Pruning_delay,T_Pr,Nu_I,rs_A,rs_B,rt_a,Nu_O,Tu_O,StateO); 
end;

if Flag_Sci_code == 1 then
//scilab
  [S,Nb_O,Nb_BI,DL]= gl_topo_phy(N,maxp,Nu_Ma,Nu_I,Nu_O,st_j,b_o,br_a,re_a,rs_A,rs_B,rt_a,T_Pr,Tu_O,Flag_pruning,Pruning_delay,RingOption); 
end;

printf(string(timer())+' seconds.\n');

//exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_topo.sci');

x0      =  x_Para; 

disp('Beginning of fitting process...');

//stop=[1.d-6,1.d-6,1.d-3,20,0,100];

[xval, fvec, info] = lsqrsolve(x0, sim_fit_HiddenPara_Vec, size(target_set,2));

disp('Done...');

select info

case 0 then disp('improper input parameters.')
case 1 then disp('algorithm estimates that the relative error between x and the solution is at most tol.')
case 2 then disp('number of calls to the function reached.')
case 3 then disp('tol is too small. No further improvement in the approximate solution x is possible.')
case 4 then disp('iteration is not making good progress.')

end
printf("\n");

if Flag_C_code == 1 then
printf('executing using C code\n');
end;
if Flag_Sci_code == 1 then
printf('executing using Scilab code\n');
end;

//write the fit parameters into a file named optim\result\FileID_fit.m,which can be used for initial value of next fitting procedure
exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_write_FitPara.sci');

//display figures
exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_output_FitResult.sci');

if exists('Flag_TCL') then
  if Flag_TCL == 0
  x_message('fitting finished.'); 
  mdelete(GL_SYS_DIR+'targetfiles'+SEPARATOR+'targettempfile.sci');
  end
  TCL_EvalFile(GL_SYS_DIR+'inttcl'+SEPARATOR+'fit_result_inscilab.tcl');

end

clear Flag_TCL
