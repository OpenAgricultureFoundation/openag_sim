############# inter_topmac_paramdeter.tcl
proc geo_3 { } {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 3 -- Geometrical Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 450x280+230+150

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command geo_3_ok
button $w.buttons.cancel -text "Cancel" -command geo_3_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

######### create labels and entries
frame $w.left -padx 3 
pack $w.left -side left -fill x
frame $w.left.top 
pack $w.left.top -side top -fill y
label $w.left.top.lb -text "Axis Angle" -width 20
pack $w.left.top.lb -in $w.left.top -side left -fill x 
frame $w.left.bot -padx 15 -pady 5 
pack $w.left.bot -side top

foreach {i item} {1 "Phyllotaxy Angle" 2 "Young Modulus   " 3 "Force Point        " 4 "Terminal Angle   " 5 "Righting Point    " 6 "Min Initial Angle " \
7  "Max Initial Angle" 8 "Num Initial Angle"} {
label $w.left.bot.lb$i -text $item -width 20 
}
for {set i 1} {$i<=8} {incr i} {
   entry $w.left.bot.en$i -textvariable geo3leften$i -width 6
   grid $w.left.bot.lb$i $w.left.bot.en$i
}

frame $w.right -padx 3 
pack $w.right -side left -fill x
frame $w.right.top
pack $w.right.top -side top -fill y
label $w.right.top.lb -text "Organ Angle" -width 20
pack $w.right.top.lb -in $w.right.top -side left -fill x
frame $w.right.bot -padx 15 -pady 5
pack $w.right.bot -side top


foreach {i item} {1 "Max Angle                   " 2 "Openning Cycle            " 3 "Flag_bending_leaf        " \
4 "Flag_bending_fruit       " 5 "Flag_bending_branch   " 6 "Flag_organ_bending     " 7 "Flag_bending_by_node " \
8 "Flag_Plagiotropic          " 9 "Leaf_direction              "   } {
  label $w.right.bot.lb$i -text $item -width 20 
}

for {set i 1} {$i <=5}  {incr i} {
   entry $w.right.bot.en$i -textvariable geo3righten$i -width 4
   grid $w.right.bot.lb$i $w.right.bot.en$i
}
for {set i 6} {$i<=9} {incr i} {
   checkbutton $w.right.bot.en$i -variable geo3righten$i 
   grid $w.right.bot.lb$i $w.right.bot.en$i
} 

init_widget

}

proc init_widget { } {
	global w
	global inter_Ang_Ph
	global inter_Ey
	global inter_fp
	global inter_Eng_Ang
	global inter_Eng_N
	global inter_InitMin
	global inter_InitMax
	global inter_InitNum
	global inter_Flag_Bending_by_node
	global inter_wb
	global inter_wbn
	global inter_Flag_Organ_bending
	global inter_Theta_B
	global inter_Theta_L
	global inter_Theta_F
	global inter_Flag_Plagiotropic
	global inter_Flag
	
	for {set i 1} {$i<=8} {incr i} {
	    global geo3leften$i
	    }
	for {set i 1} {$i<=9} {incr i} {
	    global geo3righten$i
	    }
	set geo3leften1 [lindex $inter_Ang_Ph 2]
	set geo3leften2 [lindex $inter_Ey 2] 
	set geo3leften3 [lindex $inter_fp 2]
	set geo3leften4 [lindex $inter_Eng_Ang 2]
	set geo3leften5 [lindex $inter_Eng_N 2]
	set geo3leften6 [lindex $inter_InitMin 2]
	set geo3leften7 [lindex $inter_InitMax 2]
	set geo3leften8 [lindex $inter_InitNum 2]
	set geo3righten1 [lindex $inter_wb 2]
	set geo3righten2 [lindex $inter_wbn 2]
	set geo3righten3 [lindex $inter_Theta_L 2]
	set geo3righten4 [lindex $inter_Theta_F 2]
	set geo3righten5 [lindex $inter_Theta_B 2]
	set geo3righten6 [lindex $inter_Flag_Organ_bending 2]
	set geo3righten7 [lindex $inter_Flag_Bending_by_node 2]
	set geo3righten8 [lindex $inter_Flag_Plagiotropic  2]
	set geo3righten9 [lindex $inter_Flag 2]
}

