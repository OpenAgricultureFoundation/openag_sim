##### create main window

##### set directory ENV variables
global INTER_SYS_DIR
set INTER_SYS_DIR [pwd]
ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";

global Flag_simulate
global Flag_fit
global Flag_option
global Flag_C_code
global Flag_Sci_code
global Flag_save_simu
global Flag_save_fit
set Flag_C_code 1
set Flag_Sci_code 0
set Flag_simulate 0		
set Flag_fit 0

global mw
label .a
set mw .a 
catch {destroy $mw}
toplevel $mw
wm title $mw "GreenScilab"
wm iconname $mw "GreenLab"
wm geometry $mw 640x520+200+100          

##### set file type when use open testfile dialog
set filename ""
set file_types {
        {"Test Files" { .sci}  }
	{"All Files" * }
}
##### set file type when use open targetfile dialog
set targetfilename ""
set targetfile_types {
        {"Target Files" { .dat}  }
	{"All Files" * }
}
##### create statusbar
set statusbar "    "
frame $mw.statusBar
label $mw.statusBar.label -textvariable statusbar -relief sunken -bd 1 -font "Helvetica 10" -anchor w
pack $mw.statusBar.label -side left -padx 2 -expand yes -fill both
pack $mw.statusBar -side bottom -fill x -pady 2

##### Creat a text on which the content of test/target/demos file is shown 
set t $mw.t
text $t -relief raised  -border 1 -width 105 -height 30 -font {Courier -12} \
 -yscrollcommand {$mw.scroll set}
scrollbar $mw.scroll -command {$t yview}
#pack $mw.scroll -side right -fill y
#pack $mw.t -side left -fill both -expand 1

set ttar $mw.ttar
text $ttar -relief raised  -border 1 -width 105 -height 30 -font {Courier -12} \
 -yscrollcommand {$mw.ttarscroll set}
scrollbar $mw.ttarscroll -command {$ttar yview}

############# Creat a back up text for fitting    adding the last part of targetfile
text $mw.backt -relief raised  -border 1 -width 105 -height 30 -font {Courier -12} \
           -yscrollcommand {$mw.backscroll set}
scrollbar $mw.backscroll -command {$mw.backt yview}

############# Creat a back up text for fitting    adding the last part of targetfile
text $mw.backt1 -relief raised  -border 1 -width 105 -height 30 -font {Courier -12} \
           -yscrollcommand {$mw.back1scroll set}
scrollbar $mw.back1scroll -command {$mw.backt1 yview}

############### don't consider the platform #############
##########################################################
#set fibegin_uni $INTER_SYS_DIR
#set fibegin_uni [file join inttcl/begin_linux.m]

#$t delete 0.0 end
#set f [open $fibegin_uni r]
#while {[gets $f line] >= 0} {
			#$t insert end $line 
			#$t insert end "\n"
		  #}
#close $f

#########################################################
#########################################################
set path_form_task [file join $INTER_SYS_DIR inttcl/inter_form_task.tcl]
source $path_form_task
set path_form_fit_task [file join $INTER_SYS_DIR inttcl/inter_form_fit_task.tcl]
source $path_form_fit_task
set path_fit_output [file join $INTER_SYS_DIR inttcl/fit_result.tcl]
source $path_fit_output


##### create menus
menu $mw.menu -tearoff 0

set m $mw.menu.task
menu $m -tearoff 0
$mw.menu add cascade -label "File" -menu $m -underline 0

set k_test 0
set k_target 0
set Flag_save_simu 0
set Flag_save_fit 0
set Flag_option 0

