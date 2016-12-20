proc treevisu {} {

       global w
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "About Tree_visu.exe"
wm iconname $w "Tree_visu"

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command aboutTB_ok
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok -side left -expand 1 -fill y

##### Creat a text on which the content of toolbox is shown 
set t $w.t
text $t -relief raised  -border 2 -width 60 -height 20 -font {Courier -12} \
-yscrollcommand {$w.scroll set}
scrollbar $w.scroll -command {$t yview}
pack $w.scroll -side right -fill y
pack $w.t -side left -fill both -expand 1

$t delete 0.0 end
$t insert end "\n    GreenScilab WebSite : www.greenscilab.org\
               \n\n    Copyright (c) 2004-2006 LIAMA
               \n\n    Run environment:\
               \n      Windows 2000/XP 
               \n\n    Tree_visu.exe Developpers\
               \n      Jun TENG           jteng@liama.ia.ac.cn\
               \n      Ning WANG          nwang@liama.ia.ac.cn\
               "
$t configure -state disabled

}

proc aboutTB_ok {} {
    global w
    destroy $w
    }
    
    

                                           
