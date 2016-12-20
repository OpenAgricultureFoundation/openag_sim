proc inter_help {} {

       global ww
       global INTER_SYS_DIR
############Create a window for General Parametre Setting
#label .lab
set ww .lab1
catch {destroy $ww}
toplevel $ww
wm title $ww "Help"
wm iconname $ww "Greenlab"

##### create statusbar
set statusbar "    "
frame $ww.statusBar
label $ww.statusBar.label -textvariable statusbar -relief sunken -bd 1 -font "Helvetica 10" -anchor w
pack $ww.statusBar.label -side left -padx 2 -expand yes -fill both
pack $ww.statusBar -side bottom -fill x -pady 2

##### create menus
menu $ww.menu -tearoff 0

set m $ww.menu.task
menu $m -tearoff 0
$ww.menu add cascade -label "Introduction" -menu $m -underline 0

$m add command -label "Features" -command Features
$m add command -label "Running" -command Run
$m add cascade -label "Main Menu" -menu $m.mainmenu
set submainmenu [menu $m.mainmenu -tearoff 0]
$submainmenu add command -label "File" -command File
$submainmenu add command -label "Parameter" -command Parameter
$submainmenu add command -label "Simulate" -command Simulate
$submainmenu add command -label "Output" -command Output
$submainmenu add command -label "Fit" -command Fit
$submainmenu add command -label "Demos" -command Demo
$submainmenu add command -label "About" -command About

set sm $ww.menu.submenu
menu $sm -tearoff 0
$ww.menu add cascade -label "Parameter" -menu $sm -underline 0

$sm add command -label "Plant age" -command genpara
$sm add cascade -label "Topological Parameter" -menu $sm.top
set subtopmenu [menu $sm.top -tearoff 0]
$subtopmenu add command -label "macrostate topological parameter" -command mactoppara
##$subtopmenu add command -label "macrostate(time) topological parameter" -command mactimtoppara
$subtopmenu add command -label "microstate topological parameter" -command mictoppara
$sm add cascade -label "Functional Parameter" -menu $sm.func
set subfuncmenu [menu $sm.func -tearoff 0]
$subfuncmenu add command -label "sink and source" -command funpara
$subfuncmenu add command -label "time functional" -command mactimtoppara
$sm add command -label "Allometry Parameter" -command allopara
$sm add cascade -label "Geometrical Parameter" -menu $sm.geo
set subgeomenu [menu $sm.geo -tearoff 0]
$subgeomenu add command -label "shape" -command shapegeopara
$subgeomenu add command -label "color" -command colorgeopara
$subgeomenu add command -label "macrostate" -command macgeopara
$subgeomenu add command -label "microstate" -command micgeopara
$sm add command -label "Environmental Parameter" -command envpara
$sm add cascade -label "Output Parameter" -menu $sm.outp
set suboutpmenu [menu $sm.outp -tearoff 0]
$suboutpmenu add command -label "organ" -command numorgpara
$suboutpmenu add command -label "demand" -command numdempara
$suboutpmenu add command -label "figure" -command curvepara
$suboutpmenu add command -label "3D" -command 3Dpara


$ww configure -menu $ww.menu
bind Menu <<MenuSelect>> {
    global $statusbar
    if {[catch {%W entrycget active -label} label]} {
	set label "    "
    }
    set statusbar $label
    update idletasks
}
############ create a text on which the content of help is shown
set t $ww.t
text $t -relief raised  -border 1 -width 85 -height 30 \
-yscrollcommand {$ww.scroll set} -font {Courier -12}
scrollbar $ww.scroll -command {$t yview}
pack $ww.scroll -side right -fill y
pack $ww.t -side left -fill both -expand 1

}

proc Features {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/features.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc Run {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/run.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc File {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/file.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc Parameter {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/parameter.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc Simulate {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/simulate.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc Output {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
		 $t insert end "MENU Ouput\n\nset the output options of the GL model. \
		                The detail information is in the menu Submenu." 
}
proc Fit {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/fit.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc Demo {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/demo.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc About {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/about.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc genpara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/general_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc mactoppara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/macrostate_topological_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc mactimtoppara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/macrostate(time)_topological_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
} 
proc mictoppara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/microstate_topological_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc funpara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/functional_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc allopara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/allometry_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc shapegeopara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/shape_geometrical_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
} 
proc colorgeopara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/color_geometrical_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc macgeopara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/macrostate_geometrical_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
} 
proc micgeopara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/microstate_geometrical_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc envpara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/environmental_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc numorgpara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/number_organ_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc numdempara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/number_demand_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc curvepara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/curve_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}
proc 3Dpara {} {
     global ww
     set t $ww.t
     global INTER_SYS_DIR
     $t delete 0.0 end
     set INTER_MAN_DIR [file join $INTER_SYS_DIR man/help/3D_para.m]
     set f [open $INTER_MAN_DIR r]
		 while {[gets $f line] >= 0} {
			  $t insert end $line 
			  $t insert end "\n"
		}
}