$m add command -label "Load parameters" -command {
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
	
	set Flag_save_simu 0
	set Flag_option 0
	set Flag_test 1
	set Flag_target 0
	incr k_test
	set targetfilename ""
	set temptarget_targetfilename ""
	set temp_path [file join $INTER_SYS_DIR parafiles]
	cd $temp_path
	set tempfilename [tk_getOpenFile -filetypes $file_types]
	cd $INTER_SYS_DIR	
	if {$k_test == 1} {
	    set filename $tempfilename
	    set Flag_simulate 0
	    set Flag_fit 0
	} else {
	    if { [string compare $tempfilename ""] == 0} {
	         set filename $filename
	         set Flag_simulate $Flag_simulate
	         set Flag_fit 0
	       } else {
	         set filename $tempfilename
	         set Flag_simulate 0
	         set Flag_fit 0
	         }
	   }  	
	set i 1
	if {[string compare $filename ""] != 0} {
		$t delete 0.0 end
		$t configure -width 105
		set f [open $filename r]
		while {[gets $f line] >= 0} {
			$t insert end $line 
			$t insert end "\n"
			set content($i) $line 
			incr i
		}
		close $f           
		set path [file join $INTER_SYS_DIR inttcl/inter_parse_task.tcl]
	  source $path
		parse_task 	 
		
	}
	updateTitle $filename
}


$m add command -label "Save parameters" -command {
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
	
	if {[string compare $filename ""] != 0} {		
  	 set targetfilename ""
  	 set Flag_simulate 0
	  set Flag_fit 0
  	 set Flag_save_simu 1
		set f [open $filename w]
		set line [$t get 0.0 end]
		puts $f $line
		close $f
		updateTitle $filename
		
		$t delete 0.0 end
		set f1 [open $filename r]
		set i 1
		while {[gets $f1 line] >= 0} {
			$t insert end $line 
			$t insert end "\n"
			set content($i) $line 
			incr i
		}
		close $f1 
		set path [file join $INTER_SYS_DIR inttcl/inter_parse_task.tcl]
	  source $path
		parse_task 
		
	} else {
	updateTitle $filename
	     tk_messageBox -message "please open parameters first !" -type ok
		               return
		      }
	
}
$m add command -label "Save as parameters" -command {
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
   
if {[string compare $filename ""] != 0} {
		   set Flag_simulate 0
   set Flag_fit 0
		
		set temp_filename [tk_getSaveFile -defaultextension .dat -filetypes $file_types ]
		if {[string compare $temp_filename ""] != 0} {	
			set Flag_save_simu 1
		set f [open $temp_filename w]
		set line [$t get 0.0 end]
		puts $f $line
		close $f
		set filename $temp_filename
		updateTitle $filename
		
	  $t delete 0.0 end
		set f1 [open $filename r]
		set i 1
		while {[gets $f1 line] >= 0} {
			$t insert end $line 
			$t insert end "\n"
			set content($i) $line 
			incr i
		}
		close $f1 
		set path [file join $INTER_SYS_DIR inttcl/inter_parse_task.tcl]
	  source $path
		parse_task 
		
	  }
	} else {
	updateTitle $filename
     tk_messageBox -message "please open parameters first !" -type ok
		               return
		      }	  
}
$m add separator

