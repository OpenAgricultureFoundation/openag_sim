proc detail_32 {} {
 global dw
############Create a window for General Parametre Setting
label .wind
set dw .wind
catch {destroy $dw}
toplevel $dw
wm title $dw "PA 3 -- metamer parameters"
wm iconname $dw "Greenlab"
wm geometry $dw 320x165+280+240

######### create "ok" and "cancel" buttons
frame $dw.buttons 
button $dw.buttons.ok -text "Ok" -command detail_32_ok
button $dw.buttons.cancel -text "Cancel" -command detail_32_cancel
button $dw.buttons.display -text "Display" -command detail_32_display
pack $dw.buttons -side bottom -fill x -pady 2
pack $dw.buttons.ok $dw.buttons.cancel $dw.buttons.display -side left -expand 1 -fill y

frame $dw.f
pack $dw.f -side top -padx 5 -pady 5
foreach {i item} {1 Leaves 2 female_Fruits 3 male_Fruits 4 Axillary 10 diameter} {
       label $dw.f.lb$i -text $item -width 15
}
foreach {i item} {5 number 6 angle 7 size 8 coefficient 9 "  "} {
       label $dw.f.lb$i -text $item -width 8
}
for {set i 1} {$i<=4} {incr i} {
   for {set j 1} {$j<=4} {incr j} {
      entry $dw.f.en$j$i -textvariable de32en$j$i -width 8
   }
}
grid x $dw.f.lb5 $dw.f.lb6 
grid $dw.f.lb1 $dw.f.en11 $dw.f.en12 
grid $dw.f.lb2 $dw.f.en21 $dw.f.en22  
grid $dw.f.lb3 $dw.f.en31 $dw.f.en32 
grid $dw.f.lb4 $dw.f.en41 $dw.f.en42

init_widget
}

proc init_widget {} {
        global inter_Nu_B3
	global inter_Nu_Ff3
	global inter_Nu_Fm3
	global inter_Nu_A3
        global inter_Ang_B3
	global inter_Ang_Ff3
	global inter_Ang_Fm3
	global inter_Ang_A3
	global inter_VI
	global inter_VB
	global inter_VF

        
        for {set i 1} {$i<=3} {incr i} {
	  for {set j 1} {$j<=4} {incr j} {
               global de32en$j$i
	       }
            }
	set de32en11 [lindex $inter_Nu_B3 1]
	set de32en12 [lindex $inter_Ang_B3 1]
	set de32en21 [lindex $inter_Nu_Ff3 1]
	set de32en22 [lindex $inter_Ang_Ff3 1]
	set de32en31 [lindex $inter_Nu_Fm3 1]
	set de32en32 [lindex $inter_Ang_Fm3 1]
	set de32en41 [lindex $inter_Nu_A3 1]
	set de32en42 [lindex $inter_Ang_A3 1]
	set de32en43 [lindex $inter_VI 2]
	set de32en13 [lindex $inter_VB 2]
	set de32en23 [lindex $inter_VF 2]
	                
}

