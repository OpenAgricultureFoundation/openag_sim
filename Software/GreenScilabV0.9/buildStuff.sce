mode(-1)

stacksize(5E7)

GL_SYS_DIR=get_absolute_file_path('buildStuff.sce')

if isdef('GreenLablib')//if the lib was alerady been built
   predef(0);
   clear GreenLablib
end

exec(GL_SYS_DIR+'/macros/gl_main.sci');

exec(GL_SYS_DIR+'/macros/Gl_StateOccupy.sci');

exec(GL_SYS_DIR+'/macros/gl_organ_axis.sci');

exec(GL_SYS_DIR+'/macros/gl_env.sci');

exec(GL_SYS_DIR+'/macros/env_fun.sci');

exec(GL_SYS_DIR+'/macros/env_read_target.sci');

exec(GL_SYS_DIR+'/macros/gl_topo_phy.sci');

exec(GL_SYS_DIR+'/macros/gl_expan.sci');

exec(GL_SYS_DIR+'/macros/gl_demand.sci');

exec(GL_SYS_DIR+'/macros/gl_qorg.sci');

exec(GL_SYS_DIR+'/macros/gl_sizorg.sci');

exec(GL_SYS_DIR+'/macros/gl_resistance.sci');

exec(GL_SYS_DIR+'/macros/gl_photosynthsis.sci');

exec(GL_SYS_DIR+'/macros/gl_cross.sci');

exec(GL_SYS_DIR+'/macros/Draw_bending.sci');

exec(GL_SYS_DIR+'/macros/Draw_AngleShift.sci');

exec(GL_SYS_DIR+'/macros/Draw_GetOrgan.sci');

exec(GL_SYS_DIR+'/macros/Draw_AddOrgan.sci');

exec(GL_SYS_DIR+'/macros/Draw_SMB2ID.sci');

exec(GL_SYS_DIR+'/macros/Draw_ID2SMB.sci');

exec(GL_SYS_DIR+'/macros/Draw_read_organ.sci');

exec(GL_SYS_DIR+'/macros/Draw_Skeleton.sci');

exec(GL_SYS_DIR+'/macros/Draw_SMB.sci');

exec(GL_SYS_DIR+'/macros/Draw_3D.sci');

exec(GL_SYS_DIR+'/macros/Draw_Internode.sci');

exec(GL_SYS_DIR+'/macros/Draw_Fruit.sci');

exec(GL_SYS_DIR+'/macros/Draw_Lig.sci');


//for fitting

exec(GL_SYS_DIR+'macros/sim_fit_HiddenPara_vec.sci');

exec(GL_SYS_DIR+'macros/sim_fit_Hidden.sci');

disp('Building GreenLab liberary '+' in ' +GL_SYS_DIR+'macros')
genlib('GreenLablib',GL_SYS_DIR+'macros',%t)


//xdel(winsid()) //close all graphics window


