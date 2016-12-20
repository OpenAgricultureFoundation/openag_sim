############# inter_topmac_paramdeter.tcl
proc topo_4 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "PA 4 -- Topological Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 450x450+230+150

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command topo_4_ok
button $w.buttons.cancel -text "Cancel" -command topo_4_cancel
### havent finished
button $w.buttons.display -text "Display" -command topo_4_display
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

image create photo metamer1 -file [file join $INTER_SYS_DIR inttcl/met41.gif]
image create photo metamer2 -file [file join $INTER_SYS_DIR inttcl/met42.gif]
label $w.left.bot.l1 -image metamer1
label $w.left.bot.l2 -image metamer2

button $w.left.bot.db1 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_41.tcl]
    source $PATH
    detail_41
}
button $w.left.bot.db2 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_42.tcl]
    source $PATH
    detail_42
}

for {set i 1} {$i<=2} {incr i} {
   label $w.left.bot.lb$i -text "Number" -width 8 -height 4
}
for {set i 1} {$i<=2} {incr i} {
   entry $w.left.bot.en$i -textvariable topo4leften$i -width 4
}
for {set i 1} {$i<=2} {incr i} {
   grid $w.left.bot.l$i $w.left.bot.db$i $w.left.bot.lb$i $w.left.bot.en$i
}

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
   entry $w.right.bot.en$i -textvariable topo4righten$i -width 4
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
	global inter_Nu_I4
	global inter_bu
	global inter_a
	global inter_CB
	global inter_CF
	global inter_CI
	global inter_Flag_pruning
	global inter_Pruning_delay
	
        global topo4chb18
	
        
        for {set i 1} {$i<=14} {incr i} {
            global topo4righten$i
            }
	for {set i 1} {$i<=5} {incr i} {
	    global topo4leften$i
	    set topo4leften$i [lindex $inter_Nu_I4 [expr $i-1]]
	    }
        set topo4righten1 [lindex $inter_Nu_Ma 3]
	set topo4righten2 [lindex $inter_st_j 3]
	set topo4righten3 [lindex $inter_b_o 3]
	set topo4righten4 [lindex $inter_b 3]
	set topo4righten5 [lindex $inter_c 3]
	set topo4righten6 [lindex $inter_Tr 3]
	set topo4righten7 [lindex $inter_br_a 3]
	set topo4righten8 [lindex $inter_re_a 3]
	set topo4righten9 [lindex $inter_rs_A 3]
	set topo4righten10 [lindex $inter_rs_B 3]
	set topo4righten11 [lindex $inter_rt_a 3]  
	set topo4righten12 [lindex $inter_bu 3]
	set topo4righten13 [lindex $inter_a 3] 
	set topo4righten14 [lindex $inter_Pruning_delay 3]
	set topo4chb18 [lindex $inter_Flag_pruning 3]
	
############ change entry's status based on Phy_Age ##########
        if { $inter_maxp == 4} {
             foreach i {2 7 9 10} {
	         $w.right.bot.en$i configure -state disabled
	      }
            } else {
	     foreach i {2 7 9 10} {
	         $w.right.bot.en$i configure -state normal
	      }
            }
	foreach i {4 5 6 12 13} {
	     $w.right.bot.en$i configure -state disabled
	}
}