########## when "ok" button is pushed, confirm the modification 
proc geo_3_ok { } {
	global w
	global inter_Ang_Ph
	global inter_Ey
	global inter_fp
	global inter_Eng_Ang
	global inter_Eng_N
	global inter_InitMin
	global inter_InitMax
	global inter_InitNum
	global inter_Flag_Bending_by_node
	global inter_wb
	global inter_wbn
	global inter_Flag_Organ_bending
	global inter_Theta_B
	global inter_Theta_L
	global inter_Theta_F
	global inter_Flag_Plagiotropic
	global inter_Flag
	
	global Flag_simulate        
        set Flag_simulate 0
	
	for {set i 6} {$i<=9} {incr i} {
	   global geo3righten$i
	}
	
	set test1 [lrange $inter_Ang_Ph 0 1]
	set test2 [lrange $inter_Ang_Ph 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en1 get]]
	set inter_Ang_Ph [lrange $test 0 5]
	set test1 [lrange $inter_Ey 0 1]
	set test2 [lrange $inter_Ey 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en2 get]]
	set inter_Ey [lrange $test 0 5]
	set test1 [lrange $inter_fp 0 1]
	set test2 [lrange $inter_fp 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en3 get]]
	set inter_fp [lrange $test 0 5]
	set test1 [lrange $inter_Eng_Ang 0 1]
	set test2 [lrange $inter_Eng_Ang 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en4 get]]
	set inter_Eng_Ang [lrange $test 0 5]
	set test1 [lrange $inter_Eng_N 0 1]
	set test2 [lrange $inter_Eng_N 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en5 get]]
	set inter_Eng_N [lrange $test 0 5]
	set test1 [lrange $inter_InitMin 0 1]
	set test2 [lrange $inter_InitMin 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.left.bot.en6 get]]
	set inter_InitMin [lrange $test 0 5]
	set test1 [lrange $inter_InitMax 0 1]
	set test2 [lrange $inter_InitMax 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en7 get]]
	set inter_InitMax [lrange $test 0 5]
	set test1 [lrange $inter_InitNum 0 1]
	set test2 [lrange $inter_InitNum 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.left.bot.en8 get]]
	set inter_InitNum [lrange $test 0 5]
	set test1 [lrange $inter_wb 0 1]
	set test2 [lrange $inter_wb 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.bot.en1 get]]
	set inter_wb [lrange $test 0 5]
	set test1 [lrange $inter_wbn 0 1]
	set test2 [lrange $inter_wbn 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.bot.en2 get]]
	set inter_wbn [lrange $test 0 5]
	set test1 [lrange $inter_Flag_Plagiotropic 0 1]
	set test2 [lrange $inter_Flag_Plagiotropic 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $geo3righten8]
	set inter_Flag_Plagiotropic [lrange $test 0 5]
	set test1 [lrange $inter_Flag 0 1]
	set test2 [lrange $inter_Flag 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $geo3righten9]
	set inter_Flag [lrange $test 0 5]
	set test1 [lrange $inter_Flag_Bending_by_node 0 1]
	set test2 [lrange $inter_Flag_Bending_by_node 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $geo3righten7]
	set inter_Flag_Bending_by_node [lrange $test 0 5]
	set test1 [lrange $inter_Theta_L 0 1]
	set test2 [lrange $inter_Theta_L 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.bot.en3 get]]
	set inter_Theta_L [lrange $test 0 5]
	set test1 [lrange $inter_Theta_F 0 1]
	set test2 [lrange $inter_Theta_F 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.bot.en4 get]]
	set inter_Theta_F [lrange $test 0 5]
	set test1 [lrange $inter_Theta_B 0 1]
	set test2 [lrange $inter_Theta_B 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.right.bot.en5 get]]
	set inter_Theta_B [lrange $test 0 5]
	set test1 [lrange $inter_Flag_Organ_bending 0 1]
	set test2 [lrange $inter_Flag_Organ_bending 3 5]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $geo3righten6]
	set inter_Flag_Organ_bending [lrange $test 0 5]
	
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
proc geo_3_cancel { } {
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



