proc allo_fit_4 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 4 -- Allometry Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 380x170+250+200

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command allo_4_ok
button $w.buttons.cancel -text "Cancel" -command allo_4_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.left
pack $w.left -side left -padx 10 -pady 10
frame $w.right
pack $w.right -side left -padx 10 -pady 10

label $w.left.lb -text "fit"
label $w.right.lb -text "fit"
grid x x $w.left.lb
grid x x $w.right.lb

foreach {i item} {1 "allo_I_b   " 2 "allo_I_a   " 3 "allo_Pe_b" 4 "allo_Pe_a" 5 "allo_B_b   " 6 "allo_B_a   "} {
   label $w.left.lb$i -text $item -width 15
   entry $w.left.en$i -textvariable allo4leften$i -width 4
   checkbutton $w.left.chb$i -variable allo4leftchb$i
}
foreach {i item} {1 "leaf_thick          " 2 "female_density  " 3 "male_density    " 4 "node_density     "} {
   label $w.right.lb$i -text $item -width 15
   entry $w.right.en$i -textvariable allo4righten$i -width 6
   checkbutton $w.right.chb$i -variable allo4rightchb$i
}
for {set i 1} {$i<=4} {incr i} {
   grid $w.left.lb$i $w.left.en$i $w.left.chb$i
   grid $w.right.lb$i $w.right.en$i $w.right.chb$i
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
	
	global Flag_simulate        
        set Flag_simulate 0
        
	global inter_a_aB
	global inter_a_bB
	
	global inter_c_a_bI
	global inter_c_a_aI
	global inter_c_a_bP
	global inter_c_a_aP
	global inter_c_Th_B
	global inter_c_Den_Ff
	global inter_c_Den_Fm
	global inter_c_Den_I
        
	for {set i 1} {$i<=6} {incr i} {
	   global allo4leften$i
	}
	for {set i 1} {$i<=4} {incr i} {
	   global allo4righten$i
	   global allo4leftchb$i
	   global allo4rightchb$i
	}
	
	set allo4leftchb1 [lindex $inter_c_a_bI 3]
	set allo4leftchb2 [lindex $inter_c_a_aI 3]
	set allo4leftchb3 [lindex $inter_c_a_bP 3]
	set allo4leftchb4 [lindex $inter_c_a_aP 3]
	set allo4rightchb1 [lindex $inter_c_Th_B 3]
	set allo4rightchb2 [lindex $inter_c_Den_Ff 3]
	set allo4rightchb3 [lindex $inter_c_Den_Fm 3]
	set allo4rightchb4 [lindex $inter_c_Den_I 3]
	
	set allo4leften5 [lindex $inter_a_bB 3]
	set allo4leften6 [lindex $inter_a_aB 3]
	
	set allo4leften1 [lindex $inter_a_bI 3]
	set allo4leften2 [lindex $inter_a_aI 3]
	set allo4leften3 [lindex $inter_a_bP 3]
	set allo4leften4 [lindex $inter_a_aP 3]
	set allo4righten1 [lindex $inter_Th_B 3]
	set allo4righten2 [lindex $inter_Den_Ff 3]
	set allo4righten3 [lindex $inter_Den_Fm 3]
	set allo4righten4 [lindex $inter_Den_I 3]
}

proc allo_4_ok {} {
	global w
	global inter_a_bI
	global inter_a_aI
	global inter_a_bP
	global inter_a_aP
	global inter_Th_B
	global inter_Den_Ff
        global inter_Den_Fm
        global inter_Den_I
        
	global inter_a_bB
	global inter_a_aB
	
	global inter_c_a_bI
	global inter_c_a_aI
	global inter_c_a_bP
	global inter_c_a_aP
	global inter_c_Th_B
	global inter_c_Den_Ff
	global inter_c_Den_Fm
	global inter_c_Den_I
	for {set i 1} {$i<=4} {incr i} {
	   global allo4leftchb$i
	   global allo4rightchb$i
	}
	
	
	set test1 [lrange $inter_c_a_bI 0 2]
	set test2 [lrange $inter_c_a_bI 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4leftchb1]
	set inter_c_a_bI [lrange $test 0 5]
	set test1 [lrange $inter_c_a_aI 0 2]
	set test2 [lrange $inter_c_a_aI 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4leftchb2]
	set inter_c_a_aI [lrange $test 0 5]
	set test1 [lrange $inter_c_a_bP 0 2]
	set test2 [lrange $inter_c_a_bP 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4leftchb3]
	set inter_c_a_bP [lrange $test 0 5]
	set test1 [lrange $inter_c_a_aP 0 2]
	set test2 [lrange $inter_c_a_aP 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4leftchb4]
	set inter_c_a_aP [lrange $test 0 5]
	set test1 [lrange $inter_c_Th_B 0 2]
	set test2 [lrange $inter_c_Th_B 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4rightchb1]
	set inter_c_Th_B [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_Ff 0 2]
	set test2 [lrange $inter_c_Den_Ff 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4rightchb2]
	set inter_c_Den_Ff [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_Fm 0 2]
	set test2 [lrange $inter_c_Den_Fm 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4rightchb3]
	set inter_c_Den_Fm [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_I 0 2]
	set test2 [lrange $inter_c_Den_I 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $allo4rightchb4]
	set inter_c_Den_I [lrange $test 0 5]
	
	set test1 [lrange $inter_a_bB 0 2]
	set test2 [lrange $inter_a_bB 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en5 get]]
	set inter_a_bB [lrange $test 0 5]
	set test1 [lrange $inter_a_aB 0 2]
	set test2 [lrange $inter_a_aB 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en6 get]]
	set inter_a_aB [lrange $test 0 5]
	set test1 [lrange $inter_a_bI 0 2]
	set test2 [lrange $inter_a_bI 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en1 get]]
	set inter_a_bI [lrange $test 0 5]
	set test1 [lrange $inter_a_aI 0 2]
	set test2 [lrange $inter_a_aI 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en2 get]]
	set inter_a_aI [lrange $test 0 5]
	set test1 [lrange $inter_a_bP 0 2]
	set test2 [lrange $inter_a_bP 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en3 get]]
	set inter_a_bP [lrange $test 0 5]
	set test1 [lrange $inter_a_aP 0 2]
	set test2 [lrange $inter_a_aP 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.left.en4 get]]
	set inter_a_aP [lrange $test 0 5]
	set test1 [lrange $inter_Th_B 0 2]
	set test2 [lrange $inter_Th_B 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.en1 get]]
	set inter_Th_B [lrange $test 0 5]
	set test1 [lrange $inter_Den_Ff 0 2]
	set test2 [lrange $inter_Den_Ff 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.en2 get]]
	set inter_Den_Ff [lrange $test 0 5]
	set test1 [lrange $inter_Den_Fm 0 2]
	set test2 [lrange $inter_Den_Fm 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.en3 get]]
	set inter_Den_Fm [lrange $test 0 5]
	set test1 [lrange $inter_Den_I 0 2]
	set test2 [lrange $inter_Den_I 4 5]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.right.en4 get]]
	set inter_Den_I [lrange $test 0 5]
	
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

proc allo_4_cancel {} {
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
