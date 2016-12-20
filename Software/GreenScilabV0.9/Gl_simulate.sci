function []=accessParams(FileName,envFile,outputFile,iteration)
disp(FileName);


//                                                               
//      __|__      __________                                                         * _*_
//      __|__     |  _____   /                                                 _ *\*  |/   \__
//     ___|___    | _______  |                                                     \\| *| _*_ \ 
//      ____      |   |  |   |                                                      || //    \__
//     |_ __|     |   /  |   |   GREENLAB:STRUCTUTRAL and FUNCTIONAL PLANT MODEL    ||//-*      \
//     |____|     |  /    \_ |   Philippe de Reffye, Yan HongPing, Kang MengZhen    | |         
//     |    |     |_________ |   ---copyright LIAMA, INRIA ,1999-2004               | |
//    /    \|              
// 

//mode(0)

set("old_style","off");//use new graphics style
disp("things are going fine:iteration: "+string(iteration));
disp(iteration);
xdel(winsid()); //close all graphics window

//Read parameter file
//if exists('Flag_TCL')//under interface mode
//    FileName=FName;
//else //command line mode   
//    FileName = xgetfile('*.sci', GL_SYS_DIR+'parafiles',title='open parameter file');        
//    realFile = FileName;
//end
//disp(GL_SYS_DIR);
//disp(SEPARATOR);
//GL_SYS_DIR="C:\Program Files (x86)\scilab-4.1\contrib\GreenScilabV0.9\";
//SEPARATOR="\";
[Filepath,FileID,Fileextension]=fileparts(FileName);//get file ID 

[fid, %v] = mopen(FileName, 'r');
if %v then
  disp('Parameter file read error.');
  abort;
end

exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_read.sci');
mclose(fid);

//Load climate data
fun = GL_SYS_DIR+'bin'+SEPARATOR+'env_fun.sci';


[water_sequence, theta_sequence, light_sequence, GC_index] = gl_env(Flag_environment, Flag_sumt, Omega, aux_paras,THETA_BASE, KSUMT, N,envFile);


// organ ID:  1 blade, 2 petiel, 3 internode, 4 female flower,  5 male flower, 6 layer, 7 root
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%   T O P O L O G Y  O F    P L A N T ---- C O M P U T I N G    A U T O M A T O N
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Flag_Gl1=1;
Flag_Gl2=0;

if ~exists('Flag_TCL') then
  Flag_C_code = 1;
  Flag_Sci_code = 0;
end

if Flag_Gl1==1 then
printf('Determinist Topological computation ...');timer();



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
end;

if Flag_Gl2==1 then
  printf('Stochastical Topological computation ...');timer();
  [sqa,sqb,sqbu,sqc,sel,um,umb,uml]=gl_sample(Tr,N,maxp,Nu_Ma,Nu_I,Nu_O,u,rt_a,st_j,a,b,bu,c);
  [S,Nb_O]= gl_topo_phy_stoch(N,maxp,Nu_Ma,Nu_I,Nu_O,st_j,b_o,br_a,re_a,rs_A,rt_a,T_Pr,Tu_O,sqa,sqb,sqbu,sqc,sel,um,umb,uml,Tr,Flag_pruning,Pruning_delay); 
  [MSim,VSim,MSSim,VSSim]=gl_stat_simu(S,N,maxp,Tr,b,bu,c,Nu_Ma,Nu_I,Nu_O,st_j,rt_a);
  [MTh,VTh,MSTh,VSTh]=gl_stat(N,maxp,Nu_I,Nu_O,st_j,Nu_Ma,rt_a,a,c,b,bu);
  gl_display(MTh,VTh,MSTh,VSTh,MSim,VSim,MSSim,VSSim,Tr,S);  // S takes place of Sd
  printf(string(timer())+' seconds.\n');
end;

if Flag_Gl1==1 then
//    compute share of biomass and demand
if Flag_hydro == 1  then      

    printf('Wait, under simulation...');timer();
    
        [MAT_EX,Demand,q_O,q_L,QO,B_S,B_ST,P_H,P_S,I_H,I_S,L_S,Fm_V,Ff_V,R_Struct,Q,QSW,QTW,E] =gl_main(Flag_C_code,Flag_Sci_code,N,maxp,t_exp,Bt_N, Bt_p,S_O, N_SI,kp_SI,Nb_O,Tu_O,...
                             Nb_BI,Q0,dQ0,DL,coff_L,RingOption,a_aI,a_aP,Th_B,Den_Ff,Den_Fm,Den_I,a_bI,a_bP,r_B,r_P,r_R,Sp,rp,kp,...
                             QSW,QTW,water_sequence,theta_sequence, light_sequence,Omega, aux_paras, Flag_environment,QSWMAX,QSWMIN,C1,C2,E,Nu_Ma,u,E0, Flag_field);
    
    printf(string(timer())+' seconds.\n'); 
 
end; //end if hydro 

if Flag_C_code == 1 then
printf('executing using C code\n');
end;
if Flag_Sci_code == 1 then
printf('executing using Scilab code\n');
end;

//if exists('Flag_TCL')
//  if Flag_TCL==1
//    exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_topo.sci');
//  end
//else
//  exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_topo.sci');
//end
  
//display environmental data
//exec('gl_disp_env.sci');
    
//display topological and/or biomass production

exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_result.sci');
outputFolder(outputFile,iteration);
exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_curve.sci');
writeTo(outputFile,iteration);
    
//if exists('Flag_TCL')
//  if Flag_TCL==1
//     exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_curve.sci');
//  end
//else
//     exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_disp_curve.sci');
//end
    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%   G E O M E T R Y  O F    P L A N T 
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


//if exists('Flag_TCL') then
//           
//    if Flag_TCL==1      
//      exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_draw_phy.sci');
//      exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_retrieve_structure.sci');
//    end
    
//else
//
 // if Flag_geometry==1 then
 //     exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_draw_phy.sci');
//      exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_retrieve_structure.sci');
//   end
//end    
//mclose('all') // close all opened files   
end;   // temporary Flag_GL1 ==1
    
disp('Done.')
printf('\n');

if exists('Flag_TCL') then
  if Flag_TCL == 0
  x_message('simulating finished.'); 
   mdelete(GL_SYS_DIR+'parafiles'+SEPARATOR+'tempfile.sci');
  end
end
clear Flag_TCL 
endfunction