########## when "ok" button is pushed, confirm the modification 
proc topo_4_ok {} {
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
	global inter_Nu_I4
	global inter_bu
	global inter_a
	global inter_CB
	global inter_CF
	global inter_CI
	global inter_Flag_pruning
	global inter_Pruning_delay
	
        global topo4chb18

        global Flag_simulate        
        set Flag_simulate 0  
	
	set test1 [lrange $inter_Nu_Ma 0 2]
	set test2 [lrange $inter_Nu_Ma 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en1 get]]
	set inter_Nu_Ma [lrange $test 0 5]
	
	set test1 [lrange $inter_st_j 0 2]
	set test2 [lrange $inter_st_j 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en2 get]]
	set inter_st_j [lrange $test 0 5]
	
	set test1 [lrange $inter_b_o 0 2]
	set test2 [lrange $inter_b_o 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en3 get]]
	set inter_b_o [lrange $test 0 5]
	
	set test1 [lrange $inter_b 0 2]
	set test2 [lrange $inter_b 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en4 get]]
	set inter_b [lrange $test 0 5]
	
	set test1 [lrange $inter_c 0 2]
	set test2 [lrange $inter_c 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en5 get]]
	set inter_c [lrange $test 0 5]
	
	set test1 [lrange $inter_Tr 0 2]
	set test2 [lrange $inter_Tr 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en6 get]]
	set inter_Tr [lrange $test 0 5]
	
	set test1 [lrange $inter_br_a 0 2]
	set test2 [lrange $inter_br_a 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en7 get]]
	set inter_br_a [lrange $test 0 5]
	
	set test1 [lrange $inter_re_a 0 2]
	set test2 [lrange $inter_re_a 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en8 get]]
	set inter_re_a [lrange $test 0 5]
	
	set test1 [lrange $inter_rs_A 0 2]
	set test2 [lrange $inter_rs_A 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en9 get]]
	set inter_rs_A [lrange $test 0 5]
	
	set test1 [lrange $inter_rs_B 0 2]
	set test2 [lrange $inter_rs_B 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en10 get]]
	set inter_rs_B [lrange $test 0 5]
	
	set test1 [lrange $inter_rt_a 0 2]
	set test2 [lrange $inter_rt_a 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en11 get]]
	set inter_rt_a [lrange $test 0 5]
	
	set test1 [lrange $inter_bu 0 2]
	set test2 [lrange $inter_bu 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en12 get]]
	set inter_bu [lrange $test 0 5]
	
	set test1 [lrange $inter_a 0 2]
	set test2 [lrange $inter_a 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en13 get]]
	set inter_a [lrange $test 0 5]
	
	set test1 [lrange $inter_Pruning_delay 0 2]
	set test2 [lrange $inter_Pruning_delay 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.bot.en14 get]]
	set inter_Pruning_delay [lrange $test 0 5]
	
	set test1 [lrange $inter_Flag_pruning 0 2]
	set test2 [lrange $inter_Flag_pruning 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $topo4chb18]
	set inter_Flag_pruning [lrange $test 0 5]
	
	set test [lrange $inter_Nu_I4 1 2]
	set test [linsert $test 0 [$w.left.bot.en1 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 2]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.left.bot.en2 get]]
	set inter_Nu_I4 [lrange $test 0 2]
	
	
	
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
proc topo_4_cancel {} {
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

proc topo_4_display {} {
global INTER_SYS_DIR
global w
global inter_Nu_I4
	global inter_Nu_B4
	global inter_Nu_Ff4
	global inter_Nu_Fm4
	global inter_Nu_A4
        global inter_Ang_B4
	global inter_Ang_Ff4
	global inter_Ang_Fm4
	global inter_Ang_A4
	global inter_VI
	global inter_VB
	global inter_VF
		
	set test [$w.left.bot.en1 get]
	lappend test [$w.left.bot.en2 get]

	set Nu_I1 [lrange $test 0 3]
        set Nu_I11 [lindex $Nu_I1 0]
	set Nu_I12 [lindex $Nu_I1 1]
	set Nu_I13 [lindex $inter_Nu_I4 2]
	set Nu_B [lindex $inter_Nu_B4 1]
	set Nu_Ff [lindex $inter_Nu_Ff4 1]
	set Nu_Fm [lindex $inter_Nu_Fm4 1]
	set Nu_A [lindex $inter_Nu_A4 1]
	set Ang_B [lindex $inter_Ang_B4 1]
	set Ang_Ff [lindex $inter_Ang_Ff4 1]
	set Ang_Fm [lindex $inter_Ang_Fm4 1]
	set Ang_A [lindex $inter_Ang_A4 1]
	set VB [lindex $inter_VB 3]
	set VF [lindex $inter_VF 3]
	set VI [lindex $inter_VI 3]	
	
	
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
	ScilabEval "Nu_I1(4) = $Nu_I11;";
	ScilabEval "Nu_I1(5) = $Nu_I12;";
	ScilabEval "Nu_I1(6) = $Nu_I13;";
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
 	ScilabEval "pp= 4;";
	ScilabEval "bp=5;";
	ScilabEval "exec(GL_SYS_DIR + '/bin/inter_draw_GU.sci');";
}


