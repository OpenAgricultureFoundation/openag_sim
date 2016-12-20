#### inter_geom_colorpara.tcl
proc set_geom_colorpara_new { } {

       global w
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "Global Geometry Parametre Setting -- color"
wm iconname $w "Greenlab"
wm geometry $w 450x300+230+180

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command colorpara_new_ok
button $w.buttons.cancel -text "Cancel" -command colorpara_new_cancel
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok $w.buttons.cancel -side left -expand 1 -fill y

frame $w.left -borderwidth 5
pack $w.left -side top -fill x

label $w.left.lb1 -text "Leaf_Color         " -width 15 -height 2
label $w.left.lb6 -text "alive" -width 8 -relief sunken 
label $w.left.lb7 -text "dead" -width 8 -relief sunken 
label $w.left.lb2 -text "Internode_Color  " -width 15 -height 2
label $w.left.lb8 -text "alive" -width 8 -relief sunken
label $w.left.lb9 -text "dead" -width 8 -relief sunken
label $w.left.lb3 -text "FemaleFruit_Color" -width 15 -height 2
label $w.left.lb10 -text "alive" -width 8 -relief sunken
label $w.left.lb11 -text "dead" -width 8 -relief sunken
label $w.left.lb4 -text "MaleFruit_Color   " -width 15 -height 2
label $w.left.lb12 -text "alive" -width 8 -relief sunken
label $w.left.lb13 -text "dead" -width 8 -relief sunken
label $w.left.lb5 -text "PA_Color            " -width 15
label $w.left.lb14 -text "PA = 1" -width 8 -relief sunken
label $w.left.lb15 -text "PA = 2" -width 8 -relief sunken
label $w.left.lb16 -text "PA = 3" -width 8 -relief sunken
label $w.left.lb17 -text "PA = 4" -width 8 -relief sunken
label $w.left.lb18 -text "PA = 5" -width 8 -relief sunken
label $w.left.lb19 -text "PA = 6" -width 8 -relief sunken

button $w.left.b1 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 6 1}
button $w.left.b2 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 7 2}
button $w.left.b3 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 8 3}
button $w.left.b4 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 9 4}
button $w.left.b5 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 10 5}
button $w.left.b6 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 11 6}
button $w.left.b7 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 12 7}
button $w.left.b8 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 13 8}
button $w.left.b9 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 14 9}
button $w.left.b10 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 15 10}
button $w.left.b11 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 16 11}
button $w.left.b12 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 17 12}
button $w.left.b13 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 18 13}
button $w.left.b14 -text "Choose color" -width 10 -padx 5 \
-command {choose_color 19 14}

grid $w.left.lb1 $w.left.lb6 $w.left.b1 $w.left.lb7 $w.left.b2
grid $w.left.lb2 $w.left.lb8 $w.left.b3 $w.left.lb9 $w.left.b4
grid $w.left.lb3 $w.left.lb10 $w.left.b5 $w.left.lb11 $w.left.b6
grid $w.left.lb4 $w.left.lb12 $w.left.b7 $w.left.lb13 $w.left.b8
grid $w.left.lb5 
grid x $w.left.lb14 $w.left.b9 $w.left.lb15 $w.left.b10
grid x $w.left.lb16 $w.left.b11 $w.left.lb17 $w.left.b12
grid x $w.left.lb18 $w.left.b13 $w.left.lb19 $w.left.b14
     init_widget

}