$m add command -label "Load para&target" -command {
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
	
	set Flag_save_fit 0
	set Flag_option 0
	set Flag_test 0
	set Flag_target 1
	incr k_target       
  	set filename ""
   
  set temp_path [file join $INTER_SYS_DIR parafiles]
	cd $temp_path
	set temptargetfilename [tk_getOpenFile -filetypes $file_types]
	cd $INTER_SYS_DIR	
   
  if {$k_target == 1} {
	    set targetfilename $temptargetfilename
	} else {
	    if { [string compare $temptargetfilename ""] == 0} {
	         set targetfilename $targetfilename
	         set Flag_simulate $Flag_simulate
	         set Flag_fit $Flag_fit
	       } else {
	         set targetfilename $temptargetfilename
	         set Flag_simulate 0
	         set Flag_fit 0
	         }
	   }
			    
  if {[string compare $targetfilename ""] !=0} {
      set i 1
      $t delete 0.0 end
      $t configure -width 105
      set f [open $targetfilename r]
      while {[gets $f line] >=0} {
          $t insert end $line
          $t insert end "\n"
          set content($i) $line
          incr i
      }
      close $f
      
	   set temp_path [file join $INTER_SYS_DIR targetfiles]
	   cd $temp_path
	   set temptarget_targetfilename [tk_getOpenFile -filetypes $targetfile_types]
	   cd $INTER_SYS_DIR
	   
	   if {[string compare $temptarget_targetfilename ""] !=0} {
		   	
		   	updateTitle $targetfilename   
		    
		    $ttar delete 0.0 end
		    set f [open $temptarget_targetfilename r]
		    while {[gets $f line] >= 0} {		       
			     $ttar insert end $line 
			     $ttar insert end "\n"
			     set content($i) $line 
			     incr i
		    }
		    close $f		   
		    
		    set path [file join $INTER_SYS_DIR inttcl/inter_parse_fit_task.tcl]
	      source $path
		    parse_fit_task 
		    } else {
		    set targetfilename ""
		    }
	}


}

$m add separator

$m add command -label "Exit" -command {destroy $mw}

set para $mw.menu.para
menu $para -tearoff 0

$mw.menu add cascade -label "Parameter" -menu $para -underline 0
$para add command -label "Plant age" -command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
	            set path [file join $INTER_SYS_DIR inttcl/inter_gene_parameter.tcl]
              source $path
              set_gene_parameter
              } else {
              tk_messageBox -message "please open parameters or para&target first !" -type ok
		          return 
		          }              
}
$para add cascade -label "Physiological age 1" -menu $para.pa1
set subpa1 [menu $para.pa1 -tearoff 0]
$subpa1 add command -label "topological parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_topo_1.tcl]
              source $path
              topo_1
		          } else {
		          tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa1 add command -label "geometrical parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geo_1.tcl]
              source $path
              geo_1
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa1 add command -label "functional parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
                if { $Flag_test == 1} {
		              set path [file join $INTER_SYS_DIR inttcl/inter_func_1.tcl]
                  source $path
                  func_1
                }
                if { $Flag_target == 1} {
                  set path [file join $INTER_SYS_DIR inttcl/inter_func_fit_1.tcl]
                  source $path
                  func_fit_1
                }
              } else {
		                tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa1 add command -label "allometry parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          
		              set path [file join $INTER_SYS_DIR inttcl/inter_allo_1.tcl]
                  source $path
                  allo_1
                
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa1 add command -label "output parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_outp_1.tcl]
              source $path
              outp_1
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}

$para add cascade -label "Physiological age 2" -menu $para.pa2
set subpa2 [menu $para.pa2 -tearoff 0]
$subpa2 add command -label "topological parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_topo_2.tcl]
              source $path
              topo_2
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa2 add command -label "geometrical parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geo_2.tcl]
              source $path
              geo_2
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa2 add command -label "functional parameter" \
-command {
              if { [ string compare $filename ""]  != 0 || [ string compare $targetfilename ""] != 0 } {
		          if { $Flag_test == 1} {
		              set path [file join $INTER_SYS_DIR inttcl/inter_func_2.tcl]
                  source $path
                  func_2
                }
                if { $Flag_target == 1} {
                  set path [file join $INTER_SYS_DIR inttcl/inter_func_fit_2.tcl]
                  source $path
                  func_fit_2
                }

              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa2 add command -label "allometry parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          
		              set path [file join $INTER_SYS_DIR inttcl/inter_allo_2.tcl]
                  source $path
                  allo_2
                
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa2 add command -label "output parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_outp_2.tcl]
              source $path
              outp_2
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}

$para add cascade -label "Physiological age 3" -menu $para.pa3
set subpa3 [menu $para.pa3 -tearoff 0]
$subpa3 add command -label "topological parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_topo_3.tcl]
              source $path
              topo_3
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa3 add command -label "geometrical parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geo_3.tcl]
              source $path
              geo_3
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa3 add command -label "functional parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          if { $Flag_test == 1} {
		              set path [file join $INTER_SYS_DIR inttcl/inter_func_3.tcl]
                  source $path
                  func_3
                }
                if { $Flag_target == 1} {
                  set path [file join $INTER_SYS_DIR inttcl/inter_func_fit_3.tcl]
                  source $path
                  func_fit_3
                }
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa3 add command -label "allometry parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          
		              set path [file join $INTER_SYS_DIR inttcl/inter_allo_3.tcl]
                  source $path
                  allo_3
                
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa3 add command -label "output parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_outp_3.tcl]
              source $path
              outp_3
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}

