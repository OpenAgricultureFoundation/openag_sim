############# inter_topmac_paramdeter.tcl
proc topo_1 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "PA 1 -- Topological Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 450x450+230+150

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command topo_1_ok
button $w.buttons.cancel -text "Cancel" -command topo_1_cancel
### havent finished
button $w.buttons.display -text "Display" -command topo_1_display
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

image create photo metamer1 -file [file join $INTER_SYS_DIR inttcl/met11.gif]
image create photo metamer2 -file [file join $INTER_SYS_DIR inttcl/met12.gif]
image create photo metamer3 -file [file join $INTER_SYS_DIR inttcl/met13.gif]
image create photo metamer4 -file [file join $INTER_SYS_DIR inttcl/met14.gif]
image create photo metamer5 -file [file join $INTER_SYS_DIR inttcl/met15.gif]
label $w.left.bot.l1 -image metamer1
label $w.left.bot.l2 -image metamer2
label $w.left.bot.l3 -image metamer3
label $w.left.bot.l4 -image metamer4
label $w.left.bot.l5 -image metamer5

button $w.left.bot.db1 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_11.tcl]
    source $PATH
    detail_11
}
button $w.left.bot.db2 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_12.tcl]
    source $PATH
    detail_12
}
button $w.left.bot.db3 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_13.tcl]
    source $PATH
    detail_13
}
button $w.left.bot.db4 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_14.tcl]
    source $PATH
    detail_14
}
button $w.left.bot.db5 -text "detail" -width 4 -command {
    set PATH [file join $INTER_SYS_DIR inttcl/inter_detail_15.tcl]
    source $PATH
    detail_15
}

for {set i 1} {$i<=5} {incr i} {
   label $w.left.bot.lb$i -text "Number" -width 8 -height 4
}
for {set i 1} {$i<=5} {incr i} {
   entry $w.left.bot.en$i -textvariable leften$i -width 4
}
for {set i 1} {$i<=5} {incr i} {
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
14 "ShortInternode number" 15 "Pruning delay             " 16 "Flag_pruning              "} {
  label $w.right.bot.lb$i -text $item -width 20 -height 1
}

for {set i 1} {$i <=15} {incr i} {
   entry $w.right.bot.en$i -textvariable righten$i -width 4
}

for {set i 1} {$i<=15} {incr i} {
   grid $w.right.bot.lb$i $w.right.bot.en$i
}

checkbutton $w.right.bot.chb16 -variable topo1chb16
grid $w.right.bot.lb16 $w.right.bot.chb16

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
	global inter_Nu_I1
	global inter_bu
	global inter_a
	global inter_CI
	global inter_CB
	global inter_CF
	global inter_N_SI
	global inter_Flag_pruning
	global inter_Pruning_delay
	
        
        for {set i 1} {$i<=15} {incr i} {
            global righten$i
            }
            
            global topo1chb16
	for {set i 1} {$i<=5} {incr i} {
	    global leften$i
	    global chb$i
	    set leften$i [lindex $inter_Nu_I1 [expr $i-1]]
	    }
        set righten1 [lindex $inter_Nu_Ma 0]
	set righten2 [lindex $inter_st_j 0]
	set righten3 [lindex $inter_b_o 0]
	set righten4 [lindex $inter_b 0]
	set righten5 [lindex $inter_c 0]
	set righten6 [lindex $inter_Tr 0]
	set righten7 [lindex $inter_br_a 0]
	set righten8 [lindex $inter_re_a 0]
	set righten9 [lindex $inter_rs_A 0]
	set righten10 [lindex $inter_rs_B 0]
	set righten11 [lindex $inter_rt_a 0]  
	set righten12 [lindex $inter_bu 0]
	set righten13 [lindex $inter_a 0] 
	set righten14 $inter_N_SI  
	set righten15 [lindex $inter_Pruning_delay 0]
	set topo1chb16 [lindex $inter_Flag_pruning 0]
	
