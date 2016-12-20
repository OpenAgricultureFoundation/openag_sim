proc func_fit_5 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 5 -- Functional Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 620x340+230+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command func_5_ok
button $w.buttons.cancel -text "Cancel" -command func_5_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.top
pack $w.top -side top -padx 10 -pady 5
frame $w.bottom
pack $w.bottom -side top -padx 10 -pady 5

foreach {i item} {8 B 9 P 10 I 11 Ff 12 Fm 13 L 14 R 15 Br} {
    label $w.top.lb$i -text $item -width 4
}
grid x $w.top.lb8 x $w.top.lb9 x $w.top.lb10 x $w.top.lb11 x $w.top.lb12 x $w.top.lb13 \
     x $w.top.lb14 x $w.top.lb15

foreach {i item} {5 "Time_function          " 6 "Time_appearance     " 7 "Time_disappearance"} {
    label $w.top.lb$i -text $item -width 18
    for {set j 1}  {$j<=8} {incr j} {
       entry $w.top.en$j$i -textvariable func5topen$j$i -width 4
       }
    grid $w.top.lb$i $w.top.en1$i x $w.top.en2$i x $w.top.en3$i x $w.top.en4$i \
         x $w.top.en5$i x $w.top.en6$i x $w.top.en7$i x $w.top.en8$i
}
for {set i 0} {$i<=6} {incr i} {
label $w.top.lb3$i -text "fit" -width 4
}
grid x x $w.top.lb30 x $w.top.lb31 x $w.top.lb32 x $w.top.lb33 x $w.top.lb34 x $w.top.lb35 x $w.top.lb36 

foreach {i item} {1 "Sink                       " 2 "Time_expansion      " 3 "Para_expansion_a   " \
4 "Para_expansion_b   " } {
    label $w.top.lb$i -text $item -width 18
    for {set j 1} {$j<=7} {incr j} {
       entry $w.top.en$j$i -textvariable func1topen$j$i -width 4
       checkbutton $w.top.chb$j$i -variable fun5chb$j$i
       }
    grid $w.top.lb$i $w.top.en1$i $w.top.chb1$i $w.top.en2$i $w.top.chb2$i $w.top.en3$i $w.top.chb3$i $w.top.en4$i $w.top.chb4$i \
         $w.top.en5$i $w.top.chb5$i $w.top.en6$i $w.top.chb6$i $w.top.en7$i $w.top.chb7$i 
}

button $w.top.b1 -text "curve" -width 4 -command exp_curve1
button $w.top.b2 -text "curve" -width 4 -command exp_curve2
button $w.top.b3 -text "curve" -width 4 -command exp_curve3
button $w.top.b4 -text "curve" -width 4 -command exp_curve4
button $w.top.b5 -text "curve" -width 4 -command exp_curve5
button $w.top.b6 -text "curve" -width 4 -command exp_curve6
button $w.top.b7 -text "curve" -width 4 -command exp_curve7
grid x $w.top.b1 x $w.top.b2 x $w.top.b3 x $w.top.b4 x $w.top.b5 x $w.top.b6 x $w.top.b7 

foreach  {i item} {1 Sp 2 rp 3 kp 4 Q0 5 dQ0 6 coef_layer} {
    label $w.bottom.lb$i -text $item -width 10
    entry $w.bottom.en$i -textvariable func5bottomen$i -width 6
    checkbutton $w.bottom.chb$i -variable fun5chb$i
}
for {set i 7} {$i<=9} {incr i} {
label $w.bottom.lb$i -text "fit"
}
grid x x $w.bottom.lb7 x x $w.bottom.lb8 x x $w.bottom.lb9
grid $w.bottom.lb1 $w.bottom.en1 $w.bottom.chb1 $w.bottom.lb2 $w.bottom.en2 $w.bottom.chb2 $w.bottom.lb3 $w.bottom.en3 $w.bottom.chb3
grid $w.bottom.lb4 $w.bottom.en4 $w.bottom.chb4 $w.bottom.lb5 $w.bottom.en5 $w.bottom.chb5 $w.bottom.lb6 $w.bottom.en6

init_widget
}

