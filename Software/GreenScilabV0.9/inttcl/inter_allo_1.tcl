proc allo_1 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 1 -- Allometry Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 380x170+250+200

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command allo_1_ok
button $w.buttons.cancel -text "Cancel" -command allo_1_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.left
pack $w.left -side left -padx 10 -pady 10
frame $w.right
pack $w.right -side left -padx 10 -pady 10

foreach {i item} {1 "allo_I_b   " 2 "allo_I_a   " 3 "allo_Pe_b" 4 "allo_Pe_a" 5 "allo_B_b   " 6 "allo_B_a   "} {
   label $w.left.lb$i -text $item -width 15
   entry $w.left.en$i -textvariable alloleften$i -width 4
}
foreach {i item} {1 "leaf_thick           " 2 "female_density    " 3 "male_density       " 4 "internode_density"} {
   label $w.right.lb$i -text $item -width 15
   entry $w.right.en$i -textvariable allorighten$i -width 6
}
for {set i 1} {$i<=4} {incr i} {
   grid $w.left.lb$i $w.left.en$i
   grid $w.right.lb$i $w.right.en$i
}
grid $w.left.lb5 $w.left.en5
grid $w.left.lb6 $w.left.en6

init_widget
}

proc init_widget {} {
	global inter_a_bI
	global inter_a_aI
	global inter_a_bP
	global inter_a_aP
	global inter_Th_B
	global inter_Den_Ff
	
        global inter_Den_Fm
        global inter_Den_I
        
  global inter_a_aB
	global inter_a_bB
        
	for {set i 1} {$i<=6} {incr i} {
	   global alloleften$i
	}
	for {set i 1} {$i<=4} {incr i} {
	   global allorighten$i
	}
	
	set alloleften5 [lindex $inter_a_bB 0]
	set alloleften6 [lindex $inter_a_aB 0]
	
	set alloleften1 [lindex $inter_a_bI 0]
	set alloleften2 [lindex $inter_a_aI 0]
	set alloleften3 [lindex $inter_a_bP 0]
	set alloleften4 [lindex $inter_a_aP 0]
	set allorighten1 [lindex $inter_Th_B 0]
	set allorighten2 [lindex $inter_Den_Ff 0]
	set allorighten3 [lindex $inter_Den_Fm 0]
	set allorighten4 [lindex $inter_Den_I 0]
}

proc allo_1_ok {} {
	global w
	global inter_a_bI
	global inter_a_aI
	global inter_a_bP
	global inter_a_aP
	global inter_Th_B
	global inter_Den_Ff
        global inter_Den_Fm
        global inter_Den_I
	
	global Flag_simulate        
        set Flag_simulate 0
        
  global inter_a_aB
  global inter_a_bB
  
  set test [lrange $inter_a_bB 1 5]
  set test [linsert $test 0 [$w.left.en5 get]]
	set inter_a_bB [lrange $test 0 5]
  set test [lrange $inter_a_aB 1 5]
  set test [linsert $test 0 [$w.left.en6 get]]
	set inter_a_aB [lrange $test 0 5]
	
	set test [lrange $inter_a_bI 1 5]
	set test [linsert $test 0 [$w.left.en1 get]]
	set inter_a_bI [lrange $test 0 5]
	set test [lrange $inter_a_aI 1 5]
	set test [linsert $test 0 [$w.left.en2 get]]
	set inter_a_aI [lrange $test 0 5]
	set test [lrange $inter_a_bP 1 5]
	set test [linsert $test 0 [$w.left.en3 get]]
	set inter_a_bP [lrange $test 0 5]
	set test [lrange $inter_a_aP 1 5]
	set test [linsert $test 0 [$w.left.en4 get]]
	set inter_a_aP [lrange $test 0 5]
	set test [lrange $inter_Th_B 1 5]
	set test [linsert $test 0 [$w.right.en1 get]]
	set inter_Th_B [lrange $test 0 5]
	set test [lrange $inter_Den_Ff 1 5]
	set test [linsert $test 0 [$w.right.en2 get]]
	set inter_Den_Ff [lrange $test 0 5]
	set test [lrange $inter_Den_Fm 1 5]
	set test [linsert $test 0 [$w.right.en3 get]]
	set inter_Den_Fm [lrange $test 0 5]
	set test [lrange $inter_Den_I 1 5]
	set test [linsert $test 0 [$w.right.en4 get]]
	set inter_Den_I [lrange $test 0 5]
	
	destroy $w
	
	global Flag_test
	global Flag_target
	global Flag_fit
	set Flag_fit 0
	
	global Flag_save_simu
	global Flab_save_fit
	set Flag_save_simu 0
	set Flag_save_fit 0
	
	if {$Flag_test == 1} {
	form_task
	}
	if {$Flag_target == 1} {
	form_task
	}
		
}

proc allo_1_cancel {} {
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
