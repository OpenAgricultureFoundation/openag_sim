proc set_shapepara_new {} {
      global w
      global INTER_SYS_DIR
############Create a window for Topological Param deterministic Setting
label .wind
set w .wind
catch {destroy $w}
toplevel $w
wm title $w "Global Geometrical Parameter Setting -- shape"
wm iconname $w "Greenlab"
wm geometry $w 500x180+160+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Accept" -command shape_new_ok
button $w.buttons.cancel -text "Cancel" -command shape_new_cancel

### 
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.f1
pack $w.f1 -side left -padx 10 -pady 10
frame $w.f2
pack $w.f2 -side left -padx 10 -pady 10
frame $w.f3
pack $w.f3 -side left -padx 10 -pady 10
frame $w.f1.top
pack $w.f1.top -side top
frame $w.f1.bot
pack $w.f1.bot -side top
frame $w.f2.top
pack $w.f2.top -side top
frame $w.f2.bot
pack $w.f2.bot -side top
frame $w.f3.top
pack $w.f3.top -side top
frame $w.f3.bot 
pack $w.f3.bot -side top

label $w.f1.top.lb -text "Leaf shape   " -width 20
label $w.f2.top.lb -text "female fruit shape    " -width 20
label $w.f3.top.lb -text "male fruit shape    " -width 20
listbox $w.f1.bot.lsb -width 20 -height 5 -yscrollcommand {$w.f1.bot.yscroll set}
scrollbar $w.f1.bot.yscroll -command {$w.f1.bot.lsb yview}
listbox $w.f2.bot.lsb -width 20 -height 5 -yscrollcommand {$w.f2.bot.yscroll set}
scrollbar $w.f2.bot.yscroll -command {$w.f2.bot.lsb yview}
listbox $w.f3.bot.lsb -width 20 -height 5 -yscrollcommand {$w.f3.bot.yscroll set}
scrollbar $w.f3.bot.yscroll -command {$w.f3.bot.lsb yview}
pack $w.f1.top.lb -side top
pack $w.f1.bot.lsb $w.f1.bot.yscroll -side left
pack $w.f2.top.lb -side top
pack $w.f2.bot.lsb $w.f2.bot.yscroll -side left
pack $w.f3.top.lb -side top
pack $w.f3.bot.lsb $w.f3.bot.yscroll -side left

foreach item {cotilydonver cottonleafvert2 \
    default e1 leaf_5lob leaf_maize_vert \
    leaf_tomato1 leaf_wheat_vert \
    leaflob1 leafpen11 leafplatan leafsquare1 leafsquare2 \
    maizeleaf2 maizeleaf6 maizeleaf_vert needle2 needle4 needle \
    spike spike_a spike_b sunleaf test1 test2 test3 test4 test5 test6 test7 test8 test9 \
    test10 wheatleaf yinxing_win} {
       $w.f1.bot.lsb insert end $item
}
foreach item {0 ball cob2 cube2 f3 fcoton2 femaleorgan flower_1 flower_2 flower_chrys_a_glab \
      flower_test fruit1 maizecone r3 r4 \
      tomato_bunch3d wheatspike} {
       $w.f2.bot.lsb insert end $item
}
foreach item {0 male3 male3a malemaize2 malemaize malemaizeok2} {
       $w.f3.bot.lsb insert end $item
}

bind $w.f1.bot.lsb <ButtonRelease-1> leaf
bind $w.f2.bot.lsb <ButtonRelease-1> fefruit
bind $w.f3.bot.lsb <ButtonRelease-1> mafruit

init_widget
}

proc init_widget {} {
	global w
	global leafshape
	global fefruitshape
	global mafruitshape
	global inter_Smb_L
	global inter_Smb_Ff
	global inter_Smb_Fm
	
	set leafshape $inter_Smb_L
	set fefruitshape $inter_Smb_Ff
	set mafruitshape $inter_Smb_Fm
	
	
}

proc shape_new_ok {} {
	global w
	global inter_Smb_L
	global inter_Smb_Ff
	global inter_Smb_Fm
	global leafshape
	global fefruitshape
	global mafruitshape
	
	global Flag_simulate        
        set Flag_simulate 0
	
	set inter_Smb_L $leafshape
	set inter_Smb_Ff $fefruitshape
	set inter_Smb_Fm $mafruitshape

	
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

proc shape_new_cancel {} {
	global Flag_simulate 
	global Flag_fit
	global Flag_test
	global Flag_target
	
	global Flag_save_simu
  global Flag_save_fit
  global inter_Smb_L
	global inter_Smb_Ff
	global inter_Smb_Fm
	global leafshape
	global fefruitshape
	global mafruitshape
	set inter_Smb_L $leafshape
	set inter_Smb_Ff $fefruitshape
	set inter_Smb_Fm $mafruitshape
	
  set Flag_save_simu $Flag_save_simu
  set Flag_save_fit $Flag_save_fit
  set Flag_simulate $Flag_simulate
  set Flag_fit $Flag_fit
  
  
	global w
	destroy $w
}

proc leaf {} {
	global w
	global inter_Smb_L
	global INTER_SYS_DIR
	global leafshape
	set index [$w.f1.bot.lsb curselection]
	set leafshape [$w.f1.bot.lsb get $index]
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$leafshape';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}

proc fefruit {} {
	global w
	global inter_Smb_Ff
	global INTER_SYS_DIR
	global fefruitshape
	set index [$w.f2.bot.lsb curselection]
	set fefruitshape [$w.f2.bot.lsb get $index]
	if {$fefruitshape==0} {
	   set fefruitshape femaleorgan
	}
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$fefruitshape';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}

proc mafruit {} {
	global w
	global inter_Smb_Fm
	global INTER_SYS_DIR
	global mafruitshape
	set index [$w.f3.bot.lsb curselection]
	set mafruitshape [$w.f3.bot.lsb get $index]
	if {$mafruitshape==0} {
	   set mafruitshape male3
	}
	ScilabEval "INTER_SYS_DIR='$INTER_SYS_DIR';";
        ScilabEval "smb='$mafruitshape';";
        ScilabEval "exec(INTER_SYS_DIR+'/bin/inter_draw_organ.sci');";           
}

