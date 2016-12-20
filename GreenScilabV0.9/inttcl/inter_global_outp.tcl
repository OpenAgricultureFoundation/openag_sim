proc global_outp {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "Global Output Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 400x430+240+170

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command global_outp_ok
button $w.buttons.cancel -text "Cancel" -command global_outp_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.f1
pack $w.f1 -side top -padx 10 -pady 10
frame $w.f2
pack $w.f2 -side top -padx 10
frame $w.f3 
pack $w.f3 -side top -padx 10 -pady 10
frame $w.f4 
pack $w.f4 -side top -padx 10
frame $w.f5
pack $w.f5 -side top -padx 10 -pady 10
frame $w.f6 
pack $w.f6 -side top -padx 10

label $w.f1.lb -text "data" -width 10
pack $w.f1.lb -side top

label $w.f2.lb1 -text "Total number of organs                      " -width 40
label $w.f2.lb2 -text "Demand and Biomass for layer            " -width 40
label $w.f2.lb3 -text "Plant demand and Biomass production" -width 40

label $w.f3.lb -text "figure" -width 10
pack $w.f3.lb
label $w.f4.lb1 -text "Biomass repartition                           " -width 40
label $w.f4.lb2 -text "Q / D                                                " -width 40
label $w.f4.lb3 -text "Biomasss repartition accumulated     " -width 40
label $w.f4.lb4 -text "leaf area index                                 " -width 40

label $w.f5.lb -text "3D" -width 10
pack $w.f5.lb
label $w.f6.lb1 -text "Draw leaf                                              " -width 40
label $w.f6.lb2 -text "Draw fruit                                              " -width 40
label $w.f6.lb3 -text "light                                                       " -width 40
label $w.f6.lb4 -text "export lig file                                          " -width 40
label $w.f6.lb5 -text "Draw Skeleton for all topology structure" -width 40
#label $w.f6.lb6 -text "Skeleton line thickness                           " -width 40
checkbutton $w.f2.chb1 -variable globoutpchb1
checkbutton $w.f2.chb2 -variable globoutpchb2
checkbutton $w.f2.chb3 -variable globoutpchb3
checkbutton $w.f4.chb1 -variable globoutpchb4
checkbutton $w.f4.chb2 -variable globoutpchb5
checkbutton $w.f4.chb3 -variable globoutpchb6
checkbutton $w.f6.chb1 -variable globoutpchb7
checkbutton $w.f6.chb2 -variable globoutpchb8
checkbutton $w.f6.chb3 -variable globoutpchb9
checkbutton $w.f6.chb4 -variable globoutpchb10
checkbutton $w.f4.chb4 -variable globoutpchb11
checkbutton $w.f6.chb5 -variable globoutpchb12
#entry $w.f6.en1 -textvariable globoutpen1 -width 2

for {set i 1} {$i<=3} {incr i} {
   grid $w.f2.lb$i $w.f2.chb$i
   }
for {set i 1} {$i<=4} {incr i} {
   grid $w.f4.lb$i $w.f4.chb$i
   }
   
for {set i 1} {$i<=5} {incr i} {
   grid $w.f6.lb$i $w.f6.chb$i
   }
#grid $w.f6.lb6 $w.f6.en1   


init_widget
}

proc init_widget {} {
	global w
	global inter_Flag_topo_disp_s
	global inter_Flag_layer_disp
	global inter_Flag_demand_biomass
	global inter_Flag_biomass_fig
	global inter_Flag_bioprod_fig
	global inter_Flag_biomass_fig_a
	global inter_Flag_disp_LAI
	global inter_Flag_geo_leaf
	global inter_Flag_geo_fruit
	global inter_Flag_geo_light
	global inter_Flag_geo_lig
	global inter_Flag_geo_skeleton
	
	for {set i 1} {$i<=12} {incr i} {
	   global globoutpchb$i
	}
	global globoutpen1
	
	set globoutpchb1 $inter_Flag_topo_disp_s
	set globoutpchb2 $inter_Flag_layer_disp
	set globoutpchb3 $inter_Flag_demand_biomass
	set globoutpchb4 $inter_Flag_biomass_fig
	set globoutpchb5 $inter_Flag_bioprod_fig
	set globoutpchb6 $inter_Flag_biomass_fig_a
	set globoutpchb7 $inter_Flag_geo_leaf
	set globoutpchb8 $inter_Flag_geo_fruit
	set globoutpchb9 $inter_Flag_geo_light
	set globoutpchb10 $inter_Flag_geo_lig
	set globoutpchb11 $inter_Flag_disp_LAI
	set globoutpchb12 [lindex $inter_Flag_geo_skeleton 0]


}

proc global_outp_ok {} {
	global w
	global inter_Flag_topo_disp_s
	global inter_Flag_layer_disp
	global inter_Flag_demand_biomass
	global inter_Flag_biomass_fig
	global inter_Flag_bioprod_fig
	global inter_Flag_biomass_fig_a
	global inter_Flag_disp_LAI
	global inter_Flag_geo_leaf
	global inter_Flag_geo_fruit
	global inter_Flag_geo_light
	global inter_Flag_geo_lig
	global inter_Flag_geo_skeleton
	
	
	for {set i 1} {$i<=12} {incr i} {
	   global globoutpchb$i
	}
	global globoutpen1
	
	set inter_Flag_topo_disp_s $globoutpchb1
	set inter_Flag_layer_disp $globoutpchb2
	set inter_Flag_demand_biomass $globoutpchb3
	set inter_Flag_biomass_fig $globoutpchb4
	set inter_Flag_bioprod_fig $globoutpchb5
	set inter_Flag_biomass_fig_a $globoutpchb6
	set inter_Flag_geo_leaf $globoutpchb7
	set inter_Flag_geo_fruit $globoutpchb8
	set inter_Flag_geo_light $globoutpchb9
	set inter_Flag_geo_lig $globoutpchb10
	set inter_Flag_disp_LAI $globoutpchb11
	set test [lrange $inter_Flag_geo_skeleton 1 5]
	set test [linsert $test 0 $globoutpchb12]
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
	
	ScilabEval "Flag_topo_disp_s = $inter_Flag_topo_disp_s;";
	ScilabEval "Flag_layer_disp = $inter_Flag_layer_disp;";
	ScilabEval "Flag_demand_biomass = $inter_Flag_demand_biomass;";
	ScilabEval "Flag_biomass_fig = $inter_Flag_biomass_fig;";
	ScilabEval "Flag_bioprod_fig = $inter_Flag_bioprod_fig;";
	ScilabEval "Flag_biomass_fig_a = $inter_Flag_biomass_fig_a;";
	ScilabEval "Flag_disp_LAI = $inter_Flag_disp_LAI;";
	ScilabEval "Flag_geo_fruit = $inter_Flag_geo_fruit;";
	ScilabEval "Flag_geo_leaf = $inter_Flag_geo_leaf;";
	ScilabEval "Flag_geo_light = $inter_Flag_geo_light;";
	ScilabEval "Flag_geo_lig = $inter_Flag_geo_lig;";
	ScilabEval "Flag_geo_skeleton(1) = [lindex $inter_Flag_geo_skeleton 0];";

}

proc global_outp_cancel {} {
	global Flag_simulate 
	global Flag_fit
	global Flag_test
	global Flag_target
	
	if {$Flag_test == 1} {
        set Flag_simulate 1
  }
  
  if {$Flag_target == 1} {
  set Flag_fit 1
  }
	global w
	destroy $w
}

