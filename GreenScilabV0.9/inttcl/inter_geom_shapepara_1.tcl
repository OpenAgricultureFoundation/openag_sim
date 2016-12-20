proc set_shapepara_new {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "Global Geometrical Parameter Setting -- shape"
wm iconname $w "Greenlab"
wm geometry $w 350x120+160+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command shape_new_ok
button $w.buttons.cancel -text "Cancel" -command shape_new_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.f
pack $w.f -side top -fill x -pady 2 -padx 5

label $w.f.lb1 -text "Leaf shape   " -width 20
label $w.f.lb2 -text "female fruit shape    " -width 20
label $w.f.lb3 -text "male fruit shape    " -width 20
button $w.f.lshow -text "show" -command leafshow -width 6
button $w.f.ffshow -text "show" -command femaleshow -width 6
button $w.f.fmshow -text "show" -command maleshow -width 6
button $w.f.lmodi -text "modify" -command leafmodi -width 6
button $w.f.ffmodi -text "modify" -command femalemodi -width 6
button $w.f.fmmodi -text "modify" -command malemodi -width 6
label $w.f.lb -text "    "
label $w.f.lbf -text "    "

grid $w.f.lbf
grid $w.f.lb1 $w.f.lshow $w.f.lb $w.f.lmodi
grid $w.f.lb2 $w.f.ffshow x $w.f.ffmodi
grid $w.f.lb3 $w.f.fmshow x $w.f.fmmodi

init_widget
}

proc init_widget {} {
	global w
	global leafshape
	global fefruitshape
	global mafruitshape
	global inter_Smb_L
	global inter_Smb_Ff
	global inter_Smb_Fm
	global leafmodi
	global fefruitmodi
	global mafruitmodi
	global Flag_show_leaf
	global Flag_show_female
	global Flag_show_male
	
	set Flag_show_leaf 0
	set Flag_show_female 0
	set Flag_show_male 0
	set leafshape $inter_Smb_L
	set fefruitshape $inter_Smb_Ff
	set mafruitshape $inter_Smb_Fm
	set leafmodi $leafshape
	set fefruitmodi $fefruitshape
	set mafruitmodi $mafruitshape
	puts $leafmodi
	
}

proc shape_new_ok {} {
	global w
	global inter_Smb_L
	global inter_Smb_Ff
	global inter_Smb_Fm
	global leafshape
	global fefruitshape
	global mafruitshape
	global leafmodi
	global fefruitmodi
	global mafruitmodi
	
	global Flag_simulate        
        set Flag_simulate 0
	
	set inter_Smb_L $leafmodi
	set inter_Smb_Ff $fefruitmodi
	set inter_Smb_Fm $mafruitmodi
	
	puts $inter_Smb_L
	
	destroy $w
	
	global Flag_test
	global Flag_target
	global Flag_fit
	set Flag_fit 0
	
	global Flag_save_simu
	set Flag_save_simu 0
	global Flag_save_fit
	set Flag_save_fit 0
	
	if {$Flag_test == 1} {
	form_task
	}
	if {$Flag_target == 1} {
	form_fit_task
	}
}

proc shape_new_cancel {} {
	global Flag_simulate 
	global Flag_fit
	global Flag_test
	global Flag_target
	
	global Flag_save_simu
  global Flag_save_fit
  set Flag_save_simu $Flag_save_simu
  set Flag_save_fit $Flag_save_fit
  set Flag_simulate $Flag_simulate
  set Flag_fit $Flag_fit
  
	global w
	destroy $w
}

proc leafshow {} {
	global w
	global inter_Smb_L
	global INTER_SYS_DIR
	global leafshape
  global leafmodi
  
  set leafshape $leafmodi
  
  puts $leafshape
  
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$leafmodi';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}
proc leafmodi {} {
      global leafshape
      global leafmodi
      global INTER_SYS_DIR
      global Flag_show_leaf
	global Flag_show_female
	global Flag_show_male
	
	set Flag_show_leaf 1
	set Flag_show_female 0
	set Flag_show_male 0
      
      ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
      ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_draw_organ.sci');";  
      
}

proc femaleshow {} {
	global w
	global inter_Smb_Ff
	global INTER_SYS_DIR
	global fefruitshape
	global fefruitmodi

	set fefruitshape $fefruitmodi
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$fefruitmodi';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}
proc femalemodi {} {
  global fefruitshape
  global fefruitmodi
  global INTER_SYS_DIR
  global Flag_show_leaf
	global Flag_show_female
	global Flag_show_male
	
	set Flag_show_leaf 0
	set Flag_show_female 1
	set Flag_show_male 0
  ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
  ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_draw_organ.sci');"; 
}

proc maleshow {} {
	global w
	global inter_Smb_Fm
	global INTER_SYS_DIR
	global mafruitshape
	global mafruitmodi

	set mafruitshape $mafruitmodi
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$mafruitmodi';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}
proc malemodi {} {
  global mafruitshape
  global mafruitmodi
  global INTER_SYS_DIR
  global Flag_show_leaf
	global Flag_show_female
	global Flag_show_male
	
	set Flag_show_leaf 0
	set Flag_show_female 0
	set Flag_show_male 1
  ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
  ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_draw_organ.sci');"; 
}
  