proc choose_color {i j} {
global w
global Color_B_alive
        global Color_B_dead
        global Color_I_alive
        global Color_I_dead
        global Color_Ff_alive
        global Color_Ff_dead
        global Color_Fm_alive
        global Color_Fm_dead
        global Color_Phy1
        global Color_Phy2
        global Color_Phy3
        global Color_Phy4
        global Color_Phy5
        global Color_Phy6
        
        global inter_Color_B_alive
        global inter_Color_B_dead
        global inter_Color_I_alive
        global inter_Color_I_dead
        global inter_Color_Ff_alive
        global inter_Color_Ff_dead
        global inter_Color_Fm_alive
        global inter_Color_Fm_dead
        global inter_Color_Phy1
        global inter_Color_Phy2
        global inter_Color_Phy3
        global inter_Color_Phy4
        global inter_Color_Phy5
        global inter_Color_Phy6
        
    
$w.left.lb$i configure -bg [tk_chooseColor -initialcolor gray -title "Choose color"]
set col [$w.left.lb$i cget -bg]

if { $col != ""} {
set r1 [string index $col 1]
switch $r1 {
a { set r1 10}
b { set r1 11}
c {set r1 12}
d {set r1 13}
e {set r1 14}
f {set r1 15}
default {set r1 $r1}
}

set r1 [expr 16*$r1]
set r2 [string index $col 2]
switch $r2 {
a { set r2 10}
b { set r2 11}
c {set r2 12}
d {set r2 13}
e {set r2 14}
f {set r2 15}
default {set r2 $r2}
}
set r [expr $r1+$r2]

set g1 [string index $col 3]
switch $g1 {
a { set g1 10}
b { set g1 11}
c {set g1 12}
d {set g1 13}
e {set g1 14}
f {set g1 15}
default {set g1 $g1}
}
set g1 [expr 16*$g1]
set g2 [string index $col 4]
switch $g2 {
a { set g2 10}
b { set g2 11}
c {set g2 12}
d {set g2 13}
e {set g2 14}
f {set g2 15}
default {set g2 $g2}
}
set g [expr $g1+$g2]

set b1 [string index $col 5]
switch $b1 {
a { set b1 10}
b { set b1 11}
c {set b1 12}
d {set b1 13}
e {set b1 14}
f {set b1 15}
default {set b1 $b1}
}
set b1 [expr 16*$b1]
set b2 [string index $col 6]
switch $b2 {
a { set b2 10}
b { set b2 11}
c {set b2 12}
d {set b2 13}
e {set b2 14}
f {set b2 15}
default {set b2 $b2}
}
set b [expr $b1+$b2]

set r [expr $r/255.0]
set g [expr $g/255.0]
set b [expr $b/255.0]
set r [format "%.1f" $r]
set g [format "%.1f" $g]
set b [format "%.1f" $b]

switch $j {
1 {set Color_B_alive [linsert $Color_B_alive 0 $r]
   set Color_B_alive [linsert $Color_B_alive 1 $g]
   set Color_B_alive [linsert $Color_B_alive 2 $b]
   set Color_B_alive [lrange $Color_B_alive 0 2]}
2 {set Color_B_dead [linsert $Color_B_dead 0 $r]
   set Color_B_dead [linsert $Color_B_dead 1 $g]
   set Color_B_dead [linsert $Color_B_dead 2 $b]
   set Color_B_dead [lrange $Color_B_dead 0 2]}
3 {set Color_I_alive [linsert $Color_I_alive 0 $r]
   set Color_I_alive [linsert $Color_I_alive 1 $g]
   set Color_I_alive [linsert $Color_I_alive 2 $b]
   set Color_I_alive [lrange $Color_I_alive 0 2]}
4 {set Color_I_dead [linsert $Color_I_dead 0 $r]
   set Color_I_dead [linsert $Color_I_dead 1 $g]
   set Color_I_dead [linsert $Color_I_dead 2 $b]
   set Color_I_dead [lrange $Color_I_dead 0 2]}
5 {set Color_Ff_alive [linsert $Color_Ff_alive 0 $r]
   set Color_Ff_alive [linsert $Color_Ff_alive 1 $g]
   set Color_Ff_alive [linsert $Color_Ff_alive 2 $b]
   set Color_Ff_alive [lrange $Color_Ff_alive 0 2]}
6 {set Color_Ff_dead [linsert $Color_Ff_dead 0 $r]
   set Color_Ff_dead [linsert $Color_Ff_dead 1 $g]
   set Color_Ff_dead [linsert $Color_Ff_dead 2 $b]
   set Color_Ff_dead [lrange $Color_Ff_dead 0 2]}
7 {set Color_Fm_alive [linsert $Color_Fm_alive 0 $r]
   set Color_Fm_alive [linsert $Color_Fm_alive 1 $g]
   set Color_Fm_alive [linsert $Color_Fm_alive 2 $b]
   set Color_Fm_alive [lrange $Color_Fm_alive 0 2]}
8 {set Color_Fm_dead [linsert $Color_Fm_dead 0 $r]
   set Color_Fm_dead [linsert $Color_Fm_dead 1 $g]
   set Color_Fm_dead [linsert $Color_Fm_dead 2 $b]
   set Color_Fm_dead [lrange $Color_Fm_dead 0 2]}
9 {set Color_Phy1 [linsert $Color_Phy1 0 $r]
   set Color_Phy1 [linsert $Color_Phy1 1 $g]
   set Color_Phy1 [linsert $Color_Phy1 2 $b]
   set Color_Phy1 [lrange $Color_Phy1 0 2]}
10 {set Color_Phy2 [linsert $Color_Phy2 0 $r]
   set Color_Phy2 [linsert $Color_Phy2 1 $g]
   set Color_Phy2 [linsert $Color_Phy2 2 $b]
   set Color_Phy2 [lrange $Color_Phy2 0 2]}
11 {set Color_Phy3 [linsert $Color_Phy3 0 $r]
   set Color_Phy3 [linsert $Color_Phy3 1 $g]
   set Color_Phy3 [linsert $Color_Phy3 2 $b]
   set Color_Phy3 [lrange $Color_Phy3 0 2]}
12 {set Color_Phy4 [linsert $Color_Phy4 0 $r]
   set Color_Phy4 [linsert $Color_Phy4 1 $g]
   set Color_Phy4 [linsert $Color_Phy4 2 $b]
   set Color_Phy4 [lrange $Color_Phy4 0 2]}
13 {set Color_Phy5 [linsert $Color_Phy5 0 $r]
   set Color_Phy5 [linsert $Color_Phy5 1 $g]
   set Color_Phy5 [linsert $Color_Phy5 2 $b]
   set Color_Phy5 [lrange $Color_Phy5 0 2]}
14 {set Color_Phy6 [linsert $Color_Phy6 0 $r]
   set Color_Phy6 [linsert $Color_Phy6 1 $g]
   set Color_Phy6 [linsert $Color_Phy6 2 $b]
   set Color_Phy6 [lrange $Color_Phy6 0 2]}
} 
}
 
}

