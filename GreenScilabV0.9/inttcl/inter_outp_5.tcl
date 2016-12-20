proc outp_5 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 5 -- Output Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 650x200+150+200

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command outp_5_ok
button $w.buttons.cancel -text "Cancel" -command outp_5_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.top
pack $w.top -side top -padx 10 -pady 10

frame $w.bot
pack $w.bot -side top -padx 10 -pady 10

frame $w.bot.left 
pack $w.bot.left -side left
frame $w.bot.right 
pack $w.bot.right -side left

frame $w.bot.left.top 
pack $w.bot.left.top -side top
frame $w.bot.left.bot
pack $w.bot.left.bot -side top

frame $w.bot.right.top 
pack $w.bot.right.top -side top
frame $w.bot.right.bot
pack $w.bot.right.bot -side top

label $w.top.lb1 -text "leaf_display" -width 10
label $w.top.lb2 -text "fruit_display" -width 10
checkbutton $w.top.chb1 -variable op5chb1
checkbutton $w.top.chb2 -variable op5chb2
grid $w.top.lb1 $w.top.chb1 $w.top.lb2 $w.top.chb2

label $w.bot.left.top.lb1 -text "data" -width 10
label $w.bot.right.top.lb1 -text "figure" -width 10
label $w.bot.left.bot.lb1 -text "Number of organs                               " -width 40
label $w.bot.left.bot.lb2 -text "Total number of living organs               " -width 40
label $w.bot.left.bot.lb3 -text "Number of living organ above each GU" -width 40
label $w.bot.left.bot.lb4 -text "Biomass repartition                            " -width 40
label $w.bot.right.bot.lb1 -text "Biomasss of organs " -width 40
label $w.bot.right.bot.lb2 -text "Size of organs         " -width 40
label $w.bot.right.bot.lb3 -text "Draw 3D                 " -width 40
label $w.bot.right.bot.lb4 -text "Draw Skeleton        " -width 40
checkbutton $w.bot.left.bot.chb1 -variable op5chb3
checkbutton $w.bot.left.bot.chb2 -variable op5chb4
checkbutton $w.bot.left.bot.chb3 -variable op5chb5
checkbutton $w.bot.left.bot.chb4 -variable op5chb6
checkbutton $w.bot.right.bot.chb1 -variable op5chb7
checkbutton $w.bot.right.bot.chb2 -variable op5chb8
checkbutton $w.bot.right.bot.chb3 -variable op5chb9
checkbutton $w.bot.right.bot.chb4 -variable op5chb10

grid $w.top.lb1 $w.top.chb1 x x $w.top.lb2 $w.top.chb2
grid $w.bot.left.top.lb1 
for {set i 1} {$i<=4} {incr i} {
   grid $w.bot.left.bot.lb$i $w.bot.left.bot.chb$i
   }
grid $w.bot.right.top.lb1
for {set i 1} {$i<=4} {incr i} {
   grid $w.bot.right.bot.lb$i $w.bot.right.bot.chb$i
   }

   init_widget
}

proc init_widget {} {
	global w
	global inter_Flag_leaf
	global inter_Flag_fruit
	global inter_Flag_topo_disp
	global inter_Flag_topo_disp_l
	global inter_Flag_topo_disp_a
	global inter_Flag_biomass_num
	global inter_Flag_biomass_fig_phy
	global inter_Flag_size_fig_phy
	global inter_Flag_geo_3D
	global inter_Flag_geo_skeleton
	
	for {set i 1} {$i<=10} {incr i} {
	   global op5chb$i
	   }
	   
	set op5chb1 [lindex $inter_Flag_leaf 4]
	set op5chb2 [lindex $inter_Flag_fruit 4]
	set op5chb3 [lindex $inter_Flag_topo_disp 4]
	set op5chb4 [lindex $inter_Flag_topo_disp_l 4]
	set op5chb5 [lindex $inter_Flag_topo_disp_a 4]
	set op5chb6 [lindex $inter_Flag_biomass_num 4]
	set op5chb7 [lindex $inter_Flag_biomass_fig_phy 4]
	set op5chb8 [lindex $inter_Flag_size_fig_phy 4]
	set op5chb9 [lindex $inter_Flag_geo_3D 4]
	set op5chb10 [lindex $inter_Flag_geo_skeleton 4]

}

