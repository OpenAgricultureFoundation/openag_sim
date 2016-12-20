############# inter_topmac_paramdeter.tcl
proc topo_5 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "PA 5 -- Topological Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 450x450+230+150

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command topo_5_ok
button $w.buttons.cancel -text "Cancel" -command topo_5_cancel
### havent finished
button $w.buttons.display -text "Display" -command topo_5_display
### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel $w.buttons.display -side left -expand 1 -fill y

######### create labels and entries
frame $w.left -padx 3 
pack $w.left -side left -fill x
frame $w.left.top 
pack $w.left.top -side top -fill y
label $w.left.top.lb -text "types of metamers" -width 20
pack $w.left.top.lb -in $w.left.top -side left -fill x 
frame $w.left.bot -padx 15 -pady 5 
pack $w.left.bot -side top

image create photo metamer1 -file [file join $INTER_SYS_DIR inttcl/met51.gif]
label $w.left.bot.l1 -image metamer1

button $w.left.bot.db1 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_51.tcl]
    source $PATH
    detail_51
}

   label $w.left.bot.lb1 -text "Number" -width 8 -height 4
   entry $w.left.bot.en1 -textvariable topo5leften1 -width 4
   grid $w.left.bot.l1 $w.left.bot.db1 $w.left.bot.lb1 $w.left.bot.en1


frame $w.right -padx 3 
pack $w.right -side left -fill x
frame $w.right.top
pack $w.right.top -side top -fill y
label $w.right.top.lb -text "topological parameter" -width 20
pack $w.right.top.lb -in $w.right.top -side left -fill x
frame $w.right.bot -padx 15 -pady 5
pack $w.right.bot -side top


foreach {i item} {1 "Max Number of GU" 2 "Mutation                  " 3 "Reiteration Order      " 4 "Growth Probability    " \
5 "Survive Probability    " 6 "Sample Size              " 7 "Branch Control           " 8 "Reiteration Control    " 9 "Rest Function A        " \
10 "Rest Function B        " 11 "Rymth Ratio              " 12 "Buds Probability        " 13 "Branching Probability" \
14 "Pruning delay             " 18 "Flag_pruning              "} {
  label $w.right.bot.lb$i -text $item -width 20 -height 1
}

for {set i 1} {$i <=14} {incr i} {
   entry $w.right.bot.en$i -textvariable topo5righten$i -width 4
}

for {set i 1} {$i<=14} {incr i} {
   grid $w.right.bot.lb$i $w.right.bot.en$i
}

checkbutton $w.right.bot.chb18 -variable topo3chb18
grid $w.right.bot.lb18 $w.right.bot.chb18

init_widget

}

proc init_widget {} {
        global w
        global inter_Nu_Ma
        global inter_st_j
        global inter_b_o
        global inter_br_a
        global inter_re_a
        global inter_rs_A
        global inter_rs_B
        global inter_rt_a
        global inter_maxp
	global inter_b
	global inter_c
	global inter_Tr
	global inter_Nu_I5
	global inter_bu
	global inter_a
	global inter_CB
	global inter_CF
	global inter_CI
	global inter_Flag_pruning
	global inter_Pruning_delay
	
        global topo5chb18
        
        for {set i 1} {$i<=17} {incr i} {
            global topo5righten$i
            }
	    
	    global topo5leften1
	    set topo5leften1 [lindex $inter_Nu_I5 0]
        set topo5righten1 [lindex $inter_Nu_Ma 4]
	set topo5righten2 [lindex $inter_st_j 4]
	set topo5righten3 [lindex $inter_b_o 4]
	set topo5righten4 [lindex $inter_b 4]
	set topo5righten5 [lindex $inter_c 4]
	set topo5righten6 [lindex $inter_Tr 4]
	set topo5righten7 [lindex $inter_br_a 4]
	set topo5righten8 [lindex $inter_re_a 4]
	set topo5righten9 [lindex $inter_rs_A 4]
	set topo5righten10 [lindex $inter_rs_B 4]
	set topo5righten11 [lindex $inter_rt_a 4]  
	set topo5righten12 [lindex $inter_bu 4]
	set topo5righten13 [lindex $inter_a 4]  
	set topo5righten14 [lindex $inter_Pruning_delay 4]
	set topo5chb18 [lindex $inter_Flag_pruning 4]
	
############ change entry's status based on Phy_Age ##########
        foreach i {2 7 9 10} {
	    $w.right.bot.en$i configure -state disabled
	}
	foreach i {4 5 6 12 13} {
	     $w.right.bot.en$i configure -state disabled
	}
}

