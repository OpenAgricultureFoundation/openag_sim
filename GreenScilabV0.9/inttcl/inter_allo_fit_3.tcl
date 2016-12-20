proc allo_fit_3 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 3 -- Allometry Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 380x170+250+200

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command allo_3_ok
button $w.buttons.cancel -text "Cancel" -command allo_3_cancel

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
foreach {i item} {1 "allo_I_b   " 2 "allo_I_a   " 3 "allo_Pe_b" 4 "allo_Pe_a" 5 "allo_a_bB   " 6 "allo_a_aB   "} {
   label $w.left.lb$i -text $item -width 15
   entry $w.left.en$i -textvariable allo3leften$i -width 4
   checkbutton $w.left.chb$i -variable allo3leftchb$i
}
foreach {i item} {1 "leaf_thick          " 2 "female_density  " 3 "male_density    " 4 "node_density     "} {
   label $w.right.lb$i -text $item -width 15
   entry $w.right.en$i -textvariable allo3righten$i -width 6
   checkbutton $w.right.chb$i -variable allo3rightchb$i
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
        
	global inter_a_aB
	global inter_a_bB
        
	for {set i 1} {$i<=6} {incr i} {
	   global allo3leften$i
	}
	for {set i 1} {$i<=4} {incr i} {
	   global allo3righten$i
	   global allo3leftchb$i
	   global allo3rightchb$i
	}
	
	global inter_c_a_bI
	global inter_c_a_aI
	global inter_c_a_bP
	global inter_c_a_aP
	global inter_c_Th_B
	global inter_c_Den_Ff
	global inter_c_Den_Fm
	global inter_c_Den_I
	
	set allo3leftchb1 [lindex $inter_c_a_bI 2]
	set allo3leftchb2 [lindex $inter_c_a_aI 2]
	set allo3leftchb3 [lindex $inter_c_a_bP 2]
	set allo3leftchb4 [lindex $inter_c_a_aP 2]
	set allo3rightchb1 [lindex $inter_c_Th_B 2]
	set allo3rightchb2 [lindex $inter_c_Den_Ff 2]
	set allo3rightchb3 [lindex $inter_c_Den_Fm 2]
	set allo3rightchb4 [lindex $inter_c_Den_I 2]
	
	set allo3leften5 [lindex $inter_a_bB 2]
	set allo3leften6 [lindex $inter_a_aB 2]
	
	set allo3leften1 [lindex $inter_a_bI 2]
	set allo3leften2 [lindex $inter_a_aI 2]
	set allo3leften3 [lindex $inter_a_bP 2]
	set allo3leften4 [lindex $inter_a_aP 2]
	set allo3righten1 [lindex $inter_Th_B 2]
	set allo3righten2 [lindex $inter_Den_Ff 2]
	set allo3righten3 [lindex $inter_Den_Fm 2]
	set allo3righten4 [lindex $inter_Den_I 2]
}

proc allo_3_ok {} {
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
	
	for {set i 1} {$i<=4} {incr i} {
	   global allo3leftchb$i
	   global allo3rightchb$i
	}
	
	global inter_c_a_bI
	global inter_c_a_aI
	global inter_c_a_bP
	global inter_c_a_aP
	global inter_c_Th_B
	global inter_c_Den_Ff
	global inter_c_Den_Fm
	global inter_c_Den_I
	
	set test1 [lrange $inter_c_a_bI 0 1]
	set test2 [lrange $inter_c_a_bI 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3leftchb1]
	set inter_c_a_bI [lrange $test 0 5]
	set test1 [lrange $inter_c_a_aI 0 1]
	set test2 [lrange $inter_c_a_aI 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3leftchb2]
	set inter_c_a_aI [lrange $test 0 5]
	set test1 [lrange $inter_c_a_bP 0 1]
	set test2 [lrange $inter_c_a_bP 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3leftchb3]
	set inter_c_a_bP [lrange $test 0 5]
	set test1 [lrange $inter_c_a_aP 0 1]
	set test2 [lrange $inter_c_a_aP 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3leftchb4]
	set inter_c_a_aP [lrange $test 0 5]
	set test1 [lrange $inter_c_Th_B 0 1]
	set test2 [lrange $inter_c_Th_B 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3rightchb1]
	set inter_c_Th_B [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_Ff 0 1]
	set test2 [lrange $inter_c_Den_Ff 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3rightchb2]
	set inter_c_Den_Ff [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_Fm 0 1]
	set test2 [lrange $inter_c_Den_Fm 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3rightchb3]
	set inter_c_Den_Fm [lrange $test 0 5]
	set test1 [lrange $inter_c_Den_I 0 1]
	set test2 [lrange $inter_c_Den_I 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $allo3rightchb4]
	set inter_c_Den_I [lrange $test 0 5]
	
	set test1 [lrange $inter_a_bB 0 1]
	set test2 [lrange $inter_a_bB 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en5 get]]
	set inter_a_bB [lrange $test 0 5]
	set test1 [lrange $inter_a_aB 0 1]
	set test2 [lrange $inter_a_aB 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en6 get]]
	set inter_a_aB [lrange $test 0 5]
	set test1 [lrange $inter_a_bI 0 1]
	set test2 [lrange $inter_a_bI 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en1 get]]
	set inter_a_bI [lrange $test 0 5]
	set test1 [lrange $inter_a_aI 0 1]
	set test2 [lrange $inter_a_aI 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en2 get]]
	set inter_a_aI [lrange $test 0 5]
	set test1 [lrange $inter_a_bP 0 1]
	set test2 [lrange $inter_a_bP 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en3 get]]
	set inter_a_bP [lrange $test 0 5]
	set test1 [lrange $inter_a_aP 0 1]
	set test2 [lrange $inter_a_aP 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.en4 get]]
	set inter_a_aP [lrange $test 0 5]
	set test1 [lrange $inter_Th_B 0 1]
	set test2 [lrange $inter_Th_B 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.en1 get]]
	set inter_Th_B [lrange $test 0 5]
	set test1 [lrange $inter_Den_Ff 0 1]
	set test2 [lrange $inter_Den_Ff 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.en2 get]]
	set inter_Den_Ff [lrange $test 0 5]
	set test1 [lrange $inter_Den_Fm 0 1]
	set test2 [lrange $inter_Den_Fm 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.en3 get]]
	set inter_Den_Fm [lrange $test 0 5]
	set test1 [lrange $inter_Den_I 0 1]
	set test2 [lrange $inter_Den_I 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.en4 get]]
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

proc allo_3_cancel {} {
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
