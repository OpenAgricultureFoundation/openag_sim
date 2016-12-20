#### inter_env_parametre.tcl
proc set_env_parametre { } {

       global w
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "Enviromental Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 720x400+130+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command envpara_ok
button $w.buttons.cancel -text "Cancel" -command envpara_cancel
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.top1
pack $w.top1 -side top -fill both -padx 10 -pady 5
label $w.top1.lb -text "water effect" -width 20
checkbutton $w.top1.en -text "" -variable enven11 -width 1
button $w.top1.b -text "curve" -width 6 -command watercurve

frame $w.top2
pack $w.top2 -side top -fill both -padx 10 -pady 5
label $w.top2.lb1 -text "Soil Water Effect (E_K1)     " -width 40
label $w.top2.lb2 -text "Soil Water Effect (E_K2)     " -width 40
label $w.top2.lb3 -text "Soil budget para (C1)        " -width 40
label $w.top2.lb4 -text "Soil budget para (C2)        " -width 40
label $w.top2.lb5 -text "Initial Soil Water (QSW0)    " -width 40
label $w.top2.lb6 -text "Max Plant Soil Water (QSWMAX)" -width 40
label $w.top2.lb7 -text "Min Plant Soil Water (QSWMIN)" -width 40
label $w.top2.lb8 -text "Max Env Soil Water (QSW_MAX)" -width 40
label $w.top2.lb9 -text "Min Env Soil Water (QSW_MIN)" -width 40
for {set i 1} {$i<=9} {incr i} {
    entry $w.top2.en2$i -textvariable enven2$i -width 6         
    }
    
frame $w.top3
pack $w.top3 -side top -fill both -padx 10 -pady 5
label $w.top3.lb -text "temperature effect" -width 20
checkbutton $w.top3.en -text "" -variable enven31 -width 1
button $w.top3.b -text "curve" -width 6 -command temperaturecurve

frame $w.top4
pack $w.top4 -side top -fill both -padx 10 -pady 5
#label $w.top4.lb1 -text "SumT effect (Flag_sumt)" -width 40
label $w.top4.lb2 -text "Temperature (E_ALPHA)" -width 40
label $w.top4.lb3 -text "Temperature (E_BETA)" -width 40
#label $w.top4.lb4 -text "SumT effect (KSUMT)" -width 40
#label $w.top4.lb5 -text "SumT effect (THETA_BASE)" -width 40
#label $w.top4.lb6 -text "Max Plant Temperature (THETAMAX)" -width 40
#label $w.top4.lb7 -text "Min Plant Temperature (THETAMIN)" -width 40
label $w.top4.lb8 -text "Max Env Temperature (THETA_MAX)" -width 40
label $w.top4.lb9 -text "Min Env Temperature (THETA_MIN)" -width 40
for {set i 1} {$i<=5} {incr i} {
    entry $w.top4.en4$i -textvariable enven4$i -width 6         
    }
for {set i 8} {$i<=9} {incr i} {
    entry $w.top4.en4$i -textvariable enven4$i -width 6         
    }

frame $w.top5
pack $w.top5 -side top -padx 10 -pady 5
label $w.top5.lb -text "light effect" -width 20
checkbutton $w.top5.en -text "" -variable enven51 -width 1
button $w.top5.b -text "curve" -width 6 -command lightcurve

frame $w.top6
pack $w.top6 -side top -padx 10 -pady 5
label $w.top6.lb1 -text "Light (E_A)" -width 40
label $w.top6.lb2 -text "Light (E_B)" -width 40
#label $w.top6.lb3 -text "Max Env Light (LIGHTMAX)" -width 40
#label $w.top6.lb4 -text "Min Env Light (LIGHTMIN)" -width 40
label $w.top6.lb5 -text "Max Env Light (LIGHT_MAX)" -width 40
label $w.top6.lb6 -text "Min Env Light (LIGHT_MIN)" -width 40
label $w.top6.lb7 -text "Potential Codition (E0)" -width 40
for {set i 1} {$i<=7} {incr i} {
    entry $w.top6.en6$i -textvariable enven6$i -width 6         
    }

grid $w.top1.lb $w.top1.en $w.top1.b
grid $w.top2.lb5 $w.top2.en25
grid $w.top2.lb1 $w.top2.en21 $w.top2.lb2 $w.top2.en22
grid $w.top2.lb3 $w.top2.en23 $w.top2.lb4 $w.top2.en24
grid $w.top2.lb6 $w.top2.en26 $w.top2.lb7 $w.top2.en27
grid $w.top2.lb8 $w.top2.en28 $w.top2.lb9 $w.top2.en29
grid $w.top3.lb $w.top3.en $w.top3.b
#grid $w.top4.lb1 $w.top4.en41
grid $w.top4.lb2 $w.top4.en42 $w.top4.lb3 $w.top4.en43
#grid $w.top4.lb4 $w.top4.en44 $w.top4.lb5 $w.top4.en45
#grid $w.top4.lb6 $w.top4.en46 $w.top4.lb7 $w.top4.en47
grid $w.top4.lb8 $w.top4.en48 $w.top4.lb9 $w.top4.en49
grid $w.top5.lb $w.top5.en $w.top5.b
grid $w.top6.lb1 $w.top6.en61 $w.top6.lb2 $w.top6.en62
#grid $w.top6.lb3 $w.top6.en63 $w.top6.lb4 $w.top6.en64
grid $w.top6.lb5 $w.top6.en65 $w.top6.lb6 $w.top6.en66
grid $w.top6.lb7 $w.top6.en67

init_widget

bind $w.top1.en <ButtonRelease-1> waterbutton
bind $w.top3.en <ButtonRelease-1> temperaturebutton
bind $w.top5.en <ButtonRelease-1> lightbutton

}