proc init_widget {} {
        global w
        global inter_maxp
        global inter_Color_B_alive
        global inter_Color_B_dead
        global inter_Color_I_alive
        global inter_Color_I_dead
        global inter_Color_Ff_alive
        global inter_Color_Ff_dead
        global inter_Color_Fm_alive
        global inter_Color_Fm_dead
        global inter_Color_Phy1
        global inter_Color_Phy2
        global inter_Color_Phy3
        global inter_Color_Phy4
        global inter_Color_Phy5
        global inter_Color_Phy6
        global Color_B_alive
        global Color_B_dead
        global Color_I_alive
        global Color_I_dead
        global Color_Ff_alive
        global Color_Ff_dead
        global Color_Fm_alive
        global Color_Fm_dead
        global Color_Phy1
        global Color_Phy2
        global Color_Phy3
        global Color_Phy4
        global Color_Phy5
        global Color_Phy6
        
      set Color_B_alive $inter_Color_B_alive
      set Color_B_dead $inter_Color_B_dead
      set Color_I_alive $inter_Color_I_alive
      set Color_I_dead $inter_Color_I_dead
      set Color_Ff_alive $inter_Color_Ff_alive
      set Color_Ff_dead $inter_Color_Ff_dead
      set Color_Fm_alive $inter_Color_Fm_alive
      set Color_Fm_dead $inter_Color_Fm_dead
      set Color_Phy1 $inter_Color_Phy1
      set Color_Phy2 $inter_Color_Phy2
      set Color_Phy3 $inter_Color_Phy3
      set Color_Phy4 $inter_Color_Phy4
      set Color_Phy5 $inter_Color_Phy5
      set Color_Phy6 $inter_Color_Phy6
        
	set rba [lindex $inter_Color_B_alive 0]
	set rba [expr $rba*255]
	set rba [format "%.0f" $rba]
	set rba [format "%x" $rba]
	if {[string length $rba] == 1} {
	    set test $rba
	    set rba 0
	    append rba $test
	    }  
	set gba [lindex $inter_Color_B_alive 1]
	set gba [expr $gba*255]
	set gba [format "%.0f" $gba]
	set gba [format "%x" $gba]
	if {[string length $gba] == 1} {
	    set test $gba
	    set gba 0
	    append gba $test
	    }  
	set bba [lindex $inter_Color_B_alive 2]
	set bba [expr $bba*255]
	set bba [format "%.0f" $bba]
	set bba [format "%x" $bba]
	if {[string length $bba] == 1} {
	    set test $bba
	    set bba 0
	    append bba $test
	    }  
	set leafalive #
	append leafalive $rba
	append leafalive $gba
	append leafalive $bba
	$w.left.lb6 configure -bg $leafalive
	
	set rbd [lindex $inter_Color_B_dead 0]
	set rbd [expr $rbd*255]
	set rbd [format "%.0f" $rbd]
	set rbd [format "%x" $rbd]
	if {[string length $rbd] == 1} {
	    set test $rbd
	    set rbd 0
	    append rbd $test
	    }  
	set gbd [lindex $inter_Color_B_dead 1]
	set gbd [expr $gbd*255]
	set gbd [format "%.0f" $gbd]
	set gbd [format "%x" $gbd]
	if {[string length $gbd] == 1} {
	    set test $gbd
	    set gbd 0
	    append gbd $test
	    }  
	set bbd [lindex $inter_Color_B_dead 2]
	set bbd [expr $bbd*255]
	set bbd [format "%.0f" $bbd]
	set bbd [format "%x" $bbd]
	if {[string length $bbd] == 1} {
	    set test $bbd
	    set bbd 0
	    append bbd $test
	    }  
	set leafdead #
	append leafdead $rbd
	append leafdead $gbd
	append leafdead $bbd
	$w.left.lb7 configure -bg $leafdead
	
	set ria [lindex $inter_Color_I_alive 0]
	set ria [expr $ria*255]
	set ria [format "%.0f" $ria]
	set ria [format "%x" $ria]
	if {[string length $ria] == 1} {
	    set test $ria
	    set ria 0
	    append ria $test
	    }  
	set gia [lindex $inter_Color_I_alive 1]
	set gia [expr $gia*255]
	set gia [format "%.0f" $gia]
	set gia [format "%x" $gia]
	if {[string length $gia] == 1} {
	    set test $gia
	    set gia 0
	    append gia $test
	    }  
	set bia [lindex $inter_Color_I_alive 2]
	set bia [expr $bia*255]
	set bia [format "%.0f" $bia]
	set bia [format "%x" $bia]
	if {[string length $bia] == 1} {
	    set test $bia
	    set bia 0
	    append bia $test
	    }  
	set internodealive #
	append internodealive $ria
	append internodealive $gia
	append internodealive $bia
	$w.left.lb8 configure -bg $internodealive
	
	set rid [lindex $inter_Color_I_dead 0]
	set rid [expr $rid*255]
	set rid [format "%.0f" $rid]
	set rid [format "%x" $rid]
	if {[string length $rid] == 1} {
	    set test $rid
	    set rid 0
	    append rid $test
	    }  
	set gid [lindex $inter_Color_I_dead 1]
	set gid [expr $gid*255]
	set gid [format "%.0f" $gid]
	set gid [format "%x" $gid]
	if {[string length $gid] == 1} {
	    set test $gid
	    set gid 0
	    append gid $test
	    }  
	set bid [lindex $inter_Color_I_dead 2]
	set bid [expr $bid*255]
	set bid [format "%.0f" $bid]
	set bid [format "%x" $bid]
	if {[string length $bid] == 1} {
	    set test $bid
	    set bid 0
	    append bid $test
	    }  
	set internodedead #
	append internodedead $rid
	append internodedead $gid
	append internodedead $bid
	$w.left.lb9 configure -bg $internodedead
	
	set rfa [lindex $inter_Color_Ff_alive 0]
	set rfa [expr $rfa*255]
	set rfa [format "%.0f" $rfa]
	set rfa [format "%x" $rfa]
	if {[string length $rfa] == 1} {
	    set test $rfa
	    set rfa 0
	    append rfa $test
	    }  
	set gfa [lindex $inter_Color_Ff_alive 1]
	set gfa [expr $gfa*255]
	set gfa [format "%.0f" $gfa]
	set gfa [format "%x" $gfa]
	if {[string length $gfa] == 1} {
	    set test $gfa
	    set gfa 0
	    append gfa $test
	    }  
	set bfa [lindex $inter_Color_Ff_alive 2]
	set bfa [expr $bfa*255]
	set bfa [format "%.0f" $bfa]
	set bfa [format "%x" $bfa]
	if {[string length $bfa] == 1} {
	    set test $bfa
	    set bfa 0
	    append bfa $test
	    } 
	set ffruitalive #
	append ffruitalive $rfa
	append ffruitalive $gfa
	append ffruitalive $bfa
	$w.left.lb10 configure -bg $ffruitalive
	 
	set rfd [lindex $inter_Color_Ff_dead 0]
	set rfd [expr $rfd*255]
	set rfd [format "%.0f" $rfd]
	set rfd [format "%x" $rfd]
	if {[string length $rfd] == 1} {
	    set test $rfd
	    set rfd 0
	    append rfd $test
	    }  
	set gfd [lindex $inter_Color_Ff_dead 1]
	set gfd [expr $gfd*255]
	set gfd [format "%.0f" $gfd]
	set gfd [format "%x" $gfd]
	if {[string length $gfd] == 1} {
	    set test $gfd
	    set gfd 0
	    append gfd $test
	    }  
	set bfd [lindex $inter_Color_Ff_dead 2]
	set bfd [expr $bfd*255]
	set bfd [format "%.0f" $bfd]
	set bfd [format "%x" $bfd]
	if {[string length $bfd] == 1} {
	    set test $bfd
	    set bfd 0
	    append bfd $test
	    }  
	set ffruitdead #
	append ffruitdead $rfd
	append ffruitdead $gfd
	append ffruitdead $bfd
	$w.left.lb11 configure -bg $ffruitdead
	
	set rma [lindex $inter_Color_Fm_alive 0]
	set rma [expr $rma*255]
	set rma [format "%.0f" $rma]
	set rma [format "%x" $rma]
	if {[string length $rma] == 1} {
	    set test $rma
	    set rma 0
	    append rma $test
	    }  
	set gma [lindex $inter_Color_Fm_alive 1]
	set gma [expr $gma*255]
	set gma [format "%.0f" $gma]
	set gma [format "%x" $gma]
	if {[string length $gma] == 1} {
	    set test $gma
	    set gma 0
	    append gma $test
	    }  
	set bma [lindex $inter_Color_Fm_alive 2]
	set bma [expr $bma*255]
	set bma [format "%.0f" $bma]
	set bma [format "%x" $bma]
	if {[string length $bma] == 1} {
	    set test $bma
	    set bma 0
	    append bma $test
	    }  
	set mfruitalive #
	append mfruitalive $rma
	append mfruitalive $gma
	append mfruitalive $bma
	$w.left.lb12 configure -bg $mfruitalive   
	
	set rmd [lindex $inter_Color_Fm_dead 0]
	set rmd [expr $rmd*255]
	set rmd [format "%.0f" $rmd]
	set rmd [format "%x" $rmd]
	if {[string length $rmd] == 1} {
	    set test $rmd
	    set rmd 0
	    append rmd $test
	    }  
	set gmd [lindex $inter_Color_Fm_dead 1]
	set gmd [expr $gmd*255]
	set gmd [format "%.0f" $gmd]
	set gmd [format "%x" $gmd]
	if {[string length $gmd] == 1} {
	    set test $gmd
	    set gmd 0
	    append gmd $test
	    }  
	set bmd [lindex $inter_Color_Fm_dead 2]
	set bmd [expr $bmd*255]
	set bmd [format "%.0f" $bmd]
	set bmd [format "%x" $bmd]
	if {[string length $bmd] == 1} {
	    set test $bmd
	    set bmd 0
	    append bmd $test
	    }  
	set mfruitdead #
	append mfruitdead $rmd
	append mfruitdead $gmd
	append mfruitdead $bmd
	$w.left.lb13 configure -bg $mfruitdead
	 
	set rp1 [lindex $inter_Color_Phy1 0]
	set rp1 [expr $rp1*255]
	set rp1 [format "%.0f" $rp1]
	set rp1 [format "%x" $rp1]
	if {[string length $rp1] == 1} {
	    set test $rp1
	    set rp1 0
	    append rp1 $test
	    }  
	set gp1 [lindex $inter_Color_Phy1 1]
	set gp1 [expr $gp1*255]
	set gp1 [format "%.0f" $gp1]
	set gp1 [format "%x" $gp1]
	if {[string length $gp1] == 1} {
	    set test $gp1
	    set gp1 0
	    append gp1 $test
	    }  
	set bp1 [lindex $inter_Color_Phy1 2]
	set bp1 [expr $bp1*255]
	set bp1 [format "%.0f" $bp1]
	set bp1 [format "%x" $bp1]
	if {[string length $bp1] == 1} {
	    set test $bp1
	    set bp1 0
	    append bp1 $test
	    }  
	set phy1 #
	append phy1 $rp1
	append phy1 $gp1
	append phy1 $bp1
	$w.left.lb14 configure -bg $phy1
	
	set rp2 [lindex $inter_Color_Phy2 0]
	set rp2 [expr $rp2*255]
	set rp2 [format "%.0f" $rp2]
	set rp2 [format "%x" $rp2]
	if {[string length $rp2] == 1} {
	    set test $rp2
	    set rp2 0
	    append rp2 $test
	    }  
	set gp2 [lindex $inter_Color_Phy2 1]
	set gp2 [expr $gp2*255]
	set gp2 [format "%.0f" $gp2]
	set gp2 [format "%x" $gp2]
	if {[string length $gp2] == 1} {
	    set test $gp2
	    set gp2 0
	    append gp2 $test
	    }  
	set bp2 [lindex $inter_Color_Phy2 2]
	set bp2 [expr $bp2*255]
	set bp2 [format "%.0f" $bp2]
	set bp2 [format "%x" $bp2]
	if {[string length $bp2] == 1} {
	    set test $bp2
	    set bp2 0
	    append bp2 $test
	    }  
	set phy2 #
	append phy2 $rp2
	append phy2 $gp2
	append phy2 $bp2
	$w.left.lb15 configure -bg $phy2
	
	set rp3 [lindex $inter_Color_Phy3 0]
	set rp3 [expr $rp3*255]
	set rp3 [format "%.0f" $rp3]
	set rp3 [format "%x" $rp3]
	if {[string length $rp3] == 1} {
	    set test $rp3
	    set rp3 0
	    append rp3 $test
	    }  
	set gp3 [lindex $inter_Color_Phy3 1]
	set gp3 [expr $gp3*255]
	set gp3 [format "%.0f" $gp3]
	set gp3 [format "%x" $gp3]
	if {[string length $gp3] == 1} {
	    set test $gp3
	    set gp3 0
	    append gp3 $test
	    }  
	set bp3 [lindex $inter_Color_Phy3 2]
	set bp3 [expr $bp3*255]
	set bp3 [format "%.0f" $bp3]
	set bp3 [format "%x" $bp3]
	if {[string length $bp3] == 1} {
	    set test $bp3
	    set bp3 0
	    append bp3 $test
	    }  
	set phy3 #
	append phy3 $rp3
	append phy3 $gp3
	append phy3 $bp3
	$w.left.lb16 configure -bg $phy3
	
	set rp4 [lindex $inter_Color_Phy4 0]
	set rp4 [expr $rp4*255]
	set rp4 [format "%.0f" $rp4]
	set rp4 [format "%x" $rp4]
	if {[string length $rp4] == 1} {
	    set test $rp4
	    set rp4 0
	    append rp4 $test
	    }  
	set gp4 [lindex $inter_Color_Phy4 1]
	set gp4 [expr $gp4*255]
	set gp4 [format "%.0f" $gp4]
	set gp4 [format "%x" $gp4]
	if {[string length $gp4] == 1} {
	    set test $gp4
	    set gp4 0
	    append gp4 $test
	    }  
	set bp4 [lindex $inter_Color_Phy4 2]
	set bp4 [expr $bp4*255]
	set bp4 [format "%.0f" $bp4]
	set bp4 [format "%x" $bp4]
	if {[string length $bp4] == 1} {
	    set test $bp4
	    set bp4 0
	    append bp4 $test
	    }  
	set phy4 #
	append phy4 $rp4
	append phy4 $gp4
	append phy4 $bp4
	$w.left.lb17 configure -bg $phy4
	
	set rp5 [lindex $inter_Color_Phy5 0]
	set rp5 [expr $rp5*255]
	set rp5 [format "%.0f" $rp5]
	set rp5 [format "%x" $rp5]
	if {[string length $rp5] == 1} {
	    set test $rp5
	    set rp5 0
	    append rp5 $test
	    }  
	set gp5 [lindex $inter_Color_Phy5 1]
	set gp5 [expr $gp5*255]
	set gp5 [format "%.0f" $gp5]
	set gp5 [format "%x" $gp5]
	if {[string length $gp5] == 1} {
	    set test $gp5
	    set gp5 0
	    append gp5 $test
	    }  
	set bp5 [lindex $inter_Color_Phy5 2]
	set bp5 [expr $bp5*255]
	set bp5 [format "%.0f" $bp5]
	set bp5 [format "%x" $bp5]
	if {[string length $bp5] == 1} {
	    set test $bp5
	    set bp5 0
	    append bp5 $test
	    }  
	set phy5 #
	append phy5 $rp5
	append phy5 $gp5
	append phy5 $bp5
	$w.left.lb18 configure -bg $phy5
	
	set rp6 [lindex $inter_Color_Phy6 0]
	set rp6 [expr $rp6*255]
	set rp6 [format "%.0f" $rp6]
	set rp6 [format "%x" $rp6]
	if {[string length $rp6] == 1} {
	    set test $rp6
	    set rp6 0
	    append rp6 $test
	    }  
	set gp6 [lindex $inter_Color_Phy6 1]
	set gp6 [expr $gp6*255]
	set gp6 [format "%.0f" $gp6]
	set gp6 [format "%x" $gp6]
	if {[string length $gp6] == 1} {
	    set test $gp6
	    set gp6 0
	    append gp6 $test
	    }  
	set bp6 [lindex $inter_Color_Phy6 2]
	set bp6 [expr $bp6*255]
	set bp6 [format "%.0f" $bp6]
	set bp6 [format "%x" $bp6]
	if {[string length $bp6] == 1} {
	    set test $bp6
	    set bp6 0
	    append bp6 $test
	    }  
	set phy6 #
	append phy6 $rp6
	append phy6 $gp6
	append phy6 $bp6
	$w.left.lb19 configure -bg $phy6
	
############ change entry's status based on Phy_Age ##########
        set j $inter_maxp
        set j [expr $inter_maxp+13]
        if {$j<19} {
           while {$j<19} {
                 incr j
                 $w.left.lb$j configure -state disabled  
		 set h [expr $j-5]  
		 $w.left.b$h configure -state disabled                      
                   }
                   } else {
                      for {set i 14} {$i<=19} {incr i} {
                           $w.left.lb$i configure -state normal
			   set h [expr $j-5]
			   $w.left.b$h configure -state normal
                          }
                        }            

}