$para add cascade -label "Physiological age 4" -menu $para.pa4
set subpa4 [menu $para.pa4 -tearoff 0]
$subpa4 add command -label "topological parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_topo_4.tcl]
              source $path
              topo_4
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa4 add command -label "geometrical parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geo_4.tcl]
              source $path
              geo_4
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa4 add command -label "functional parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          if { $Flag_test == 1} {
		              set path [file join $INTER_SYS_DIR inttcl/inter_func_4.tcl]
                  source $path
                  func_4
                }
                if { $Flag_target == 1} {
                  set path [file join $INTER_SYS_DIR inttcl/inter_func_fit_4.tcl]
                  source $path
                  func_fit_4
                }
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa4 add command -label "allometry parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          
		              set path [file join $INTER_SYS_DIR inttcl/inter_allo_4.tcl]
                  source $path
                  allo_4
                
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa4 add command -label "output parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_outp_4.tcl]
              source $path
              outp_4
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}

$para add cascade -label "Physiological age 5" -menu $para.pa5
set subpa5 [menu $para.pa5 -tearoff 0]
$subpa5 add command -label "topological parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		              set path [file join $INTER_SYS_DIR inttcl/inter_topo_5.tcl]
                  source $path
                  topo_5
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa5 add command -label "geometrical parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geo_5.tcl]
              source $path
              geo_5
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa5 add command -label "functional parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          if { $Flag_test == 1} {
		              set path [file join $INTER_SYS_DIR inttcl/inter_func_5.tcl]
                  source $path
                  func_5
                }
                if { $Flag_target == 1} {
                  set path [file join $INTER_SYS_DIR inttcl/inter_func_fit_5.tcl]
                  source $path
                  func_fit_5
                }
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa5 add command -label "allometry parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		         
		              set path [file join $INTER_SYS_DIR inttcl/inter_allo_5.tcl]
                  source $path
                  allo_5
               
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}
$subpa5 add command -label "output parameter" \
-command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_outp_5.tcl]
              source $path
              outp_5
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}


################ Topological Paremeter Stochastic #############3
#$para add command -label "Topological Parameter stochastic" \
# -command {
#              if { [ string compare $filename ""] == 0 } {
#		               tk_messageBox -message "please open parameters or para&target first !" -type ok
#		               return 
#	                }              
#              source inter_top_paramstoch.tcl
#              set_top_paramstoch
#}

$para add cascade -label "Global Geometrical Parameter" -menu $para.subpara 
set sub [menu $para.subpara -tearoff 0]
$sub add command -label "shape" -command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geom_shapepara_new.tcl]
	            source $path
              set_shapepara_new
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                } 	            
	            
}
$sub add command -label "color" -command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_geom_colorpara_new.tcl]
              source $path
              set_geom_colorpara_new
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }              
              
}

$para add command -label "Global Output Parameter" -command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_global_outp.tcl]
              source $path
              global_outp
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }
              
}

