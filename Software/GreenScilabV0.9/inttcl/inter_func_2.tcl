proc func_2 {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "PA 2 -- Functional Parameter Setting"
wm iconname $w "Greenlab"
wm geometry $w 550x320+230+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command func_2_ok
button $w.buttons.cancel -text "Cancel" -command func_2_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.top
pack $w.top -side top -padx 10 -pady 5
frame $w.bottom
pack $w.bottom -side top -padx 10 -pady 10

foreach {i item} {8 B 9 P 10 I 11 Ff 12 Fm 13 L 14 R 15 Br} {
    label $w.top.lb$i -text $item -width 4
}
grid x $w.top.lb8 $w.top.lb9 $w.top.lb10 $w.top.lb11 $w.top.lb12 $w.top.lb13 \
     $w.top.lb14 $w.top.lb15

foreach {i item} {5 "Time_function          " 6 "Time_appearance     " 7 "Time_disappearance"} {
    label $w.top.lb$i -text $item -width 18
    for {set j 1}  {$j<=8} {incr j} {
       entry $w.top.en$j$i -textvariable func2topen$j$i -width 4
       }
    grid $w.top.lb$i $w.top.en1$i $w.top.en2$i $w.top.en3$i $w.top.en4$i \
         $w.top.en5$i $w.top.en6$i $w.top.en7$i $w.top.en8$i
}

label $w.top.lb30 -text "  " -width 4
grid x x $w.top.lb30

foreach {i item} {1 "Sink                       " 2 "Time_expansion      " 3 "Para_expansion_a   " \
4 "Para_expansion_b   " } {
    label $w.top.lb$i -text $item -width 18
    for {set j 1} {$j<=7} {incr j} {
       entry $w.top.en$j$i -textvariable func2topen$j$i -width 4
       }
    grid $w.top.lb$i $w.top.en1$i $w.top.en2$i $w.top.en3$i $w.top.en4$i \
         $w.top.en5$i $w.top.en6$i $w.top.en7$i
}

button $w.top.b1 -text "curve" -width 4 -command exp_curve1
button $w.top.b2 -text "curve" -width 4 -command exp_curve2
button $w.top.b3 -text "curve" -width 4 -command exp_curve3
button $w.top.b4 -text "curve" -width 4 -command exp_curve4
button $w.top.b5 -text "curve" -width 4 -command exp_curve5
button $w.top.b6 -text "curve" -width 4 -command exp_curve6
button $w.top.b7 -text "curve" -width 4 -command exp_curve7
grid x $w.top.b1 $w.top.b2 $w.top.b3 $w.top.b4 $w.top.b5 $w.top.b6 $w.top.b7 

foreach  {i item} {1 Sp 2 rp 3 kp 4 Q0 5 dQ0 6 coef_layer} {
    label $w.bottom.lb$i -text $item -width 10
    entry $w.bottom.en$i -textvariable func2bottomen$i -width 6
}

grid $w.bottom.lb1 $w.bottom.en1 $w.bottom.lb2 $w.bottom.en2 $w.bottom.lb3 $w.bottom.en3 
grid $w.bottom.lb4 $w.bottom.en4 $w.bottom.lb5 $w.bottom.en5 $w.bottom.lb6 $w.bottom.en6

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
	global inter_T_F2
	global inter_T_a2
	global inter_T_d2
	global inter_t_exp
	global inter_Bt_a
	global inter_Bt_b
	global inter_Sp
	global inter_rp
	global inter_kp
	global inter_Q0
	global inter_dQ0
	global inter_coff_L
	
	for {set i 1} {$i<=4} {incr i} {
	  for {set j 1} {$j<=7} {incr j} {
	      global func2topen$j$i
	      }
	  }
	for {set i 5} {$i<=8} {incr i} {
	  for {set j 1} {$j<=8} {incr j} {
	      global func2topen$j$i
	      }
	  }
        for {set i 1} {$i<=6} {incr i} {
	   global func2bottomen$i
	   }
	
	set func2topen11 [lindex $inter_S_B 1]
	set func2topen21 [lindex $inter_S_P 1]
	set func2topen31 [lindex $inter_S_I 1]
	set func2topen41 [lindex $inter_S_Ff 1]
	set func2topen51 [lindex $inter_S_Fm 1]
	set func2topen61 [lindex $inter_S_L 1]
	set func2topen71 [lindex $inter_S_R 1]
	set func2topen12 [lindex $inter_t_exp 0]
	set func2topen22 [lindex $inter_t_exp 1]
	set func2topen32 [lindex $inter_t_exp 2]
	set func2topen42 [lindex $inter_t_exp 3]
	set func2topen52 [lindex $inter_t_exp 4]
	set func2topen62 [lindex $inter_t_exp 5]
	set func2topen72 [lindex $inter_t_exp 6]
	set func2topen13 [lindex $inter_Bt_a 0]
	set func2topen23 [lindex $inter_Bt_a 1]
	set func2topen33 [lindex $inter_Bt_a 2]
	set func2topen43 [lindex $inter_Bt_a 3]
	set func2topen53 [lindex $inter_Bt_a 4]
	set func2topen63 [lindex $inter_Bt_a 5]
	set func2topen73 [lindex $inter_Bt_a 6]
	set func2topen14 [lindex $inter_Bt_b 0]
	set func2topen24 [lindex $inter_Bt_b 1]
	set func2topen34 [lindex $inter_Bt_b 2]
	set func2topen44 [lindex $inter_Bt_b 3]
	set func2topen54 [lindex $inter_Bt_b 4]
	set func2topen64 [lindex $inter_Bt_b 5]
	set func2topen74 [lindex $inter_Bt_b 6]
	set func2topen15 [lindex $inter_T_F2 0]
	set func2topen25 [lindex $inter_T_F2 1]
	set func2topen35 [lindex $inter_T_F2 2]
	set func2topen45 [lindex $inter_T_F2 3]
	set func2topen55 [lindex $inter_T_F2 4]
	set func2topen65 [lindex $inter_T_F2 5]
	set func2topen75 [lindex $inter_T_F2 6]
	set func2topen85 [lindex $inter_T_F2 7]
	set func2topen16 [lindex $inter_T_a2 0]
	set func2topen26 [lindex $inter_T_a2 1]
	set func2topen36 [lindex $inter_T_a2 2]
	set func2topen46 [lindex $inter_T_a2 3]
	set func2topen56 [lindex $inter_T_a2 4]
	set func2topen66 [lindex $inter_T_a2 5]
	set func2topen76 [lindex $inter_T_a2 6]
	set func2topen86 [lindex $inter_T_a2 7]
	set func2topen17 [lindex $inter_T_d2 0]
	set func2topen27 [lindex $inter_T_d2 1]
	set func2topen37 [lindex $inter_T_d2 2]
	set func2topen47 [lindex $inter_T_d2 3]
	set func2topen57 [lindex $inter_T_d2 4]
	set func2topen67 [lindex $inter_T_d2 5]
	set func2topen77 [lindex $inter_T_d2 6]
	set func2topen87 [lindex $inter_T_d2 7]
	set func2bottomen1 $inter_Sp
	set func2bottomen2 $inter_rp
	set func2bottomen3 $inter_kp
	set func2bottomen4 $inter_Q0
	set func2bottomen5 $inter_dQ0
	set func2bottomen6 $inter_coff_L


}