########## when "ok" button is pushed, confirm the modification 
proc detail_32_ok {} {
        global dw
        global inter_Nu_B3
	global inter_Nu_Ff3
	global inter_Nu_Fm3
	global inter_Nu_A3
        global inter_Ang_B3
	global inter_Ang_Ff3
	global inter_Ang_Fm3
	global inter_Ang_A3
	global inter_VI
	global inter_VB
	global inter_VF
        
        global Flag_simulate        
        set Flag_simulate 0  
	
	set test1 [lindex $inter_Nu_B3 0]
	set test2 [lrange $inter_Nu_B3 2 3]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en11 get]]
	set inter_Nu_B3 [lrange $test 0 4]
	set test1 [lindex $inter_Nu_Ff3 0]
	set test2 [lrange $inter_Nu_Ff3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en21 get]]
	set inter_Nu_Ff3 [lrange $test 0 4]
	set test1 [lindex $inter_Nu_Fm3 0]
	set test2 [lrange $inter_Nu_Fm3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en31 get]]
	set inter_Nu_Fm3 [lrange $test 0 4]
	set test1 [lindex $inter_Nu_A3 0]
	set test2 [lrange $inter_Nu_A3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en41 get]]
	set inter_Nu_A3 [lrange $test 0 4]
	set test1 [lindex $inter_Ang_B3 0]
	set test2 [lrange $inter_Ang_B3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en12 get]]
	set inter_Ang_B3 [lrange $test 0 4]
	set test1 [lindex $inter_Ang_Ff3 0]
	set test2 [lrange $inter_Ang_Ff3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en22 get]]
	set inter_Ang_Ff3 [lrange $test 0 4]
	set test1 [lindex $inter_Ang_Fm3 0]
	set test2 [lrange $inter_Ang_Fm3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en32 get]]
	set inter_Ang_Fm3 [lrange $test 0 4]
	set test1 [lindex $inter_Ang_A3 0]
	set test2 [lrange $inter_Ang_A3 2 4]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$dw.f.en42 get]]
	set inter_Ang_A3 [lrange $test 0 4]
	set test1 [lrange $inter_VB 0 1]
	set test2 [lrange $inter_VB 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$dw.f.en13 get]]
	set inter_VB [lrange $test 0 5]
	set test1 [lrange $inter_VF 0 1]
	set test2 [lrange $inter_VF 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$dw.f.en23 get]]
	set inter_VF [lrange $test 0 5]
	set test1 [lrange $inter_VI 0 1]
	set test2 [lrange $inter_VI 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$dw.f.en43 get]]
	set inter_VI [lrange $test 0 5]
	
        destroy $dw
	
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
proc detail_32_cancel {} {
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
  
	global dw
	destroy $dw
	
	global inter_Nu_I3
	global inter_Nu_B3
	global inter_Nu_Ff3
	global inter_Nu_Fm3
	global inter_Nu_A3
        global inter_Ang_B3
	global inter_Ang_Ff3
	global inter_Ang_Fm3
	global inter_Ang_A3
	global inter_VI
	global inter_VB
	global inter_VF
	
	set Nu_I11 [lindex $inter_Nu_I3 0]
	set Nu_I12 [lindex $inter_Nu_I3 1]
	set Nu_I13 [lindex $inter_Nu_I3 2]
	set Nu_I14 [lindex $inter_Nu_I3 3]
	set Nu_B [lindex $inter_Nu_B3 1]
	set Nu_Ff [lindex $inter_Nu_Ff3 1]
	set Nu_Fm [lindex $inter_Nu_Fm3 1]
	set Nu_A [lindex $inter_Nu_A3 1]
	set Ang_B [lindex $inter_Ang_B3 1]
	set Ang_Ff [lindex $inter_Ang_Ff3 1]
	set Ang_Fm [lindex $inter_Ang_Fm3 1]
	set Ang_A [lindex $inter_Ang_A3 1]
	set VB [lindex $inter_VB 2]
	set VF [lindex $inter_VF 2]
	set VI [lindex $inter_VI 2]	
	
	ScilabEval "Nu_I1(1) = 0";
	ScilabEval "Nu_I1(2) = 0;";
	ScilabEval "Nu_I1(3) = $Nu_I11;";
	ScilabEval "Nu_I1(4) = $Nu_I12;";
	ScilabEval "Nu_I1(5) = $Nu_I13;";
	ScilabEval "Nu_I1(6) = $Nu_I14;";
	ScilabEval "Nu_Organ1(1) = $Nu_B;";	
	ScilabEval "Nu_Organ1(2) = $Nu_Ff;";
	ScilabEval "Nu_Organ1(3) = $Nu_Fm;";
	ScilabEval "Nu_Organ1(4) = $Nu_A;";
	ScilabEval "Ang_Organ1(1) = $Ang_B;";
	ScilabEval "Ang_Organ1(2) = $Ang_Ff;";
	ScilabEval "Ang_Organ1(3) = $Ang_Fm;";
	ScilabEval "Ang_Organ1(4) = $Ang_A;";
	ScilabEval "VB1 = $VB;";
	ScilabEval "VF1 = $VF;";
	ScilabEval "VI1 = $VI;";
}

proc detail_32_display {} {
 global dw
 	global inter_Nu_I3
	set Nu_I11 [lindex $inter_Nu_I3 0]
	set Nu_I12 [lindex $inter_Nu_I3 1]
	set Nu_I13 [lindex $inter_Nu_I3 2]
	set Nu_I14 [lindex $inter_Nu_I3 3]
	set Nu_B [$dw.f.en11 get]
	set Nu_Ff [$dw.f.en21 get]
	set Nu_Fm [$dw.f.en31 get]
	set Nu_A [$dw.f.en41 get]
	set Ang_B [$dw.f.en12 get]
	set Ang_Ff [$dw.f.en22 get]
	set Ang_Fm [$dw.f.en32 get]
	set Ang_A [$dw.f.en42 get]
	set VB [$dw.f.en13 get]
	set VF [$dw.f.en23 get]
	set VI [$dw.f.en43 get]
	
	global Flag_test
	global Flag_target
	if {$Flag_test == 1} {
	form_task
	}
	if {$Flag_target == 1} {
	form_fit_task
	}
	global INTER_SYS_DIR
	global t
	set temp_test_testfile_disp [file join $INTER_SYS_DIR Parafiles/tempfile_disp.sci]
        set f [open $temp_test_testfile_disp w]
        set line [$t get 0.0 end]
        puts $f $line
        close $f
	
	ScilabEval "Nu_I1(1) = 0";
	ScilabEval "Nu_I1(2) = 0;";
	ScilabEval "Nu_I1(3) = $Nu_I11;";
	ScilabEval "Nu_I1(4) = $Nu_I12;";
	ScilabEval "Nu_I1(5) = $Nu_I13;";
	ScilabEval "Nu_I1(6) = $Nu_I14;";
	ScilabEval "Nu_Organ1(1) = $Nu_B;";	
	ScilabEval "Nu_Organ1(2) = $Nu_Ff;";
	ScilabEval "Nu_Organ1(3) = $Nu_Fm;";
	ScilabEval "Nu_Organ1(4) = $Nu_A;";
	ScilabEval "Ang_Organ1(1) = $Ang_B;";
	ScilabEval "Ang_Organ1(2) = $Ang_Ff;";
	ScilabEval "Ang_Organ1(3) = $Ang_Fm;";
	ScilabEval "Ang_Organ1(4) = $Ang_A;";
	ScilabEval "VB1 = $VB;";
	ScilabEval "VF1 = $VF;";
	ScilabEval "VI1 = $VI;";
	
 	ScilabEval "tmpfile = '$temp_test_testfile_disp';";
 	ScilabEval "pp= 3;";
 	ScilabEval "bp= 4;";
 	ScilabEval "exec(GL_SYS_DIR + '/bin/inter_draw_metamer.sci');";
}
