mode(-1)

stacksize(5E7)

GL_SYS_DIR=get_absolute_file_path('builder.sce')

if isdef('GreenLablib')//if the lib was alerady been built
   predef(0);
   clear GreenLablib
end

getf(GL_SYS_DIR+'/macros/gl_main.sci');

getf(GL_SYS_DIR+'/macros/Gl_StateOccupy.sci');

getf(GL_SYS_DIR+'/macros/gl_organ_axis.sci');

getf(GL_SYS_DIR+'/macros/gl_env.sci');

getf(GL_SYS_DIR+'/macros/env_fun.sci');

getf(GL_SYS_DIR+'/macros/env_read_target.sci');

getf(GL_SYS_DIR+'/macros/gl_topo_phy.sci');

getf(GL_SYS_DIR+'/macros/gl_expan.sci');

getf(GL_SYS_DIR+'/macros/gl_demand.sci');

getf(GL_SYS_DIR+'/macros/gl_qorg.sci');

getf(GL_SYS_DIR+'/macros/gl_sizorg.sci');

getf(GL_SYS_DIR+'/macros/gl_resistance.sci');

getf(GL_SYS_DIR+'/macros/gl_photosynthsis.sci');

getf(GL_SYS_DIR+'/macros/gl_cross.sci');

getf(GL_SYS_DIR+'/macros/Draw_bending.sci');

getf(GL_SYS_DIR+'/macros/Draw_AngleShift.sci');

getf(GL_SYS_DIR+'/macros/Draw_GetOrgan.sci');

getf(GL_SYS_DIR+'/macros/Draw_AddOrgan.sci');

getf(GL_SYS_DIR+'/macros/Draw_SMB2ID.sci');

getf(GL_SYS_DIR+'/macros/Draw_ID2SMB.sci');

getf(GL_SYS_DIR+'/macros/Draw_read_organ.sci');

getf(GL_SYS_DIR+'/macros/Draw_Skeleton.sci');

getf(GL_SYS_DIR+'/macros/Draw_SMB.sci');

getf(GL_SYS_DIR+'/macros/Draw_3D.sci');

getf(GL_SYS_DIR+'/macros/Draw_Internode.sci');

getf(GL_SYS_DIR+'/macros/Draw_Fruit.sci');

getf(GL_SYS_DIR+'/macros/Draw_Lig.sci');


//for fitting

getf(GL_SYS_DIR+'/macros/sim_fit_HiddenPara_vec.sci');

getf(GL_SYS_DIR+'/macros/sim_fit_Hidden.sci');

disp('Building GreenLab liberary '+' in ' +GL_SYS_DIR+'macros')
genlib('GreenLablib',GL_SYS_DIR+'macros',%t)


//xdel(winsid()) //close all graphics window


