proc option {} {
      global w
      global INTER_SYS_DIR
      global Flag_option
      incr Flag_option
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "Option"
wm iconname $w "Greenlab"
wm geometry $w 200x100+230+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command fitoption_ok
button $w.buttons.cancel -text "Cancel" -command fitoption_cancel
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.top
pack $w.top -side top -fill x -padx 5 -pady 15
label $w.top.lb1 -text "code exec" -width 8
radiobutton $w.top.rb1 -variable code -text "C" -value "C" -width 6
radiobutton $w.top.rb2 -variable code -text "Scilab" -value "Scilab" -width 6
pack $w.top.lb1 $w.top.rb1 $w.top.rb2 -side left -fill y -expand 1

init_widget

}

proc init_widget {} {
global w
global code
global Flag_C_code
global Flag_Sci_code
if {$Flag_C_code == 1} {
set code "C"
}
if {$Flag_Sci_code == 1} {
set code "Scilab"
}

}

proc fitoption_ok {} {
global code
global Flag_C_code
global Flag_Sci_code
global Flag_option
incr Flag_option
if {$code == "C"} {
  set Flag_C_code 1
  set Flag_Sci_code 0
}
if {$code == "Scilab"} {
  set Flag_C_code 0
  set Flag_Sci_code 1
}

global w
destroy $w
}

proc fitoption_cancel {} {
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