########## when "ok" button is pushed, confirm the modification 
proc colorpara_new_ok {} {
        global w
        global inter_Color_B_alive
        global inter_Color_B_dead
        global inter_Color_I_alive
        global inter_Color_I_dead
        global inter_Color_Ff_alive
        global inter_Color_Ff_dead
        global inter_Color_Fm_alive
        global inter_Color_Fm_dead
        global inter_Color_Phy1
        global inter_Color_Phy2
        global inter_Color_Phy3
        global inter_Color_Phy4
        global inter_Color_Phy5
        global inter_Color_Phy6
global Color_B_alive
        global Color_B_dead
        global Color_I_alive
        global Color_I_dead
        global Color_Ff_alive
        global Color_Ff_dead
        global Color_Fm_alive
        global Color_Fm_dead
        global Color_Phy1
        global Color_Phy2
        global Color_Phy3
        global Color_Phy4
        global Color_Phy5
        global Color_Phy6

        global Flag_simulate        
        set Flag_simulate 0  
        
	set inter_Color_B_alive [lrange $Color_B_alive 0 2]
	set inter_Color_B_dead [lrange $Color_B_dead 0 2]
	set inter_Color_I_alive [lrange $Color_I_alive 0 2]
	set inter_Color_I_dead [lrange $Color_I_dead 0 2]
	set inter_Color_Ff_alive [lrange $Color_Ff_alive 0 2]
	set inter_Color_Ff_dead [lrange $Color_Ff_dead 0 2]
	set inter_Color_Fm_alive [lrange $Color_Fm_alive 0 2]
	set inter_Color_Fm_dead [lrange $Color_Fm_dead 0 2]
	set inter_Color_Phy1 [lrange $Color_Phy1 0 2]
	set inter_Color_Phy2 [lrange $Color_Phy2 0 2]
	set inter_Color_Phy3 [lrange $Color_Phy3 0 2]
	set inter_Color_Phy4 [lrange $Color_Phy4 0 2]
	set inter_Color_Phy5 [lrange $Color_Phy5 0 2]
	set inter_Color_Phy6 [lrange $Color_Phy6 0 2]
	

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
proc colorpara_new_cancel {} {
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

