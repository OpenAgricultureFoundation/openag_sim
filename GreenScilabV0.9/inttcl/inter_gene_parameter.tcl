#### inter_gene_parametre.tcl
proc set_gene_parameter { } {
       global w
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "Plant age Setting"
wm iconname $w "Greenlab"
wm geometry $w 300x80+300+250

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command genepara_ok
button $w.buttons.cancel -text "Cancel" -command genepara_cancel
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

########## create labels and entries
frame $w.one
frame $w.two
pack $w.two $w.one -side bottom
label $w.lchr -text "CA (N)" -width 20
entry $w.echr -textvariable chr_age -width 15 
pack $w.lchr $w.echr -in $w.one -side left -fill x -expand true

label $w.lphy -text "PA (Maxp)" -width 20
entry $w.ephy -textvariable phy_age -width 15
pack $w.lphy $w.ephy -in $w.two -side left -fill x -expand true

init_widget
}

############ initialize entries
proc init_widget {} {
        global w
        global inter_N
        global inter_maxp
        global chr_age
        global phy_age
set chr_age $inter_N
set phy_age $inter_maxp

 }

########## when "ok" button is pushed, confirm the modification 
proc genepara_ok {} {
        global w
        global chr_age
        global phy_age
        global inter_N
        global inter_maxp
	global subpa2
	global subpa3
	global subpa4
	global subpa5
        
        global Flag_simulate        
        set Flag_simulate 0
        
        set c_age [$w.echr get]
        if {$c_age<0} {
		        tk_messageBox -message "Chr_Age mustn't be less than zero!" -type ok
	          }
	      set p_age [$w.ephy get]
	      if {$p_age <=0} {
            tk_messageBox -message "Phr_Age must be 1 -- 6" -type ok
            } elseif {$p_age>6} {
            tk_messageBox -message "Phr_Age must be 1 -- 6" -type ok
            }
        set inter_N $chr_age
        set inter_maxp $phy_age
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
#	form_fit_task
form_task
	}
		
    switch $inter_maxp {
     1 {
        $subpa2 entryconfigure 0 -state disabled
	$subpa2 entryconfigure 1 -state disabled
	$subpa2 entryconfigure 2 -state disabled
	$subpa2 entryconfigure 3 -state disabled
	$subpa2 entryconfigure 4 -state disabled
	$subpa3 entryconfigure 0 -state disabled
	$subpa3 entryconfigure 1 -state disabled
	$subpa3 entryconfigure 2 -state disabled
	$subpa3 entryconfigure 3 -state disabled
	$subpa3 entryconfigure 4 -state disabled
	$subpa4 entryconfigure 0 -state disabled
	$subpa4 entryconfigure 1 -state disabled
	$subpa4 entryconfigure 2 -state disabled
	$subpa4 entryconfigure 3 -state disabled
	$subpa4 entryconfigure 4 -state disabled
	$subpa5 entryconfigure 0 -state disabled
	$subpa5 entryconfigure 1 -state disabled
	$subpa5 entryconfigure 2 -state disabled
	$subpa5 entryconfigure 3 -state disabled
	$subpa5 entryconfigure 4 -state disabled
	}
     2 {
        $subpa2 entryconfigure 0 -state normal
	$subpa2 entryconfigure 1 -state normal
	$subpa2 entryconfigure 2 -state normal
	$subpa2 entryconfigure 3 -state normal
	$subpa2 entryconfigure 4 -state normal
	$subpa3 entryconfigure 0 -state disabled
	$subpa3 entryconfigure 1 -state disabled
	$subpa3 entryconfigure 2 -state disabled
	$subpa3 entryconfigure 3 -state disabled
	$subpa3 entryconfigure 4 -state disabled
	$subpa4 entryconfigure 0 -state disabled
	$subpa4 entryconfigure 1 -state disabled
	$subpa4 entryconfigure 2 -state disabled
	$subpa4 entryconfigure 3 -state disabled
	$subpa4 entryconfigure 4 -state disabled
	$subpa5 entryconfigure 0 -state disabled
	$subpa5 entryconfigure 1 -state disabled
	$subpa5 entryconfigure 2 -state disabled
	$subpa5 entryconfigure 3 -state disabled
	$subpa5 entryconfigure 4 -state disabled
       }
     3 {
        $subpa2 entryconfigure 0 -state normal
	$subpa2 entryconfigure 1 -state normal
	$subpa2 entryconfigure 2 -state normal
	$subpa2 entryconfigure 3 -state normal
	$subpa2 entryconfigure 4 -state normal
	$subpa3 entryconfigure 0 -state normal
	$subpa3 entryconfigure 1 -state normal
	$subpa3 entryconfigure 2 -state normal
	$subpa3 entryconfigure 3 -state normal
	$subpa3 entryconfigure 4 -state normal
	$subpa4 entryconfigure 0 -state disabled
	$subpa4 entryconfigure 1 -state disabled
	$subpa4 entryconfigure 2 -state disabled
	$subpa4 entryconfigure 3 -state disabled
	$subpa4 entryconfigure 4 -state disabled
	$subpa5 entryconfigure 0 -state disabled
	$subpa5 entryconfigure 1 -state disabled
	$subpa5 entryconfigure 2 -state disabled
	$subpa5 entryconfigure 3 -state disabled
	$subpa5 entryconfigure 4 -state disabled
	}
     4 {
        $subpa2 entryconfigure 0 -state normal
	$subpa2 entryconfigure 1 -state normal
	$subpa2 entryconfigure 2 -state normal
	$subpa2 entryconfigure 3 -state normal
	$subpa2 entryconfigure 4 -state normal
	$subpa3 entryconfigure 0 -state normal
	$subpa3 entryconfigure 1 -state normal
	$subpa3 entryconfigure 2 -state normal
	$subpa3 entryconfigure 3 -state normal
	$subpa3 entryconfigure 4 -state normal
	$subpa4 entryconfigure 0 -state normal
	$subpa4 entryconfigure 1 -state normal
	$subpa4 entryconfigure 2 -state normal
	$subpa4 entryconfigure 3 -state normal
	$subpa4 entryconfigure 4 -state normal
	$subpa5 entryconfigure 0 -state disabled
	$subpa5 entryconfigure 1 -state disabled
	$subpa5 entryconfigure 2 -state disabled
	$subpa5 entryconfigure 3 -state disabled
	$subpa5 entryconfigure 4 -state disabled
	}
     5 {
        $subpa2 entryconfigure 0 -state normal
	$subpa2 entryconfigure 1 -state normal
	$subpa2 entryconfigure 2 -state normal
	$subpa2 entryconfigure 3 -state normal
	$subpa2 entryconfigure 4 -state normal
	$subpa3 entryconfigure 0 -state normal
	$subpa3 entryconfigure 1 -state normal
	$subpa3 entryconfigure 2 -state normal
	$subpa3 entryconfigure 3 -state normal
	$subpa3 entryconfigure 4 -state normal
	$subpa4 entryconfigure 0 -state normal
	$subpa4 entryconfigure 1 -state normal
	$subpa4 entryconfigure 2 -state normal
	$subpa4 entryconfigure 3 -state normal
	$subpa4 entryconfigure 4 -state normal
	$subpa5 entryconfigure 0 -state normal
	$subpa5 entryconfigure 1 -state normal
	$subpa5 entryconfigure 2 -state normal
	$subpa5 entryconfigure 3 -state normal
	$subpa5 entryconfigure 4 -state normal
	}
     }          
}


########### when "cancel" button is pushed, cancel the modification 
proc genepara_cancel {} {
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