$para add command -label "Enviromental Parameter" -command {
              if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0 } {
		          set path [file join $INTER_SYS_DIR inttcl/inter_env_parameter.tcl]
              source $path
              set_env_parametre
              } else {
		               tk_messageBox -message "please open parameters or para&target first !" -type ok
		               return 
	                }
              
}

set simu $mw.menu.simu
menu $simu -tearoff 0

$mw.menu add cascade -label "Simulate" -menu $simu -underline 0  
$simu add command -label "Begin" -command {
	            if {$filename != "" || $targetfilename !=""} {
#	                form_task 
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
 
    ScilabEval "Flag_C_code = $Flag_C_code;";
	  ScilabEval "Flag_Sci_code =$Flag_Sci_code;";
          
	             global INTER_SYS_DIR
if {$filename !=""} {
  if {$Flag_save_simu == 0} {
    set temp_test_testfile [file join $INTER_SYS_DIR parafiles/tempfile.sci]
    set f [open $temp_test_testfile w]
    set line [$t get 0.0 end]
    puts $f $line
    close $f
    set simufilename $temp_test_testfile
    } else {
    set simufilename $filename
    }
        
    ScilabEval "realFile = '$filename';";
    ScilabEval "FName = '$simufilename';";
    updateTitle $filename
}
if {$targetfilename !=""} {
  if {$Flag_save_fit == 0} {
    set temp_test_targetfile [file join $INTER_SYS_DIR targetfiles/targettempfile.sci]
    set f [open $temp_test_targetfile w]
    set line [$t get 0.0 end]
    puts $f $line
    close $f
    set fitfilename $temp_test_targetfile
    } else {
    set fitfilename $targetfilename
    }
    
    ScilabEval "realFile = '$targetfilename';";
    ScilabEval "FName = '$fitfilename';";
    updateTitle $targetfilename
}

    
		     set Flag_simulate 1            
    
	            ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
	            ScilabEval "Flag_TCL=0;";
	            #ScilabEval "FName = '$simufilename';";	
	            #ScilabEval "realFile = '$filename';";
	            ScilabEval "exec(INTER_SYS_DIR+'/Gl_simulate.sci');";			     
	                } else {
		              tk_messageBox -message "please open parameters or para&target first !" -type ok
	                }
}

$simu add command -label "Stop" -command {	 	 
	            ScilabEval "abort";	            		 
}

set fit $mw.menu.fit
menu $fit -tearoff 0
$mw.menu add cascade -label "Fit" -menu $fit -underline 2
$fit add command -label "Begin" -command {
catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo   

          global INTER_SYS_DIR
    set temp_para_targetfile [file join $INTER_SYS_DIR targetfiles/targetpara_tempfile.sci]
    set f [open $temp_para_targetfile w]
    set line [$t get 0.0 end]
    puts $f $line
    close $f
    set fitparafilename $temp_para_targetfile
    
    set temp_data_targetfile [file join $INTER_SYS_DIR targetfiles/targetdata_tempfile.dat]
    set f [open $temp_data_targetfile w]
    set line [$ttar get 0.0 end]
    puts $f $line
    close $f
    set fitdatafilename $temp_data_targetfile
          
          
if {$targetfilename != ""} {
      
          ScilabEval "Flag_C_code = $Flag_C_code;";
	        ScilabEval "Flag_Sci_code =$Flag_Sci_code;";
	        
          set Flag_fit 1
          
	            ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
	            ScilabEval "ParaFileName ='$fitparafilename';";
	            ScilabEval "DataFileName ='$fitdatafilename';";
	            ScilabEval "realFile = '$targetfilename';";
	            ScilabEval "Flag_TCL=0;";
	            ScilabEval "exec(INTER_SYS_DIR+'/Gl_fit_Para.sci');";	            
	                } else {
		              tk_messageBox -message "please open para&target first !" -type ok
	                }

}
$fit add command -label "Stop" -command {	 	 
	            ScilabEval "abort";	            		 
}