proc watercurve {} {
global INTER_SYS_DIR
global inter_N
for {set i 1} {$i<=9} {incr i} {
    global enven2$i
}
for {set i 2} {$i<=3} {incr i} {
   global enven4$i
}
for {set i 8} {$i<=9} {incr i} {
    global enven4$i
}
for {set i 1} {$i<=6} {incr i} {
    global enven6$i
}

ScilabEval "N = $inter_N;";
ScilabEval "aa = $enven61;";
ScilabEval "bb = $enven62;";
ScilabEval "alpha = $enven42;";
ScilabEval "bbeta = $enven43;";
ScilabEval "Qsw_min = $enven29;";
ScilabEval "Qsw_max = $enven28;";
ScilabEval "theta_min = $enven49;";
ScilabEval "theta_max = $enven48;";
ScilabEval "light_min = $enven66;";
ScilabEval "light_max = $enven65;";
ScilabEval "Qsw0 = $enven25;";
ScilabEval "c1_c = $enven23;";
ScilabEval "c2_c = $enven24;";
ScilabEval "Qswmin = $enven27;";
ScilabEval " Qswmax = $enven26;";
ScilabEval "temperatureF = 0;";
ScilabEval "lightF = 0;";
ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
ScilabEval "exec(INTER_SYS_DIR + '/bin/env_curve.sci');";
}

proc waterbutton {} {
global w
global enven11

if {$enven11 == 1} {
    $w.top1.b configure -state disabled
    ScilabEval "waterF = 0;";
} else {
    $w.top1.b configure -state normal
    ScilabEval "waterF = 1;";
}

}

proc temperaturecurve {} {
global INTER_SYS_DIR
global inter_N
for {set i 1} {$i<=9} {incr i} {
    global enven2$i
}
for {set i 2} {$i<=3} {incr i} {
   global enven4$i
}
for {set i 8} {$i<=9} {incr i} {
    global enven4$i
}
for {set i 1} {$i<=6} {incr i} {
    global enven6$i
}

ScilabEval "N = $inter_N;";
ScilabEval "aa = $enven61;";
ScilabEval "bb = $enven62;";
ScilabEval "alpha = $enven42;";
ScilabEval "bbeta = $enven43;";
ScilabEval "Qsw_min = $enven29;";
ScilabEval "Qsw_max = $enven28;";
ScilabEval "theta_min = $enven49;";
ScilabEval "theta_max = $enven48;";
ScilabEval "light_min = $enven66;";
ScilabEval "light_max = $enven65;";
ScilabEval "Qsw0 = $enven25;";
ScilabEval "c1_c = $enven23;";
ScilabEval "c2_c = $enven24;";
ScilabEval "Qswmin = $enven27;";
ScilabEval " Qswmax = $enven26;";
ScilabEval "waterF = 0;";
ScilabEval "lightF = 0;";
ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
ScilabEval "exec(INTER_SYS_DIR + '/bin/env_curve.sci');";
}

