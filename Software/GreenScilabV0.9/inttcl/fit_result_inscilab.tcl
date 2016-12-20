

       global INTER_SYS_DIR
       global fcontent
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "Fitting results"
wm iconname $w "Greenlab"

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.yes -text "Accept the results" -command fit_yes
button $w.buttons.no -text "Cancel" -command fit_no
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.yes $w.buttons.no -side left -expand 1 -fill y

frame $w.f1
pack $w.f1 -side bottom
set t1 $w.f1.t
text $t1 -width 40 -height 30 -yscrollcommand {$w.f1.yscroll set} -background white -wrap none
scrollbar $w.f1.yscroll -command {$t1 yview}
pack $w.f1.t $w.f1.yscroll -side left -fill y

set i 1
$t1 delete 0.0 end
set f [open [file join $INTER_SYS_DIR bin/fit_out_result.sci] r]
while {[gets $f line] >= 0} {
$t1 insert end $line 
$t1 insert end "\n"
set fcontent($i) $line 
incr i
}
$t1 configure -state disabled
close $f  

           

proc fit_yes {} {
global inter_S_B
global inter_S_P
global inter_S_I
global inter_S_Ff
global inter_S_Fm
global inter_S_L
global inter_S_R
global inter_t_exp
global inter_Bt_a
global inter_Bt_b
global inter_Sp
global inter_r_B
global inter_r_P
global inter_r_R
global inter_rp
global inter_kp
global inter_Q0
global inter_dQ0
global inter_a_bI
global inter_a_aI
global inter_a_bP
global inter_a_aP
global inter_Th_B
global inter_Den_Ff
global inter_Den_Fm
global inter_Den_I

global w
global mw
global INTER_SYS_DIR
global fcontent
global targetfilename

    set targetfile_types {
        {"Target Files" { .sci}  }
	      {"All Files" * }
      }
  set temp_path [file join $INTER_SYS_DIR parafiles]
	cd $temp_path
	set temp_filename [tk_getSaveFile -defaultextension .sci -filetypes $targetfile_types -initialfile $targetfilename]
	cd $INTER_SYS_DIR	 
	
     
if {[string compare $temp_filename ""] != 0} {
		
		
set i 1
while { [expr $i <= [array size fcontent]] } {
        set tline [string trim $fcontent($i)]
        while { [expr [string length $tline] == 0] }  {
    	          incr i 
		            if { [expr $i > [array size fcontent]] } break
    	           set tline $fcontent($i)
               }
	       if { [expr $i > [array size fcontent]] } break
         set cc [fparse $tline ] 
         for {set j 0 } { $j < [llength $cc] } {incr j } {
		           set c([expr $j+1]) [lindex $cc $j]
	            }
########################## c is a array ;  cc is a list  ###############
     		
	   switch [string trim $c(1)] {
    "x_t_exp" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_t_exp 1 6]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_t_exp [lrange $test 0 6]
    	             }
    	             if {$h==7} {
    	               set test [lrange $inter_t_exp 0 5]
    	               set test [linsert $test 6 $c(6)]
    	               set inter_t_exp [lrange $test 0 6] 
    	             }
    	             set test1 [lrange $inter_t_exp 0 [expr $h-2]]
    	             set test2 [lrange $inter_t_exp $h 6]
    	             set test [concat $test1 $test2]
    	             set inter_t_exp [linsert $test [expr $h-1] $c(6)]
    	           }
    "x_Bt_a" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Bt_a 1 6]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Bt_a [lrange $test 0 6]
    	             }
    	             if {$h==7} {
    	               set test [lrange $inter_Bt_a 0 5]
    	               set test [linsert $test 6 $c(6)]
    	               set inter_Bt_a [lrange $test 0 6] 
    	             }
    	             set test1 [lrange $inter_Bt_a 0 [expr $h-2]]
    	             set test2 [lrange $inter_Bt_a $h 6]
    	             set test [concat $test1 $test2]
    	             set inter_Bt_a [linsert $test [expr $h-1] $c(6)]
    	             }
    "x_Bt_b" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Bt_b 1 6]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Bt_b [lrange $test 0 6]
    	             }
    	             if {$h==7} {
    	               set test [lrange $inter_Bt_b 0 5]
    	               set test [linsert $test 6 $c(6)]
    	               set inter_Bt_b [lrange $test 0 6] 
    	             }
    	             set test1 [lrange $inter_Bt_b 0 [expr $h-2]]
    	             set test2 [lrange $inter_Bt_b $h 6]
    	             set test [concat $test1 $test2]
    	             set inter_Bt_b [linsert $test [expr $h-1] $c(6)]
    	             }
    	"x_S_B" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_B 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_B [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_B 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_B [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_B 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_B $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_B [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_P" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_P 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_P [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_P 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_P [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_P 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_P $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_P [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_I" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_I 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_I [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_I 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_I [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_I 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_I $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_I [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_Ff" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_Ff 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_Ff [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_Ff 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_Ff [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_Ff 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_Ff $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_Ff [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_Fm" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_Fm 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_Fm [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_Fm 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_Fm [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_Fm 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_Fm $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_Fm [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_L" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_L 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_L [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_L 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_L [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_L 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_L $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_L [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_S_R" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_S_R 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_S_R [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_S_R 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_S_R [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_S_R 0 [expr $h-2]]
    	             set test2 [lrange $inter_S_R $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_S_R [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_a_aI" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_a_aI 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_a_aI [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_a_aI 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_a_aI [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_a_aI 0 [expr $h-2]]
    	             set test2 [lrange $inter_a_aI $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_a_aI [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_a_bI" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_a_bI 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_a_bI [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_a_bI 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_a_bI [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_a_bI 0 [expr $h-2]]
    	             set test2 [lrange $inter_a_bI $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_a_bI [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_a_bP" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_a_bP 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_a_bP [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_a_bP 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_a_bP [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_a_bP 0 [expr $h-2]]
    	             set test2 [lrange $inter_a_bP $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_a_bP [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_a_aP" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_a_aP 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_a_aP [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_a_aP 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_a_aP [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_a_aP 0 [expr $h-2]]
    	             set test2 [lrange $inter_a_aP $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_a_aP [linsert $test [expr $h-1] $c(6)]
    	         }  
    	"x_Th_B" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Th_B 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Th_B [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_Th_B 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_Th_B [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_Th_B 0 [expr $h-2]]
    	             set test2 [lrange $inter_Th_B $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_Th_B [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_Den_Ff" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Den_Ff 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Den_Ff [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_Den_Ff 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_Den_Ff [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_Den_Ff 0 [expr $h-2]]
    	             set test2 [lrange $inter_Den_Ff $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_Den_Ff [linsert $test [expr $h-1] $c(6)]
    	         }  
    	"x_Den_Fm" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Den_Fm 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Den_Fm [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_Den_Fm 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_Den_Fm [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_Den_Fm 0 [expr $h-2]]
    	             set test2 [lrange $inter_Den_Fm $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_Den_Fm [linsert $test [expr $h-1] $c(6)]
    	         }
    	"x_Den_I" {
    	             set h $c(3)
    	             if {$h==1} {
    	               set test [lrange $inter_Den_I 1 5]
    	               set test [linsert $test 0 $c(6)]
    	               set inter_Den_I [lrange $test 0 5]
    	             }
    	             if {$h==6} {
    	               set test [lrange $inter_Den_I 0 4]
    	               set test [linsert $test 5 $c(6)]
    	               set inter_Den_I [lrange $test 0 5] 
    	             }
    	             set test1 [lrange $inter_Den_I 0 [expr $h-2]]
    	             set test2 [lrange $inter_Den_I $h 5]
    	             set test [concat $test1 $test2]
    	             set inter_Den_I [linsert $test [expr $h-1] $c(6)]
    	         }   
    	"x_r_B" {
    	             set inter_r_B $c(3)
    	        }
    	"x_r_P" {
    	             set inter_r_P $c(3)
    	        }
    	"x_r_R" {
    	             set inter_r_R $c(3)
    	        }
    	"x_Sp" {
    	             set inter_Sp $c(3)
    	       }
    	"x_rp" {
    	             set inter_rp $c(3)
    	       }
    	"x_kp" {
    	             set inter_kp $c(3)
    	       }
    	"x_Q0" {
    	             set inter_Q0 $c(3)
    	       }
     "x_dQ0" {
                  set inter_dQ0 $c(3)
             }
             
    "" {
    	puts empty_entry
       	} 
    default {
    	puts default_entry
        }
                   
      }
       incr i
    }
     
     form_fit_task
     global Flag_test
     global Flag_target
     global targetfilename
     set targetfilename ""
     set Flag_test 1
     set Flag_target 0
     
     
     set f [open $temp_filename w]
		set line [$mw.t get 0.0 end]
		puts $f $line
		close $f
		}
     
		destroy $w


}

proc fit_no {} {
global w
destroy $w
}

proc fparse {aline} {
	scan $aline "%s %s %s %s %s %s %s %s %s" fc(1) fc(2) fc(3) fc(4) fc(5) fc(6) \
	                                         fc(7) fc(8) fc(9)
	for {set j  1 } { $j <= [array size fc] } {incr j } {
		lappend b $fc($j)
	}
    unset fc
	set c $b
}