set oput $mw.menu.oput
menu $oput -tearoff 0
$mw.menu add cascade -label "Output" -menu $oput -underline 1
$oput add command -label "Number of organ" -command {
              
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0 } {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                } 

	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0} {
	                if { $Flag_simulate ==0} {
	                
	                catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
	                
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	             global INTER_SYS_DIR
		     ScilabEval "Flag_TCL = 0;";
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
		     ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_disp_topo.sci');";
		     
#		     set path_text_topo [file join $INTER_SYS_DIR inttcl/text_topo.tcl]
#		     source $path_text_topo
#		     after 300 [list text_topo]

}
$oput add command -label "Demand & Biomass" -command {
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0 } {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                } 
	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] != 0} {
	                if { $Flag_simulate ==0} {
	                
	                catch {destroy $c}
destroy $mw.f1
destroy $mw.xscroll
destroy $mw.f1.yscroll
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo
	                
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	             
		     global INTER_SYS_DIR
		     ScilabEval "Flag_TCL = 0;";
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
		     ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_disp_result.sci');";
		     
#		     set path_text_result [file join $INTER_SYS_DIR inttcl/text_result.tcl]
#		     source $path_text_result
#		     after 300 [list text_result]

        
}
$oput add command -label "Figure" -command {
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0} {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                }
	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] !=0} {
	                if { $Flag_simulate ==0} {
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	             global INTER_SYS_DIR
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
		    ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_disp_curve.sci');";	
	             	                
}
$oput add command -label "Skeleton" -command {
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0 } {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                } 
	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] !=0} {
	                if { $Flag_simulate ==0} {
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	            global inter_Flag_geo_skeleton
	            set skeleton [lsearch $inter_Flag_geo_skeleton 1]
	           
	            if {$skeleton == -1} {
	                    tk_messageBox -message "please select skeleton option in Parameter menu !" -type ok
		                  return 
		          }
	             
			   global INTER_SYS_DIR
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
		     ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_skeleton.sci');";
	             	                
}
$oput add command -label "3D" -command {
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0 } {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                } 
	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] !=0} {
	                if { $Flag_simulate ==0} {
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	                 
	            global inter_Flag_geo_3D
	            set 3D [lsearch $inter_Flag_geo_3D 1]
	           
	            if {$3D == -1} {
	                    tk_messageBox -message "please select Draw_3D option in Parameter menu !" -type ok
		                  return 
		          }
	             
			 global INTER_SYS_DIR
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
		     ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_3D.sci');";
	             	                
}
$oput add command -label "Export 3D file" -command {
              if { [ string compare $filename ""] == 0 && [ string compare $targetfilename ""] == 0 } {
		               tk_messageBox -message "please open parameters or paratarget first !" -type ok
		               return 
	                } 
	            if { [ string compare $filename ""] != 0 || [ string compare $targetfilename ""] !=0} {
	                if { $Flag_simulate ==0} {
	                    tk_messageBox -message "please simulate first !" -type ok
		                  return 
	                   } 
	                 }
	                 
	           global inter_Flag_geo_lig
	           
	            if {$inter_Flag_geo_lig == 0} {
	                    tk_messageBox -message "please select Export_file option in Parameter menu !" -type ok
		                  return 
		          }
	             
			 global INTER_SYS_DIR
		     ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';"
		     ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_exportlig.sci');";
	             	                
}
$oput add separator
$oput add command -label "Environment factors" -command {
    if {$Flag_simulate == 1} {
      ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
      ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_disp_environment.sci');";
    } else {
    tk_messageBox -message "please simulate first !" -type ok
		                  return 
		}
}

$oput add separator

$oput add command -label "Plant data for fitting" -command {
    if {$Flag_simulate == 1} {
      ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
      ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_output_target.sci');";
    } else {
    tk_messageBox -message "please simulate first !" -type ok
		                  return 
		}
}
$oput add separator
$oput add command -label "Close all windows" -command {
               ScilabEval "xdel(winsid());";
               }

set option $mw.menu.option
menu $option -tearoff 0
$mw.menu add cascade -label "Option" -menu $option -underline 0
$option add command -label "Code select" -command {
if {$filename !="" || $targetfilename != ""} { 
  set path [file join $INTER_SYS_DIR inttcl/inter_option.tcl]
	source $path
  option
} else {
	tk_messageBox -message "please open parameters or paratarget first !" -type ok
	}
}

set view $mw.menu.view
menu $view -tearoff 0
$mw.menu add cascade -label "View3D" -menu $view -underline 0
#$view add command -label "Plant in Scilab" -command {
#ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
#ScilabEval "exec(INTER_SYS_DIR+'/bin/Draw_read_lig.sci');";
#}
$view add command -label "Plant in tree_visu.exe" -command {
if {$tcl_platform(platform) == "unix"} {
  tk_messageBox -message "it can be executed only in Windows" -type ok
}
if {$tcl_platform(platform) == "windows"} {
  ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
  ScilabEval "winopen(INTER_SYS_DIR+'/lig/tree_visu.exe');";
}
}
$view add command -label "Organ shape" -command {
ScilabEval "INTER_SYS_DIR = '$INTER_SYS_DIR';";
ScilabEval "exec(INTER_SYS_DIR+'/bin/gl_draw_organ.sci');";
}

set m $mw.menu.help
menu $m -tearoff 0
$mw.menu add cascade -label "About" -menu $m -underline 0
#$m add command -label "help" -command {
#          set path [file join $INTER_SYS_DIR inttcl/inter_help.tcl]
#          source $path
#          inter_help
#}
$m add command -label "GreenScilab..." -command {
          set path [file join $INTER_SYS_DIR inttcl/inter_about.tcl]
          source $path
          about
}
$m add command -label "Tree_visu.exe..." -command {
          set path [file join $INTER_SYS_DIR inttcl/inter_about_treevisu.tcl]
          source $path
          treevisu
}


$mw configure -menu $mw.menu

bind Menu <<MenuSelect>> {
    global $statusbar
    if {[catch {%W entrycget active -label} label]} {
	set label "    "
    }
    set statusbar $label
    update idletasks
}

###############################################################################

proc updateTitle {task_file} {
	global mw
	set task [file tail $task_file]
	wm title $mw "GreenScilab---$task"
}

proc updateTask {} {
	global mw
	global content	
	set tup $mw.t
	global Flag_test
	global Flag_target
	
	
	  if {$Flag_test == 1} {
	    $tup delete 0.0 end
	    for {set i 1 } { $i <= [array size content]} {incr i} {
			set line $content($i)  
			$tup insert end $line 
			$tup insert end "\n"
	        } 
	  } 
	  if {$Flag_target ==1} {
	    set backt $mw.backt
      $backt delete 0.0 end
      for {set i 1 } { $i <=[array size content]} {incr i} {
			set line $content($i)  
			$backt insert end $line 
			$backt insert end "\n"
	        } 
	    $tup delete 0.0 end
	    $tup insert end [$backt get 0.0 end]
	    
	    form_fit_task
	    
	    $backt delete 0.0 end
	    for {set i 1 } { $i <=[array size content]} {incr i} {
			set line $content($i)  
			$backt insert end $line 
			$backt insert end "\n"
			}
			$mw.ttar delete 0.0 32.27
	    $mw.ttar insert 0.0 [$backt get 0.0 end]
	    
	 }
	    
}

##### Creat a canvas on which the content of test/target/demos file is shown 
set c $mw.can
canvas $c -width 500 -height 500 -highlightthickness 0 -borderwidth 0 -background white
pack $mw.can -expand 1 -fill both

set pic [file join $INTER_SYS_DIR inttcl/GreenScilab_white_1.gif]
image create photo logo -file $pic
$c create image 315 270 -image logo