proc outp_5_ok {} {
	global w
	global inter_Flag_leaf
	global inter_Flag_fruit
	global inter_Flag_topo_disp
	global inter_Flag_topo_disp_l
	global inter_Flag_topo_disp_a
	global inter_Flag_biomass_num
	global inter_Flag_biomass_fig_phy
	global inter_Flag_size_fig_phy
	global inter_Flag_geo_3D
	global inter_Flag_geo_skeleton
	
	
	for {set i 1} {$i<=10} {incr i} {
	   global op5chb$i
	   }
	set test1 [lrange $inter_Flag_leaf 0 3]
	set test2 [lrange $inter_Flag_leaf 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb1]
	set inter_Flag_leaf [lrange $test 0 5]
	set test1 [lrange $inter_Flag_fruit 0 3]
	set test2 [lrange $inter_Flag_fruit 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb2]
	set inter_Flag_fruit [lrange $test 0 5]
	set test1 [lrange $inter_Flag_topo_disp 0 3]
	set test2 [lrange $inter_Flag_topo_disp 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb3]
	set inter_Flag_topo_disp [lrange $test 0 5]
	set test1 [lrange $inter_Flag_topo_disp_l 0 3]
	set test2 [lrange $inter_Flag_topo_disp_l 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb4]
	set inter_Flag_topo_disp_l [lrange $test 0 5]
	set test1 [lrange $inter_Flag_topo_disp_a 0 3]
	set test2 [lrange $inter_Flag_topo_disp_a 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb5]
	set inter_Flag_topo_disp_a [lrange $test 0 5]
	set test1 [lrange $inter_Flag_biomass_num 0 3]
	set test2 [lrange $inter_Flag_biomass_num 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb6]
	set inter_Flag_biomass_num [lrange $test 0 5]
	set test1 [lrange $inter_Flag_biomass_fig_phy 0 3]
	set test2 [lrange $inter_Flag_biomass_fig_phy 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb7]
	set inter_Flag_biomass_fig_phy [lrange $test 0 5]
	set test1 [lrange $inter_Flag_size_fig_phy 0 3]
	set test2 [lrange $inter_Flag_size_fig_phy 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb8]
	set inter_Flag_size_fig_phy [lrange $test 0 5]
	set test1 [lrange $inter_Flag_geo_3D 0 3]
	set test2 [lrange $inter_Flag_geo_3D 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb9]
	set inter_Flag_geo_3D [lrange $test 0 5]
	set test1 [lrange $inter_Flag_geo_skeleton 0 3]
	set test2 [lrange $inter_Flag_geo_skeleton 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $op5chb10]
	set inter_Flag_geo_skeleton [lrange $test 0 5]
	 
	destroy $w
	
	global Flag_test
	global Flag_target
	global Flag_fit
	set Flag_fit 0
	
	if {$Flag_test == 1} {
	form_task
	}
	if {$Flag_target == 1} {
	form_task
	}
	
	ScilabEval "Flag_topo_disp(5) =[lindex $inter_Flag_topo_disp 0];";
	ScilabEval "Flag_topo_disp_l(5) =[lindex $inter_Flag_topo_disp_l 0];";
	ScilabEval "Flag_topo_disp_a(5) =[lindex $inter_Flag_topo_disp_a 0];";
	ScilabEval "Flag_leaf(5) = [lindex $inter_Flag_leaf 0];";
	ScilabEval "Flag_fruit(5) = [lindex $inter_Flag_fruit 0];";
	ScilabEval "Flag_biomass_num(5) = [lindex $inter_Flag_biomass_num 0];";
	ScilabEval "Flag_biomass_fig_phy(5) = [lindex $inter_Flag_biomass_fig_phy 0];";
	ScilabEval "Flag_size_fig_phy(5) = [lindex $inter_Flag_size_fig_phy 0];";
	ScilabEval "Flag_geo_3D(5) = [lindex $inter_Flag_geo_3D 0];";
	ScilabEval "Flag_geo_skeleton(5) = [lindex $inter_Flag_geo_skeleton 0];";
}

proc outp_5_cancel {} {
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