proc init_widget { } {
	global w
	global Flag_test
	global Flag_target
	global inter_S_B
	global inter_S_P
	global inter_S_I
	global inter_S_Ff
	global inter_S_Fm
	global inter_S_L
	global inter_S_R
	global inter_T_F5
	global inter_T_a5
	global inter_T_d5
	global inter_t_exp
	global inter_Bt_a
	global inter_Bt_b
	global inter_Sp
	global inter_rp
	global inter_kp
	global inter_Q0
	global inter_dQ0
	global inter_coff_L
	
	global inter_c_S_B
	global inter_c_S_P
	global inter_c_S_I
	global inter_c_S_Ff
	global inter_c_S_Fm
	global inter_c_S_L
	global inter_c_S_R
	global inter_c_t_exp
	global inter_c_Bt_a
	global inter_c_Bt_b
	global inter_c_Sp
	global inter_c_rp
	global inter_c_kp
	global inter_c_Q0
	global inter_c_dQ0
	
	for {set i 1} {$i<=4} {incr i} {
	  for {set j 1} {$j<=7} {incr j} {
	      global func5topen$j$i
	      }
	  }
	for {set i 5} {$i<=8} {incr i} {
	  for {set j 1} {$j<=8} {incr j} {
	      global func5topen$j$i
	      }
	  }
        for {set i 1} {$i<=6} {incr i} {
	   global func5bottomen$i
	   }
	for {set i 1} {$i<=4} {incr i} {
	 for {set j 1} {$j<=7} {incr j} {
	   global fun5chb$j$i
	   }
	}
	for {set i 1} {$i<=5} {incr i} {
	 global fun5chb$i
	}
	
	set func5topen11 [lindex $inter_S_B 4]
	set func5topen21 [lindex $inter_S_P 4]
	set func5topen31 [lindex $inter_S_I 4]
	set func5topen41 [lindex $inter_S_Ff 4]
	set func5topen51 [lindex $inter_S_Fm 4]
	set func5topen61 [lindex $inter_S_L 4]
	set func5topen71 [lindex $inter_S_R 4]
	set func5topen12 [lindex $inter_t_exp 0]
	set func5topen22 [lindex $inter_t_exp 1]
	set func5topen32 [lindex $inter_t_exp 2]
	set func5topen42 [lindex $inter_t_exp 3]
	set func5topen52 [lindex $inter_t_exp 4]
	set func5topen62 [lindex $inter_t_exp 5]
	set func5topen72 [lindex $inter_t_exp 6]
	set func5topen13 [lindex $inter_Bt_a 0]
	set func5topen23 [lindex $inter_Bt_a 1]
	set func5topen33 [lindex $inter_Bt_a 2]
	set func5topen43 [lindex $inter_Bt_a 3]
	set func5topen53 [lindex $inter_Bt_a 4]
	set func5topen63 [lindex $inter_Bt_a 5]
	set func5topen73 [lindex $inter_Bt_a 6]
	set func5topen14 [lindex $inter_Bt_b 0]
	set func5topen24 [lindex $inter_Bt_b 1]
	set func5topen34 [lindex $inter_Bt_b 2]
	set func5topen44 [lindex $inter_Bt_b 3]
	set func5topen54 [lindex $inter_Bt_b 4]
	set func5topen64 [lindex $inter_Bt_b 5]
	set func5topen74 [lindex $inter_Bt_b 6]
	set func5topen15 [lindex $inter_T_F5 0]
	set func5topen25 [lindex $inter_T_F5 1]
	set func5topen35 [lindex $inter_T_F5 2]
	set func5topen45 [lindex $inter_T_F5 3]
	set func5topen55 [lindex $inter_T_F5 4]
	set func5topen65 [lindex $inter_T_F5 5]
	set func5topen75 [lindex $inter_T_F5 6]
	set func5topen85 [lindex $inter_T_F5 7]
	set func5topen16 [lindex $inter_T_a5 0]
	set func5topen26 [lindex $inter_T_a5 1]
	set func5topen36 [lindex $inter_T_a5 2]
	set func5topen46 [lindex $inter_T_a5 3]
	set func5topen56 [lindex $inter_T_a5 4]
	set func5topen66 [lindex $inter_T_a5 5]
	set func5topen76 [lindex $inter_T_a5 6]
	set func5topen86 [lindex $inter_T_a5 7]
	set func5topen17 [lindex $inter_T_d5 0]
	set func5topen27 [lindex $inter_T_d5 1]
	set func5topen37 [lindex $inter_T_d5 2]
	set func5topen47 [lindex $inter_T_d5 3]
	set func5topen57 [lindex $inter_T_d5 4]
	set func5topen67 [lindex $inter_T_d5 5]
	set func5topen77 [lindex $inter_T_d5 6]
	set func5topen87 [lindex $inter_T_d5 7]
	set func5bottomen1 $inter_Sp
	set func5bottomen2 $inter_rp
	set func5bottomen3 $inter_kp
	set func5bottomen4 $inter_Q0
	set func5bottomen5 $inter_dQ0
	set func5bottomen6 $inter_coff_L

if {$Flag_test == 1} {
  for {set i 1} {$i<=4} {incr i} {
    for {set j 1} {$j<=7} {incr j} {
        set fun1chb$j$i 0
        $w.top.chb$j$i configure -state disabled
        }
    }
  for {set i 1} {$i<=5} {incr i} {
    set fun1chb$i 0
    $w.bottom.chb$i configure -state disabled
  }
}
if {$Flag_target == 1} {	
	set fun5chb11 [lindex $inter_c_S_B 4]
	set fun5chb21 [lindex $inter_c_S_P 4]
	set fun5chb31 [lindex $inter_c_S_I 4]
	set fun5chb41 [lindex $inter_c_S_Ff 4]
	set fun5chb51 [lindex $inter_c_S_Fm 4]
	set fun5chb61 [lindex $inter_c_S_L 4]
	set fun5chb71 [lindex $inter_c_S_R 4]
	set fun5chb12 [lindex $inter_c_t_exp 0]
	set fun5chb22 [lindex $inter_c_t_exp 1]
	set fun5chb32 [lindex $inter_c_t_exp 2]
	set fun5chb42 [lindex $inter_c_t_exp 3]
	set fun5chb52 [lindex $inter_c_t_exp 4]
	set fun5chb62 [lindex $inter_c_t_exp 5]
	set fun5chb72 [lindex $inter_c_t_exp 6]
	set fun5chb13 [lindex $inter_c_Bt_a 0]
	set fun5chb23 [lindex $inter_c_Bt_a 1]
	set fun5chb33 [lindex $inter_c_Bt_a 2]
	set fun5chb43 [lindex $inter_c_Bt_a 3]
	set fun5chb53 [lindex $inter_c_Bt_a 4]
	set fun5chb63 [lindex $inter_c_Bt_a 5]
	set fun51chb73 [lindex $inter_c_Bt_a 6]
	set fun5chb14 [lindex $inter_c_Bt_b 0]
	set fun5chb24 [lindex $inter_c_Bt_b 1]
	set fun5chb34 [lindex $inter_c_Bt_b 2]
	set fun5chb44 [lindex $inter_c_Bt_b 3]
	set fun5chb54 [lindex $inter_c_Bt_b 4]
	set fun5chb64 [lindex $inter_c_Bt_b 5]
	set fun5chb74 [lindex $inter_c_Bt_b 6]
	set fun5chb1 $inter_c_Sp
	set fun5chb2 $inter_c_rp
	set fun5chb3 $inter_c_kp
	set fun5chb4 $inter_c_Q0
	set fun5chb5 $inter_c_dQ0
}

}

