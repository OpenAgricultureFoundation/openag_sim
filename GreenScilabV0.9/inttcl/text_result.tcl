#proc text_result {} {

global INTER_SYS_DIR
global c
global t1
global mw

catch {destroy $c}
destroy $mw.f1
destroy $mw.f1.yscroll
destroy $mw.xscroll
catch {destroy $t1}
scrollbar $mw.xscroll -command {$t1 xview} -orient horizontal
pack $mw.xscroll -side bottom -fill x
frame $mw.f1
pack $mw.f1 -side bottom
set t1 $mw.f1.t
text $t1 -width 87 -height 40 -yscrollcommand {$mw.f1.yscroll set} -xscrollcommand {$mw.xscroll set} -background white -wrap none
scrollbar $mw.f1.yscroll -command {$t1 yview}
pack $mw.f1.t $mw.f1.yscroll -side left -fill y
	     $t1 delete 0.0 end
	     set f [open [file join $INTER_SYS_DIR bin/out_result.sci] r]
	     while {[gets $f line] >= 0} {
		$t1 insert end $line 
		$t1 insert end "\n"
	     }
	  $t1 configure -state disabled
             close $f           	     
#}