proc temperaturebutton {} {
global w
global enven31

if {$enven31 == 1} {
    $w.top3.b configure -state disabled
    ScilabEval "temperatureF = 0;";
} else {
    $w.top3.b configure -state normal
    ScilabEval "temperatureF = 1;";
}

}

proc lightcurve {} {
global INTER_SYS_DIR
global inter_N
for {set i 1} {$i<=9} {incr i} {
    global enven2$i
}
for {set i 2} {$i<=3} {incr i} {
   global enven4$i
}
for {set i 8} {$i<=9} {incr i} {
    global enven4$i
}
for {set i 1} {$i<=6} {incr i} {
    global enven6$i
}

ScilabEval "N = $inter_N;";
ScilabEval "aa = $enven61;";
ScilabEval "bb = $enven62;";
ScilabEval "alpha = $enven42;";
ScilabEval "bbeta = $enven43;";
ScilabEval "Qsw_min = $enven29;";
ScilabEval "Qsw_max = $enven28;";
ScilabEval "theta_min = $enven49;";
ScilabEval "theta_max = $enven48;";
ScilabEval "light_min = $enven66;";
ScilabEval "light_max = $enven65;";
ScilabEval "Qsw0 = $enven25;";
ScilabEval "c1_c = $enven23;";
ScilabEval "c2_c = $enven24;";
ScilabEval "Qswmin = $enven27;";
ScilabEval " Qswmax = $enven26;";
ScilabEval "waterF = 0;";
ScilabEval "temperatureF = 0;";
ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
ScilabEval "exec(INTER_SYS_DIR + '/bin/env_curve.sci');";
}

proc lightbutton {} {
global w
global enven51

if {$enven51 == 1} {
    $w.top5.b configure -state disabled
    ScilabEval "lightF = 0;";
} else {
    $w.top5.b configure -state normal
    ScilabEval "lightF = 1;";
}

}

proc init_widget {} {
     global w
global inter_Flag_climate
global inter_K1
global inter_K2
global inter_C1
global inter_C2
global inter_QSW0
global inter_QSWMAX
global inter_QSWMIN
global inter_QSW_MAX
global inter_QSW_MIN
global inter_Flag_temperature
global inter_Flag_sumt
global inter_E_ALPHA
global inter_E_BETA
global inter_KSUMT
global inter_THETA_BASE
global inter_THETAMAX
global inter_THETAMIN
global inter_THETA_MAX
global inter_THETA_MIN
global inter_Flag_light
global inter_E_A
global inter_E_B
global inter_LIGHTMAX
global inter_LIGHTMIN
global inter_LIGHT_MAX
global inter_LIGHT_MIN
global inter_E0
     global inter_maxp   
     
     for {set i 1} {$i<=9} {incr i} {
               global enven2$i
         }
     global enven11
     for {set i 1} {$i<=5} {incr i} {
               global enven4$i
         }
     for {set i 8} {$i<=9} {incr i} {
               global enven4$i
         }
     global enven31 
     for {set i 1} {$i<=7} {incr i} {
               global enven6$i
         }
     global enven51     
     
     set enven11 $inter_Flag_climate
     set enven31 $inter_Flag_temperature
     set enven51 $inter_Flag_light
     
     set enven21 $inter_K1
     set enven22 $inter_K2
     set enven23 $inter_C1
     set enven24 $inter_C2
     set enven25 $inter_QSW0
     set enven26 $inter_QSWMAX
     set enven27 $inter_QSWMIN
     set enven28 $inter_QSW_MAX
     set enven29 $inter_QSW_MIN
     
     #set enven41 $inter_Flag_sumt
     set enven42 $inter_E_ALPHA
     set enven43 $inter_E_BETA
     #set enven44 $inter_KSUMT
     #set enven45 $inter_THETA_BASE
     #set enven46 $inter_THETAMAX
     #set enven47 $inter_THETAMIN
     set enven48 $inter_THETA_MAX
     set enven49 $inter_THETA_MIN
     
     set enven61 $inter_E_A
     set enven62 $inter_E_B
     #set enven63 $inter_LIGHTMAX
     #set enven64 $inter_LIGHTMIN
     set enven65 $inter_LIGHT_MAX
     set enven66 $inter_LIGHT_MIN
     set enven67 $inter_E0   
     
     if {$enven11 == 1} {
        $w.top1.b configure -state normal
        ScilabEval "waterF = 1;";
     } else {
        $w.top1.b configure -state disabled
        ScilabEval "waterF = 0;";
     }
     if {$enven31 == 1} {
        $w.top3.b configure -state normal
        ScilabEval "temperatureF = 1;";
     } else {
        $w.top3.b configure -state disabled
        ScilabEval "temperatureF = 0;";
     }
     if {$enven51 == 1} {
        $w.top5.b configure -state normal
        ScilabEval "lightF = 1;";
     } else {
        $w.top5.b configure -state disabled
        ScilabEval "lightF = 0;";
     }
     	
}