proc func_2_ok {} {
	global w
	global inter_S_B
	global inter_S_P
	global inter_S_I
	global inter_S_Ff
	global inter_S_Fm
	global inter_S_L
	global inter_S_R
	global inter_T_F2
	global inter_T_a2
	global inter_T_d2
	global inter_t_exp
	global inter_Bt_a
	global inter_Bt_b
	global inter_Sp
	global inter_rp
	global inter_kp
	global inter_Q0
	global inter_dQ0
	global inter_coff_L

	global Flag_test
	global Flag_target
	
	global Flag_fit
  set Flag_fit 0
  
	
	global Flag_simulate        
        set Flag_simulate 0
        
        global Flag_save_simu
	set Flag_save_simu 0
	global Flag_save_fit
	set Flag_save_fit 0
	
	set test1 [lrange $inter_S_B 0 0]
	set test2 [lrange $inter_S_B 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en11 get]]
	set inter_S_B [lrange $test 0 5]
	set test1 [lrange $inter_S_P 0 0]
	set test2 [lrange $inter_S_P 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en21 get]]
	set inter_S_P [lrange $test 0 5]
	set test1 [lrange $inter_S_I 0 0]
	set test2 [lrange $inter_S_I 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en31 get]]
	set inter_S_I [lrange $test 0 5]
	set test1 [lrange $inter_S_Ff 0 0]
	set test2 [lrange $inter_S_Ff 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en41 get]]
	set inter_S_Ff [lrange $test 0 5]
	set test1 [lrange $inter_S_Fm 0 0]
	set test2 [lrange $inter_S_Fm 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en51 get]]
	set inter_S_Fm [lrange $test 0 5]
	set test1 [lrange $inter_S_L 0 0]
	set test2 [lrange $inter_S_L 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en61 get]]
	set inter_S_L [lrange $test 0 5]
	set test1 [lrange $inter_S_R 0 0]
	set test2 [lrange $inter_S_R 2 5]
	set test [concat $test1 $test2]
	set test [linsert $test 1 [$w.top.en71 get]]
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
 
	set test [lrange $inter_T_F2 1 7]
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
	set inter_T_F2 [lrange $test 0 7]

	set test [lrange $inter_T_a2 1 7]
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
	set inter_T_a2 [lrange $test 0 7]

	set test [lrange $inter_T_d2 1 7]
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
	set inter_T_d2 [lrange $test 0 7]

	set inter_Sp [$w.bottom.en1 get]
	set inter_rp [$w.bottom.en2 get]
	set inter_kp [$w.bottom.en3 get]
	set inter_Q0 [$w.bottom.en4 get]
	set inter_dQ0 [$w.bottom.en5 get]
	set inter_coff_L [$w.bottom.en6 get]

	destroy $w
  if {$Flag_test == 1} {
	   form_task
	}
	if {$Flag_target == 1} {
	   form_task
	}
}

proc func_2_cancel {} {
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