########## when "ok" button is pushed, confirm the modification 
proc topo_5_ok {} {
        global w
        global inter_Nu_Ma
        global inter_st_j
        global inter_b_o
        global inter_br_a
        global inter_re_a
        global inter_rs_A
        global inter_rs_B
        global inter_rt_a
	global inter_b
	global inter_c
	global inter_Tr
	global inter_Nu_I5
	global inter_bu
	global inter_a
	global inter_CB
	global inter_CF
	global inter_CI
	global inter_Flag_pruning
	global inter_Pruning_delay
	
        global topo5chb18

        global Flag_simulate        
        set Flag_simulate 0  
	
	set test1 [lrange $inter_Nu_Ma 0 3]
	set test2 [lrange $inter_Nu_Ma 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en1 get]]
	set inter_Nu_Ma [lrange $test 0 5]
	
	set test1 [lrange $inter_st_j 0 3]
	set test2 [lrange $inter_st_j 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en2 get]]
	set inter_st_j [lrange $test 0 5]
	
	set test1 [lrange $inter_b_o 0 3]
	set test2 [lrange $inter_b_o 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en3 get]]
	set inter_b_o [lrange $test 0 5]
	
	set test1 [lrange $inter_b 0 3]
	set test2 [lrange $inter_b 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en4 get]]
	set inter_b [lrange $test 0 5]
	
	set test1 [lrange $inter_c 0 3]
	set test2 [lrange $inter_c 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en5 get]]
	set inter_c [lrange $test 0 5]
	
	set test1 [lrange $inter_Tr 0 3]
	set test2 [lrange $inter_Tr 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en6 get]]
	set inter_Tr [lrange $test 0 5]
	
	set test1 [lrange $inter_br_a 0 3]
	set test2 [lrange $inter_br_a 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en7 get]]
	set inter_br_a [lrange $test 0 5]
	
	set test1 [lrange $inter_re_a 0 3]
	set test2 [lrange $inter_re_a 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en8 get]]
	set inter_re_a [lrange $test 0 5]
	
	set test1 [lrange $inter_rs_A 0 3]
	set test2 [lrange $inter_rs_A 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en9 get]]
	set inter_rs_A [lrange $test 0 5]
	
	set test1 [lrange $inter_rs_B 0 3]
	set test2 [lrange $inter_rs_B 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en10 get]]
	set inter_rs_B [lrange $test 0 5]
	
	set test1 [lrange $inter_rt_a 0 3]
	set test2 [lrange $inter_rt_a 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en11 get]]
	set inter_rt_a [lrange $test 0 5]
	
	set test1 [lrange $inter_bu 0 3]
	set test2 [lrange $inter_bu 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en12 get]]
	set inter_bu [lrange $test 0 5]
	
	set test1 [lrange $inter_a 0 3]
	set test2 [lrange $inter_a 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en13 get]]
	set inter_a [lrange $test 0 5]
	
	set test1 [lrange $inter_Pruning_delay 0 3]
	set test2 [lrange $inter_Pruning_delay 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.right.bot.en14 get]]
	set inter_Pruning_delay [lrange $test 0 5]
	
	set test1 [lrange $inter_Flag_pruning 0 3]
	set test2 [lrange $inter_Flag_pruning 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $topo5chb18]
	set inter_Flag_pruning [lrange $test 0 5]
	
	set test [lrange $inter_Nu_I5 1 1]
	set test [linsert $test 0 [$w.left.bot.en1 get]]
	set inter_Nu_I5 [lrange $test 0 1]
	
	
	
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
proc topo_5_cancel {} {
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
#	form_task
}

proc topo_5_display {} {
global INTER_SYS_DIR
global w
global inter_Nu_I5
	global inter_Nu_B5
	global inter_Nu_Ff5
	global inter_Nu_Fm5
	global inter_Nu_A5
        global inter_Ang_B5
	global inter_Ang_Ff5
	global inter_Ang_Fm5
	global inter_Ang_A5
	global inter_VI
	global inter_VB
	global inter_VF
		
	set test [$w.left.bot.en1 get]

	set Nu_I1 [lrange $test 0 0]
        set Nu_I11 [lindex $Nu_I1 0]
	set Nu_I12 [lindex $inter_Nu_I5 1]
	set Nu_B [lindex $inter_Nu_B5 0]
	set Nu_Ff [lindex $inter_Nu_Ff5 0]
	set Nu_Fm [lindex $inter_Nu_Fm5 0]
	set Nu_A [lindex $inter_Nu_A5 0]
	set Ang_B [lindex $inter_Ang_B5 0]
	set Ang_Ff [lindex $inter_Ang_Ff5 0]
	set Ang_Fm [lindex $inter_Ang_Fm5 0]
	set Ang_A [lindex $inter_Ang_A5 0]
	set VB [lindex $inter_VB 4]
	set VF [lindex $inter_VF 4]
	set VI [lindex $inter_VI 4]	
	
	
	global Flag_test
	global Flag_target
	if {$Flag_test == 1} {
	form_task
	}
	if {$Flag_target == 1} {
	form_fit_task
	}
	
	global t
	global INTER_SYS_DIR
	set temp_test_testfile_disp [file join $INTER_SYS_DIR Parafiles/tempfile_disp.sci]
        set f [open $temp_test_testfile_disp w]
        set line [$t get 0.0 end]
        puts $f $line
        close $f
	
	ScilabEval "Nu_I1(1) = 0;";
	ScilabEval "Nu_I1(2) = 0;";
	ScilabEval "Nu_I1(3) = 0;";
	ScilabEval "Nu_I1(4) = 0;";
	ScilabEval "Nu_I1(5) = $Nu_I11;";
	ScilabEval "Nu_I1(6) = $Nu_I12;";
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
	
	ScilabEval " tmpfile = '$temp_test_testfile_disp';";
 	ScilabEval "pp= 5;";
	ScilabEval "bp=5;";
	ScilabEval "exec(GL_SYS_DIR + '/bin/inter_draw_GU.sci');";
}