proc func_5_ok {} {
	global w
	global inter_S_B
	global inter_S_P
	global inter_S_I
	global inter_S_Ff
	global inter_S_Fm
	global inter_S_L
	global inter_S_R
	global inter_T_F5
	global inter_T_a5
	global inter_T_d5
	global inter_t_exp
	global inter_Bt_a
	global inter_Bt_b
	global inter_Sp
	global inter_rp
	global inter_kp
	global inter_Q0
	global inter_dQ0
	global inter_coff_L
	
	global inter_c_S_B
	global inter_c_S_P
	global inter_c_S_I
	global inter_c_S_Ff
	global inter_c_S_Fm
	global inter_c_S_L
	global inter_c_S_R
	global inter_c_t_exp
	global inter_c_Bt_a
	global inter_c_Bt_b
	global inter_c_Sp
	global inter_c_rp
	global inter_c_kp
	global inter_c_Q0
	global inter_c_dQ0
	
	global Flag_test
	global Flag_target
	
	global Flag_fit
  set Flag_fit 0
  
  for {set i 1} {$i<=4} {incr i} {
	 for {set j 1} {$j<=7} {incr j} {
	   global fun5chb$j$i
	   }
	}
	for {set i 1} {$i<=5} {incr i} {
	 global fun5chb$i
	}
	
	set test1 [lrange $inter_c_S_B 0 3]
	set test2 [lrange $inter_c_S_B 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb11]
	set inter_c_S_B [lrange $test 0 5]
	set test1 [lrange $inter_c_S_P 0 3]
	set test2 [lrange $inter_c_S_P 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb21]
	set inter_c_S_P [lrange $test 0 5]
	set test1 [lrange $inter_c_S_I 0 3]
	set test2 [lrange $inter_c_S_I 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb31]
	set inter_c_S_I [lrange $test 0 5]
	set test1 [lrange $inter_c_S_Ff 0 3]
	set test2 [lrange $inter_c_S_Ff 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb41]
	set inter_c_S_Ff [lrange $test 0 5]
	set test1 [lrange $inter_c_S_Fm 0 3]
	set test2 [lrange $inter_c_S_Fm 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb51]
	set inter_c_S_Fm [lrange $test 0 5]
	set test1 [lrange $inter_c_S_L 0 3]
	set test2 [lrange $inter_c_S_L 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb61]
	set inter_c_S_L [lrange $test 0 5]
	set test1 [lrange $inter_c_S_R 0 3]
	set test2 [lrange $inter_c_S_R 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb71]
	set inter_c_S_R [lrange $test 0 5]
	set test [lrange $inter_c_t_exp 1 6]
	set test [linsert $test 0 $fun5chb12]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 $fun5chb22]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $fun5chb32]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $fun5chb42]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb52]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 $fun5chb62]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 $fun5chb72]
	set inter_c_t_exp [lrange $test 0 6]

	set test [lrange $inter_c_Bt_a 1 6]
	set test [linsert $test 0 $fun5chb13]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 $fun5chb23]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $fun5chb33]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $fun5chb43]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb53]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 $fun5chb63]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 $fun5chb73]
	set inter_c_Bt_a [lrange $test 0 6]

	set test [lrange $inter_c_Bt_b 1 6]
	set test [linsert $test 0 $fun5chb14]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 $fun5chb24]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 $fun5chb34]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 $fun5chb44]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 $fun5chb54]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 $fun5chb64]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 $fun5chb74]
	set inter_c_Bt_b [lrange $test 0 6]

	set inter_c_Sp $fun5chb1
	set inter_c_rp $fun5chb2
	set inter_c_kp $fun5chb3
	set inter_c_Q0 $fun5chb4
	set inter_c_dQ0 $fun5chb5
	
	global Flag_simulate        
        set Flag_simulate 0
	
	set test1 [lrange $inter_S_B 0 3]
	set test2 [lrange $inter_S_B 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en11 get]]
	set inter_S_B [lrange $test 0 5]
	set test1 [lrange $inter_S_P 0 3]
	set test2 [lrange $inter_S_P 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en21 get]]
	set inter_S_P [lrange $test 0 5]
	set test1 [lrange $inter_S_I 0 3]
	set test2 [lrange $inter_S_I 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en31 get]]
	set inter_S_I [lrange $test 0 5]
	set test1 [lrange $inter_S_Ff 0 3]
	set test2 [lrange $inter_S_Ff 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en41 get]]
	set inter_S_Ff [lrange $test 0 5]
	set test1 [lrange $inter_S_Fm 0 3]
	set test2 [lrange $inter_S_Fm 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en51 get]]
	set inter_S_Fm [lrange $test 0 5]
	set test1 [lrange $inter_S_L 0 3]
	set test2 [lrange $inter_S_L 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en61 get]]
	set inter_S_L [lrange $test 0 5]
	set test1 [lrange $inter_S_R 0 3]
	set test2 [lrange $inter_S_R 5 5]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en71 get]]
	set inter_S_R [lrange $test 0 5]
	set test [lrange $inter_t_exp 1 6]
	set test [linsert $test 0 [$w.top.en12 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en22 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en32 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en42 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en52 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en62 get]]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 [$w.top.en72 get]]
	set inter_t_exp [lrange $test 0 6]

	set test [lrange $inter_Bt_a 1 6]
	set test [linsert $test 0 [$w.top.en13 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en23 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en33 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en43 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en53 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en63 get]]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 [$w.top.en73 get]]
	set inter_Bt_a [lrange $test 0 6]

	set test [lrange $inter_Bt_b 1 6]
	set test [linsert $test 0 [$w.top.en14 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 6]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en24 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 6]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en34 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 6]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en44 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 6]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en54 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 6]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en64 get]]
	set test [lreplace $test 6 6]
	set test [linsert $test 6 [$w.top.en74 get]]
	set inter_Bt_b [lrange $test 0 6]
 
	set test [lrange $inter_T_F5 1 7]
	set test [linsert $test 0 [$w.top.en15 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 7]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en25 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 7]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en35 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 7]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en45 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 7]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en55 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 7]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en65 get]]
	set test1 [lrange $test 0 5]
	set test2 [lrange $test 7 7]
	set test [concat $test1 $test2]
	set test [linsert $test 6 [$w.top.en75 get]]
	set test [lreplace $test 7 7]
	set test [linsert $test 7 [$w.top.en85 get]]
	set inter_T_F5 [lrange $test 0 7]

	set test [lrange $inter_T_a5 1 7]
	set test [linsert $test 0 [$w.top.en16 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 7]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en26 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 7]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en36 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 7]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en46 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 7]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en56 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 7]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en66 get]]
	set test1 [lrange $test 0 5]
	set test2 [lrange $test 7 7]
	set test [concat $test1 $test2]
	set test [linsert $test 6 [$w.top.en76 get]]
	set test [lreplace $test 7 7]
	set test [linsert $test 7 [$w.top.en86 get]]
	set inter_T_a5 [lrange $test 0 7]

	set test [lrange $inter_T_d5 1 7]
	set test [linsert $test 0 [$w.top.en17 get]]
	set test1 [lrange $test 0 0]
	set test2 [lrange $test 2 7]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en27 get]]
	set test1 [lrange $test 0 1]
	set test2 [lrange $test 3 7]
	set test [concat $test1 $test2]
	set test [linsert $test 2 [$w.top.en37 get]]
	set test1 [lrange $test 0 2]
	set test2 [lrange $test 4 7]
	set test [concat $test1 $test2]
	set test [linsert $test 3 [$w.top.en47 get]]
	set test1 [lrange $test 0 3]
	set test2 [lrange $test 5 7]
	set test [concat $test1 $test2]
	set test [linsert $test 4 [$w.top.en57 get]]
	set test1 [lrange $test 0 4]
	set test2 [lrange $test 6 7]
	set test [concat $test1 $test2]
	set test [linsert $test 5 [$w.top.en67 get]]
	set test1 [lrange $test 0 5]
	set test2 [lrange $test 7 7]
	set test [concat $test1 $test2]
	set test [linsert $test 6 [$w.top.en77 get]]
	set test [lreplace $test 7 7]
	set test [linsert $test 7 [$w.top.en87 get]]
	set inter_T_d5 [lrange $test 0 7]

	set inter_Sp [$w.bottom.en1 get]
	set inter_rp [$w.bottom.en2 get]
	set inter_kp [$w.bottom.en3 get]
	set inter_Q0 [$w.bottom.en4 get]
	set inter_dQ0 [$w.bottom.en5 get]
	set inter_coff_L [$w.bottom.en6 get]
	
	global Flag_save_simu
	set Flag_save_simu 0
	global Flag_save_fit
	set Flag_save_fit 0

	destroy $w
	if {$Flag_test == 1} {
	   form_task
	}
	if {$Flag_target == 1} {
	   form_task
	}
}