########## when "ok" button is pushed, confirm the modification 
proc envpara_ok {} {
        global w
global inter_Flag_climate
global inter_K1
global inter_K2
global inter_C1
global inter_C2
global inter_QSW0
global inter_QSWMAX
global inter_QSWMIN
global inter_QSW_MAX
global inter_QSW_MIN
global inter_Flag_temperature
global inter_Flag_sumt
global inter_E_ALPHA
global inter_E_BETA
global inter_KSUMT
global inter_THETA_BASE
global inter_THETAMAX
global inter_THETAMIN
global inter_THETA_MAX
global inter_THETA_MIN
global inter_Flag_light
global inter_E_A
global inter_E_B
global inter_LIGHTMAX
global inter_LIGHTMIN
global inter_LIGHT_MAX
global inter_LIGHT_MIN
global inter_E0
global enven11
global enven31
global enven51

        global Flag_simulate        
        set Flag_simulate 0  

     set inter_Flag_climate $enven11
     set inter_K1 [$w.top2.en21 get]
     set inter_K2 [$w.top2.en22 get]
     set inter_C1 [$w.top2.en23 get]
     set inter_C2 [$w.top2.en24 get]
     set inter_QSW0 [$w.top2.en25 get]
     set inter_QSWMAX [$w.top2.en26 get]
     set inter_QSWMIN [$w.top2.en27 get]
     set inter_QSW_MAX [$w.top2.en28 get]
     set inter_QSW_MIN [$w.top2.en29 get]
     set inter_Flag_temperature $enven31
     #set inter_Flag_sumt [$w.top4.en41 get]
     set inter_E_ALPHA [$w.top4.en42 get]
     set inter_E_BETA [$w.top4.en43 get]
     #set inter_KSUMT [$w.top4.en44 get]
     #set inter_THETA_BASE [$w.top4.en45 get]
     #set inter_THETAMAX [$w.top4.en46 get]
     #set inter_THETAMIN [$w.top4.en47 get]
     set inter_THETA_MAX [$w.top4.en48 get]
     set inter_THETA_MIN [$w.top4.en49 get]
     set inter_Flag_light $enven51
     set inter_E_A [$w.top6.en61 get]
     set inter_E_B [$w.top6.en62 get]
     #set inter_LIGHTMAX [$w.top6.en63 get]
     #set inter_LIGHTMIN [$w.top6.en64 get]
     set inter_LIGHT_MAX [$w.top6.en65 get]
     set inter_LIGHT_MIN [$w.top6.en66 get]
     set inter_E0 [$w.top6.en67 get]     
     
     if {$inter_K1 <=1} {
          tk_messageBox -message "K1 must be greater than 1 !" -type ok
		               return
		    }
		 if {[expr $inter_K1+ $inter_K2] <=2} {
		      tk_messageBox -message "K1+K2 must be greater than 2 !" -type ok
		               return
		    }
     if {$inter_E_ALPHA <=1} {
          tk_messageBox -message "K1 must be greater than 1 !" -type ok
		               return
		    }
		 if {[expr $inter_E_ALPHA+ $inter_E_BETA] <=2} {
		      tk_messageBox -message "K1+K2 must be greater than 2 !" -type ok
		               return
		    }  
		 if {$inter_E_B ==0} {
          tk_messageBox -message "E_B is 0, then Environment efficiency is 0. Plant cannot grow. !" -type ok
		               return
		    }
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
	form_task
	}   
}

########### when "cancel" button is pushed, cancel the modification 
proc envpara_cancel {} {
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