############ change entry's status based on Phy_Age ##########
        if { $inter_maxp == 1} {
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
proc topo_1_ok {} {
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
	global inter_Nu_I1
	global inter_bu
	global inter_a
	global inter_CB
	global inter_CF
	global inter_CI
	global inter_N_SI
	global inter_Pruning_delay
	global inter_Flag_pruning
	
	global topo1chb16

        global Flag_simulate        
        set Flag_simulate 0  
	
	set test [lrange $inter_Nu_Ma 1 5]
	set test [linsert $test 0 [$w.right.bot.en1 get]]
	set inter_Nu_Ma [lrange $test 0 5]
	
	set test [lrange $inter_st_j 1 5]
	set test [linsert $test 0 [$w.right.bot.en2 get]]
	set inter_st_j [lrange $test 0 5]
	
	set test [lrange $inter_b_o 1 5]
	set test [linsert $test 0 [$w.right.bot.en3 get]]
	set inter_b_o [lrange $test 0 5]
	
	set test [lrange $inter_b 1 5]
	set test [linsert $test 0 [$w.right.bot.en4 get]]
	set inter_b [lrange $test 0 5]
	
	set test [lrange $inter_c 1 5]
	set test [linsert $test 0 [$w.right.bot.en5 get]]
	set inter_c [lrange $test 0 5]
	
	set test [lrange $inter_Tr 1 5]
	set test [linsert $test 0 [$w.right.bot.en6 get]]
	set inter_Tr [lrange $test 0 5]
	
	set test [lrange $inter_br_a 1 5]
	set test [linsert $test 0 [$w.right.bot.en7 get]]
	set inter_br_a [lrange $test 0 5]
	
	set test [lrange $inter_re_a 1 5]
	set test [linsert $test 0 [$w.right.bot.en8 get]]
	set inter_re_a [lrange $test 0 5]
	
	set test [lrange $inter_rs_A 1 5]
	set test [linsert $test 0 [$w.right.bot.en9 get]]
	set inter_rs_A [lrange $test 0 5]
	
	set test [lrange $inter_rs_B 1 5]
	set test [linsert $test 0 [$w.right.bot.en10 get]]
	set inter_rs_B [lrange $test 0 5]
	
	set test [lrange $inter_rt_a 1 5]
	set test [linsert $test 0 [$w.right.bot.en11 get]]
	set inter_rt_a [lrange $test 0 5]
	
	set test [lrange $inter_bu 1 5]
	set test [linsert $test 0 [$w.right.bot.en12 get]]
	set inter_bu [lrange $test 0 5]
	
	set test [lrange $inter_a 1 5]
	set test [linsert $test 0 [$w.right.bot.en13 get]]
	set inter_a [lrange $test 0 5]
	
	set test [lrange $inter_Pruning_delay 1 5]
	set test [linsert $test 0 [$w.right.bot.en15 get]]
	set inter_Pruning_delay [lrange $test 0 5]
	
	set inter_N_SI [$w.right.bot.en14 get]
	
	set test [lrange $inter_Flag_pruning 1 5]
	set test [linsert $test 0 $topo1chb16]
	set inter_Flag_pruning [lrange $test 0 5]
	
	set test [lrange $inter_Nu_I1 1 5]
	set test [linsert $test 0 [$w.left.bot.en1 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.left.bot.en2 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en3 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.bot.en4 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.left.bot.en5 get]]
	set inter_Nu_I1 [lrange $test 0 5]
	
	
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
proc topo_1_cancel {} {
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

proc topo_1_display {} {
global INTER_SYS_DIR
global w
global inter_Nu_I1
	global inter_Nu_B1
	global inter_Nu_Ff1
	global inter_Nu_Fm1
	global inter_Nu_A1
        global inter_Ang_B1
	global inter_Ang_Ff1
	global inter_Ang_Fm1
	global inter_Ang_A1
	global inter_VI
	global inter_VB
	global inter_VF
		
	set test [$w.left.bot.en1 get]
	for {set i 2} {$i<=5} {incr i} {
	    lappend test [$w.left.bot.en$i get]
	}
	set Nu_I1 [lrange $test 0 4]
        set Nu_I11 [lindex $Nu_I1 0]
	set Nu_I12 [lindex $Nu_I1 1]
	set Nu_I13 [lindex $Nu_I1 2]
	set Nu_I14 [lindex $Nu_I1 3]
	set Nu_I15 [lindex $Nu_I1 4]
	set Nu_I16 [lindex $inter_Nu_I1 5]
	set Nu_B [lindex $inter_Nu_B1 1]
	set Nu_Ff [lindex $inter_Nu_Ff1 1]
	set Nu_Fm [lindex $inter_Nu_Fm1 1]
	set Nu_A [lindex $inter_Nu_A1 1]
	set Ang_B [lindex $inter_Ang_B1 1]
	set Ang_Ff [lindex $inter_Ang_Ff1 1]
	set Ang_Fm [lindex $inter_Ang_Fm1 1]
	set Ang_A [lindex $inter_Ang_A1 1]
	set VB [lindex $inter_VB 0]
	set VF [lindex $inter_VF 0]
	set VI [lindex $inter_VI 0]	
	
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
	
	ScilabEval "Nu_I1(1) = $Nu_I11;";
	ScilabEval "Nu_I1(2) = $Nu_I12;";
	ScilabEval "Nu_I1(3) = $Nu_I13;";
	ScilabEval "Nu_I1(4) = $Nu_I14;";
	ScilabEval "Nu_I1(5) = $Nu_I15;";
	ScilabEval "Nu_I1(6) = $Nu_I16;";
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
 	ScilabEval "pp= 1;";
	ScilabEval "bp=2;";
	ScilabEval "exec(GL_SYS_DIR + '/bin/inter_draw_GU.sci');";
}