proc func_5_cancel {} {
	global Flag_simulate        
  global Flag_test
	global Flag_target
	global Flag_fit
	
	global Flag_save_simu
  global Flag_save_fit
  set Flag_save_simu $Flag_save_simu
  set Flag_save_fit $Flag_save_fit
  set Flag_simulate $Flag_simulate
  set Flag_fit $Flag_fit
  
	global w
	destroy $w
}

proc exp_curve1 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en12 get]
set b_n [$w.top.en13 get]
set b_p [$w.top.en14 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve2 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en22 get]
set b_n [$w.top.en23 get]
set b_p [$w.top.en24 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve3 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en32 get]
set b_n [$w.top.en33 get]
set b_p [$w.top.en34 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve4 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en42 get]
set b_n [$w.top.en43 get]
set b_p [$w.top.en44 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve5 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en52 get]
set b_n [$w.top.en53 get]
set b_p [$w.top.en54 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve6 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en62 get]
set b_n [$w.top.en63 get]
set b_p [$w.top.en64 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
proc exp_curve7 {} {
global w
global INTER_SYS_DIR
set t_ex [$w.top.en72 get]
set b_n [$w.top.en73 get]
set b_p [$w.top.en74 get]
ScilabEval "t_ex= $t_ex;";
ScilabEval "b_exn= $b_n;";
ScilabEval "b_exp= $b_p;";
ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_expan.sci');";
}
