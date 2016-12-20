###                inter_parse_task.tcl
###                read the file
###                parse a line and fill content to 9 word
proc parse {aline} {
	scan $aline "%s %s %s %s %s %s %s %s %s" fc(1) fc(2) fc(3) fc(4) fc(5) fc(6) \
	                                         fc(7) fc(8) fc(9)
	for {set j  1 } { $j <= [array size fc] } {incr j } {
		lappend b $fc($j)
	}
    unset fc
	set c $b
}

############ parse content of a task and set configuration
proc parse_task {} {
########################### General Param ##########
global subpa1
global subpa2
global subpa3
global subpa4
global subpa5
global inter_N
global inter_maxp
########################### Topological Param ############
global inter_Nu_Ma
global inter_st_j
global inter_b_o
global inter_br_a
global inter_re_a
global inter_rs_A
global inter_rs_B
global inter_rt_a
#########inter_T_F--Time_Function   inter_T_a--Time_appearence
#########inter_T_d--Time_disappearence inter_T_b--Time_busy
#########inter_T_i--Time_idle
global inter_T_F1
global inter_T_F2
global inter_T_F3
global inter_T_F4
global inter_T_F5
global inter_T_F6
global inter_T_a1
global inter_T_a2
global inter_T_a3
global inter_T_a4
global inter_T_a5
global inter_T_a6
global inter_T_d1
global inter_T_d2
global inter_T_d3
global inter_T_d4
global inter_T_d5
global inter_T_d6
global inter_T_b1
global inter_T_b2
global inter_T_b3
global inter_T_b4
global inter_T_b5
global inter_T_b6
global inter_T_i1
global inter_T_i2
global inter_T_i3
global inter_T_i4
global inter_T_i5
global inter_T_i6
############################ variables below are matrix
global inter_Nu_I
global inter_Nu_I1
global inter_Nu_I2
global inter_Nu_I3
global inter_Nu_I4
global inter_Nu_I5
global inter_Nu_I6
global inter_Nu_A
global inter_Nu_A1
global inter_Nu_A2
global inter_Nu_A3
global inter_Nu_A4
global inter_Nu_A5
global inter_Nu_A6
global inter_Nu_B
global inter_Nu_B1
global inter_Nu_B2
global inter_Nu_B3
global inter_Nu_B4
global inter_Nu_B5
global inter_Nu_B6
global inter_Nu_Ff
global inter_Nu_Ff1
global inter_Nu_Ff2
global inter_Nu_Ff3
global inter_Nu_Ff4
global inter_Nu_Ff5
global inter_Nu_Ff6
global inter_Nu_Fm
global inter_Nu_Fm1
global inter_Nu_Fm2
global inter_Nu_Fm3
global inter_Nu_Fm4
global inter_Nu_Fm5
global inter_Nu_Fm6
###########################  Func Param ##############
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
global inter_Flag_field
global inter_Sp
global inter_r_B
global inter_r_P
global inter_r_R
global inter_rp
global inter_kp
global inter_Q0
global inter_dQ0
global inter_RingOption
global inter_coff_L
global inter_N_SI
global inter_kp_SI
###########################  Allometry Param  ###########
global inter_a_bI
global inter_a_aI
global inter_a_bP
global inter_a_aP
global inter_a_aB
global inter_a_bB
global inter_Th_B
global inter_Den_Ff
global inter_Den_Fm
global inter_Den_I
##########################  Geometrical Param ###########
global inter_Smb_L
global inter_Smb_Ff
global inter_Smb_Fm
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
global inter_Ang_Ph
global inter_Ey
global inter_fp
global inter_Eng_Ang
global inter_Eng_N
global inter_InitMin
global inter_InitMax
global inter_InitNum
global inter_wb
global inter_wbn
global inter_Flag_Plagiotropic
global inter_Flag
global inter_VI
global inter_VB
global inter_VF
global inter_CI
global inter_CB
global inter_CF
global inter_Flag_Bending_by_node
global inter_Flag_Organ_bending
global inter_Theta_B
global inter_Theta_L
global inter_Theta_F
global inter_Ang_Fm
global inter_Ang_Fm1
global inter_Ang_Fm2
global inter_Ang_Fm3
global inter_Ang_Fm4
global inter_Ang_Fm5
global inter_Ang_Fm6
global inter_Ang_Ff
global inter_Ang_Ff1
global inter_Ang_Ff2
global inter_Ang_Ff3
global inter_Ang_Ff4
global inter_Ang_Ff5
global inter_Ang_Ff6
global inter_Ang_B
global inter_Ang_B1
global inter_Ang_B2
global inter_Ang_B3
global inter_Ang_B4
global inter_Ang_B5
global inter_Ang_B6
global inter_Ang_A
global inter_Ang_A1
global inter_Ang_A2
global inter_Ang_A3
global inter_Ang_A4
global inter_Ang_A5
global inter_Ang_A6
###################################  unusable variables
global inter_Tr
global inter_a
global inter_b
global inter_bu
global inter_c
global inter_Flag_pruning
global inter_Pruning_delay
global inter_Flag_leaf
global inter_Flag_fruit

###################################  environment para 
global inter_Flag_climate
global inter_K1
global inter_K2
global inter_C1
global inter_C2
global inter_QSW0
global inter_QSWMAX
global inter_QSWMIN
global inter_QSW_MAX
global inter_QSW_MIN
global inter_Flag_temperature
global inter_Flag_sumt
global inter_E_ALPHA
global inter_E_BETA
global inter_KSUMT
global inter_THETA_BASE
global inter_THETAMAX
global inter_THETAMIN
global inter_THETA_MAX
global inter_THETA_MIN
global inter_Flag_light
global inter_E_A
global inter_E_B
global inter_LIGHTMAX
global inter_LIGHTMIN
global inter_LIGHT_MAX
global inter_LIGHT_MIN
global inter_E0
####################################  output option para
global inter_Flag_topo_disp
global inter_Flag_topo_disp_s
global inter_Flag_topo_disp_l
global inter_Flag_topo_disp_a
global inter_Flag_hydro
global inter_Flag_layer_disp
global inter_Flag_demand_biomass
global inter_Flag_biomass_num
global inter_Flag_biomass_fig
global inter_Flag_bioprod_fig
global inter_Flag_biomass_fig_a
global inter_Flag_disp_LAI
global inter_Flag_biomass_fig_phy
global inter_Flag_size_fig_phy
global inter_Flag_geometry
global inter_Flag_geo_full
global inter_Flag_geo_3D
global inter_Flag_geo_leaf
global inter_Flag_geo_fruit
global inter_Flag_geo_light
global inter_Flag_geo_skeleton
global inter_Flag_geo_lig
global inter_Flag_windows


####### content of the test file
global content

set i 1
while { [expr $i <= [array size content]] } {
        set tline [string trim $content($i)]
        while { [expr [string length $tline] == 0] }  {
    	          incr i 
		            if { [expr $i > [array size content]] } break
    	           set tline $content($i)
               }
	       if { [expr $i > [array size content]] } break
         set cc [parse $tline ] 
         for {set j 0 } { $j < [llength $cc] } {incr j } {
		           set c([expr $j+1]) [lindex $cc $j]
	            }
########################## c is a array ;  cc is a list  ###############
     		
	   switch [string trim $c(1)] {
    "Chr_Age(N)" {
    	             set inter_N $c(2)
    	             }
    "Phy_Age(Maxp)" {
    	             set inter_maxp $c(2)
    	             }
    "Sample_Size(Tr)" {
    	             set inter_Tr [lrange $cc 1 6]
    	             }    	        
    "branching_proba(a)" {
    	             set inter_a [lrange $cc 1 7]
    	             }    	           	             
    "Growth_macro(b)" {
    	             set inter_b [lrange $cc 1 7]
    	             }    	           	             
    "Growth_micro(bu)" {
    	             set inter_bu [lrange $cc 1 7]
    	             }    	       
    "Survive(c)" {
    	             set inter_c [lrange $cc 1 7]
    	             }    	           	             
    "Pruning(Flag_pruning)" {
    	             set inter_Flag_pruning [lrange $cc 1 6]
    	             }    	           	             
    "Delay(Pruning_delay)" {
    	             set inter_Pruning_delay [lrange $cc 1 6]
    	             }    	           	             
    "Leaf_display(Flag_leaf)" {
    	             set inter_Flag_leaf [lrange $cc 1 6]
    	             }    	       
    "Fruit_display(Flag_fruit)" {
    	             set inter_Flag_fruit [lrange $cc 1 6]
    	             }    	               	               	             
    "Axillary_Num(Nu_A)" {
    	             set j 1
    	             set k 1
    	             set inter_Nu_A1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Nu_A$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Nu_A [concat $inter_Nu_A1 $inter_Nu_A2 \
    	                 $inter_Nu_A3 $inter_Nu_A4 $inter_Nu_A5 $inter_Nu_A6]
    	             }  
    "Leaf_Num(Nu_B)" {
    	             set j 1
    	             set k 1
    	             set inter_Nu_B1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Nu_B$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Nu_B [concat $inter_Nu_B1 $inter_Nu_B2 \
    	                 $inter_Nu_B3 $inter_Nu_B4 $inter_Nu_B5 $inter_Nu_B6]
    	             }  
    "Female_Num(Nu_Ff)" {
    	             set j 1
    	             set k 1
    	             set inter_Nu_Ff1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Nu_Ff$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Nu_Ff [concat $inter_Nu_Ff1 $inter_Nu_Ff2 \
    	                 $inter_Nu_Ff3 $inter_Nu_Ff4 $inter_Nu_Ff5 $inter_Nu_Ff6]
    	             }      	             
    "Male_Num(Nu_Fm)" {
    	             set j 1
    	             set k 1
    	             set inter_Nu_Fm1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Nu_Fm$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Nu_Fm [concat $inter_Nu_Fm1 $inter_Nu_Fm2 \
    	                 $inter_Nu_Fm3 $inter_Nu_Fm4 $inter_Nu_Fm5 $inter_Nu_Fm6]
    	             }      	                 	             
    "Micro_Num(Nu_I)" {
    	             set j 1
    	             set k 1
    	             set inter_Nu_I1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Nu_I$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Nu_I [concat $inter_Nu_I1 $inter_Nu_I2 \
    	                 $inter_Nu_I3 $inter_Nu_I4 $inter_Nu_I5 $inter_Nu_I6]
    	             }      	                 	    	             
    	             
    "Macro_Num(Nu_Ma)" {
                  set inter_Nu_Ma [lrange $cc 1 6] 
                   }
    "Struc_Jump(st_j)" {
                  set inter_st_j [lrange $cc 1 6]
                   }
    "Reiter_Order(b_o)" {
                  set inter_b_o [lrange $cc 1 6]
                   }                   
    "Bran_Control(br_a)" {
                  set inter_br_a [lrange $cc 1 6]
                   }                   
    "Reiter_Control(re_a)" {
                  set inter_re_a [lrange $cc 1 6]
                   }                   
    "Rest_Func(rs_A)" {
                  set inter_rs_A [lrange $cc 1 6]
                   }                   
    "Rest_Func(rs_B)" {
                  set inter_rs_B [lrange $cc 1 6]
                   }                    
    "rythm_Ratio(rt_a)" {
                  set inter_rt_a [lrange $cc 1 6]
                   }                    
    "Time_Expansion(t_exp)" {
                  set inter_t_exp [lrange $cc 1 7]
                   }    
    "Para_a(Bt_a)" {
                  set inter_Bt_a [lrange $cc 1 7]
                   }                       
    "Para_b(Bt_b)" {
                  set inter_Bt_b [lrange $cc 1 7]
                   }                       
    "Sink_Blade(S_B)" {
                  set inter_S_B [lrange $cc 1 6]
                   }                       
    "Sink_Petiole(S_P)" {
                  set inter_S_P [lrange $cc 1 6]
                   }          
    "Sink_Internode(S_I)" {
                  set inter_S_I [lrange $cc 1 6]
                   }                             
    "Sink_Female(S_Ff)" {
                  set inter_S_Ff [lrange $cc 1 6]
                   }                             
    "Sink_Male(S_Fm)" {
                  set inter_S_Fm [lrange $cc 1 6]
                   }                             
    "Sink_Layer(S_L)" {
                  set inter_S_L [lrange $cc 1 6]
                   }                         
    "Sink_Root(S_R)" {
                  set inter_S_R [lrange $cc 1 6]
                   }                         
    "Allom_Internode(a_bI)" {
                  set inter_a_bI [lrange $cc 1 6]
                  }
    "(a_aI)" {
                  set inter_a_aI [lrange $cc 1 6]
                   }                              
    "Allom_Petiole(a_bP)" {
                  set inter_a_bP [lrange $cc 1 6]
                   }                               
    "(a_aP)" {
                  set inter_a_aP [lrange $cc 1 6]
                   }                               
    "Allom_Thick(Th_B)" {
                  set inter_Th_B [lrange $cc 1 6]
                   }  
    "Female_Density(Den_Ff)" {
                  set inter_Den_Ff [lrange $cc 1 6]
                   }                     
    "Male_Density(Den_Fm)" {
                  set inter_Den_Fm [lrange $cc 1 6]
                   }                     
    "Internode_Dens(Den_I)" {
                  set inter_Den_I [lrange $cc 1 6]
                   } 
    "Flag_field" {
                  set inter_Flag_field $c(2)
                   }           
    "Resist_Blade(r_B)" {
                  set inter_r_B $c(2)
                   }                        
    "Resist_Petiole(r_P)" {
                  set inter_r_P $c(2)
                   }                        
    "Resist_Root(r_R)" {
                  set inter_r_R $c(2)
                   }
    "Projected_area(Sp)" {
                  set inter_Sp $c(2)
                   }                            
    "Beer_law(rp)" {
                  set inter_rp $c(2)
                   }                        
    "Beer_law(kp)" {
                  set inter_kp $c(2)
                   }                                       
    "Seed_Biomass(Q0)" {
                  set inter_Q0 $c(2)
                   }  
    "Flow_Biomass(dQ0)" {
                  set inter_dQ0 $c(2)
                   }                                     
    "Flag_RingOption" {
                  set inter_RingOption $c(2)
                   }   
    "Coefficient_for_layer" {
                  set inter_coff_L $c(2)
                   }                      
    "ShortInter_Number(N_SI)" {
                  set inter_N_SI $c(2)
                  }
    "ShortInter_RelaSink(kp_SI)" {
                  set inter_kp_SI $c(2)
                  }
    "Leaf_shape(smb_L)" {
                  set inter_Smb_L $c(2)
                   }                                      
    "Female_shape(smb_Ff)" {
                  set inter_Smb_Ff $c(2)
                   }                                      
    "Male_shape(smb_Fm)" {
                  set inter_Smb_Fm $c(2)
                   }                                      
    "Leaf_color(Color_B)" {
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_B_alive [lrange $fcc 0 end]
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_B_dead [lrange $fcc 0 end]
                   }                     
    "Internode_color(Color_I)" {
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_I_alive [lrange $fcc 0 end]
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_I_dead [lrange $fcc 0 end]
                   }                                        
    "Female_color(Color_Ff)" {
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_Ff_alive [lrange $fcc 0 end]
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_Ff_dead [lrange $fcc 0 end]
                   }                                          
    "Male_color(Color_Fm)" {
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_Fm_alive [lrange $fcc 0 end]
                  incr i
                  set tline [string trim $content($i)]
                  set fcc [parse $tline]
                  set inter_Color_Fm_dead [lrange $fcc 0 end]
                   }                                   
    "Phy_Color(Color_P)" {
                  set j 1
                  while {$j<=6} {
                        incr i
                        set tline [string trim $content($i)]
                        set fcc [parse $tline]
                        set inter_Color_Phy$j [lrange $fcc 0 end]
                        incr j
                        }
                   }                        
    "Angle_Male(Ang_Fm)" {
    	             set j 1
    	             set k 1
    	             set inter_Ang_Fm1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Ang_Fm$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Ang_Fm [concat $inter_Ang_Fm1 $inter_Ang_Fm2 \
                     $inter_Ang_Fm3 $inter_Ang_Fm4 $inter_Ang_Fm5 $inter_Ang_Fm6]
    	             }      	               
    "Angle_Female(Ang_Ff)" {
    	             set j 1
    	             set k 1
    	             set inter_Ang_Ff1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Ang_Ff$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Ang_Ff [concat $inter_Ang_Ff1 $inter_Ang_Ff2 \
    	                 $inter_Ang_Ff3 $inter_Ang_Ff4 $inter_Ang_Ff5 $inter_Ang_Ff6]
    	             }      	         
    "Angle_Blade(Ang_B)" {
    	             set j 1
    	             set k 1
    	             set inter_Ang_B1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Ang_B$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Ang_B [concat $inter_Ang_B1 $inter_Ang_B2 \
    	                 $inter_Ang_B3 $inter_Ang_B4 $inter_Ang_B5 $inter_Ang_B6]
    	             }      	             	             
    "Angle_Axillary(Ang_A)" {
    	             set j 1
    	             set k 1
    	             set inter_Ang_A1 [lrange $cc 1 6]
    	             while {$j<=5} {
    	                   incr i
    	                   incr j
    	                   set tline   [string trim $content($i)]
    	                   set fcc [parse $tline]
    	                   set inter_Ang_A$j [lrange $fcc 0 [expr 5-$k]]
    	                   incr k
    	                   }
    	             set inter_Ang_A [concat $inter_Ang_A1 $inter_Ang_A2 \
    	                 $inter_Ang_A3 $inter_Ang_A4 $inter_Ang_A5 $inter_Ang_A6]
    	             }      	             	     	             
    "Angle_Phyllotaxy(Ang_Ph)" {
                  set inter_Ang_Ph [lrange $cc 1 6]
                   }                            	             
    "Young_Modulus(Ey)" {
                  set inter_Ey [lrange $cc 1 6]
                   }   
    "Force_point(fp)" {
                  set inter_fp [lrange $cc 1 6]
                   }                      
    "Terminal_Angle(Eng_Ang)" {
                  set inter_Eng_Ang [lrange $cc 1 6]
                   }       	             
    "Righting_point(Eng_N)" {
                  set inter_Eng_N [lrange $cc 1 6]
                   }       	             
    "InitialMin_angle(InitMin)" {
                  set inter_InitMin [lrange $cc 1 6]
                   }       	             
    "InitialMax_angle(InitMax)" {
                  set inter_InitMax [lrange $cc 1 6]
                   }       	             
    "InitialNum_angle(InitNum)" {
                  set inter_InitNum [lrange $cc 1 6]
                   }       	 
    "Flag_Bending_by_node" {
                  set inter_Flag_Bending_by_node [lrange $cc 1 6]
                   }       	                    
    "Max_Angle(wb)" {
                  set inter_wb [lrange $cc 1 6]
                   }       	                    
    "Openning_cycle(wbn)" {
                  set inter_wbn [lrange $cc 1 6]
                   }       	                    
    "Organ(Flag_organ_bending)" {
                  set inter_Flag_Organ_bending [lrange $cc 1 6]
                   }       	                    
    "Bending_branch(Theta_B)" {
                  set inter_Theta_B [lrange $cc 1 6]
                   }     
    "Bending_leaf(Theta_L)" {
                  set inter_Theta_L [lrange $cc 1 6]
                   }                      
    "Bending_fruit(Theta_F)" {
                  set inter_Theta_F [lrange $cc 1 6]
                   }                      
     "Flag_plagiotropic" {
                  set inter_Flag_Plagiotropic [lrange $cc 1 6]
                   }     
     "Leaf_direction(Flag)" {
                  set inter_Flag [lrange $cc 1 6]
                   }                        
     "Internode_Volume(VI)" {
                  set inter_VI [lrange $cc 1 6]
                   }  
     "Blade_Volume(VB)" {
                  set inter_VB [lrange $cc 1 6]
                   }                   
     "Fruit_Volume(VF)" {
                  set inter_VF [lrange $cc 1 6]
                   }                   
     "Internode_C(CI)" {
                  set inter_CI [lrange $cc 1 6]
                   }  
     "Blade_C(CB)" {
                  set inter_CB [lrange $cc 1 6]
                   }                     
     "Fruit_C(CF)" {
                  set inter_CF [lrange $cc 1 6]
                   } 
     "%phy_age=1" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F1 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a1  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d1  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b1  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i1  [lrange $fcc 1 end]
                }
              }
                 incr j
              }
              }
     "%phy_age=2" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F2 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a2  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d2  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b2  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i2  [lrange $fcc 1 end]
                }
              }
                 incr j
              }
              }
     "%phy_age=3" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F3 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a3  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d3  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b3  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i3  [lrange $fcc 1 end]
                }
              }
                incr j
              }
              }
     "%phy_age=4" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F4 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a4  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d4  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b4  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i4  [lrange $fcc 1 end]
                }
              }
                 incr j
              }
              }
     "%phy_age=5" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F5 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a5  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d5  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b5  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i5  [lrange $fcc 1 end]
                }
              }
                incr j
              }
              }
     "%phy_age=6" {
                  set j 1
                  while {$j<=5} {
                        incr i
                        set tline   [string trim $content($i)]
                        set fcc [parse $tline]
		                     for {set k  0 } { $k < [llength $fcc] } {incr k } {
				                      set fccc([expr $k+1]) [lindex $fcc $k]
			                        }
            switch [string trim $fccc(1)] {
            "Time_Function(Tu_O(1))" {
                 set inter_T_F6 [lrange $fcc 1 end]
                }
            "Time_appearance(2)" {
                set inter_T_a6  [lrange $fcc 1 end]
                }
            "Time_disappearance(3)" {
                set inter_T_d6  [lrange $fcc 1 end]
                }                
            "Time_busy(4)" {
                set inter_T_b6  [lrange $fcc 1 end]
                }                
            "Time_idle(5)" {
                set inter_T_i6  [lrange $fcc 1 end]
                }
              }
                incr j
              }
              } 
              
    "Flag_climate" {
                  set inter_Flag_climate $c(2)
                   } 
    "SoilWaterEffect(K1)" {
                  set inter_K1 $c(2)
                   } 
    "SoilWaterEffect(K2)" {
                  set inter_K2 $c(2)
                   }                    
    "Soil_budget_para(C1)" {
                  set inter_C1 $c(2)
                   }                    
    "Soil_budget_para(C2)" {
                  set inter_C2 $c(2)
                   }                    
    "InitialSoilWater(QSW0)" {
                  set inter_QSW0 $c(2)
                   }                    
    "MaxPlantSoilWater(QSWMAX)" {
                  set inter_QSWMAX $c(2)
                   }       
    "MinPlantSoilWater(QSWMIN)" {
                  set inter_QSWMIN $c(2)
                   }                          
    "MaxEnvFSoilWater(QSW_MAX)" {
                  set inter_QSW_MAX $c(2)
                   }                          
    "MinEnvFSoilWater(QSW_MIN)" {
                  set inter_QSW_MIN $c(2)
                   }                          
    "Flag_temperature" {
                  set inter_Flag_temperature $c(2)
                   }                          
    "SumTEffect(Flag_sumt)" {
                  set inter_Flag_sumt $c(2)
                   }                          
    "Temperature(E_ALPHA)" {
                  set inter_E_ALPHA $c(2)
                   }                                             
    "Temperature(E_BETA)" {
                  set inter_E_BETA $c(2)
                   }                                             
    "SumTEffect(KSUMT)" {
                  set inter_KSUMT $c(2)
                   }                                             
    "SumTEffect(THETA_BASE)" {
                  set inter_THETA_BASE $c(2)
                   }                                             
    "MaxPlantTemp(THETAMAX)" {
                  set inter_THETAMAX $c(2)
                   }                                             
    "MinPlantTemp(THETAMIN)" {
                  set inter_THETAMIN $c(2)
                   }                                             
    "MaxEnvFTemp(THETA_MAX)" {
                  set inter_THETA_MAX $c(2)
                   }                             
    "MinEnvFTemp(THETA_MIN)" {
                  set inter_THETA_MIN $c(2)
                   }                             
    "Flag_light" {
                  set inter_Flag_light $c(2)
                   }          
    "Light(E_A)" {
                  set inter_E_A $c(2)
                   }                         
    "Light(E_B)" {
                  set inter_E_B $c(2)
                   }                         
    "MaxEnvFLight(LIGHTMAX)" {
                  set inter_LIGHTMAX $c(2)
                   }                         
    "MinEnvFLight(LIGHTMIN)" {
                  set inter_LIGHTMIN $c(2)
                   }                         
    "MaxEnvFLight(LIGHT_MAX)" {
                  set inter_LIGHT_MAX $c(2)
                   }                    
    "MinEnvFLight(LIGHT_MIN)" {
                  set inter_LIGHT_MIN $c(2)
                   } 
    "PotentialCondition(E0)" {
                  set inter_E0 $c(2)
                   } 
    "Flag_topo_disp" {
                  set inter_Flag_topo_disp [lrange $cc 1 6]
                  }                                         
   "Flag_topo_disp_total" {
               set inter_Flag_topo_disp_s $c(2)
                  }                    
   "Flag_topo_disp_living" {
                 set inter_Flag_topo_disp_l [lrange $cc 1 6]
                  }                           
   "Flag_topo_disp_living_aboveGU" {
                 set inter_Flag_topo_disp_a [lrange $cc 1 6]
                  }        
   "Flag_hydro" {
                 set inter_Flag_hydro $c(2)
                  }                       
   "Flag_demand_biomass_layer" {
                 set inter_Flag_layer_disp $c(2)
                   }                       
    "Flag_demand_biomass_plant" {
                  set inter_Flag_demand_biomass $c(2)
                  }                       
    "Flag_biomass_repartition" {
                  set inter_Flag_biomass_num [lrange $cc 1 6]
                   }                         
    "Flag_biomass_fig" {
                  set inter_Flag_biomass_fig $c(2)
                   } 
    "Flag_biomassdemand_fig" {
                  set inter_Flag_bioprod_fig $c(2)
                   }                    
    "Flag_biomass_fig_accumulated" {
                  set inter_Flag_biomass_fig_a $c(2)
                   }                                 
    "Flag_disp_LAI" {
                  set inter_Flag_disp_LAI $c(2)
                  }
    "Flag_organ_biomass_fig_phy" {
                  set inter_Flag_biomass_fig_phy [lrange $cc 1 6]
                   }                      
    "Flag_organ_size_fig_phy" {
                  set inter_Flag_size_fig_phy [lrange $cc 1 6]
                   }                      
    "Flag_geometry" {
                  set inter_Flag_geometry $c(2)
                   }                       
    "Flag_geo_full" {
                  set inter_Flag_geo_full $c(2)
                   }  
    "Flag_geo_3D" {
                  set inter_Flag_geo_3D [lrange $cc 1 6]
                   }                    
    "Flag_geo_leaf" {
                  set inter_Flag_geo_leaf $c(2)
                   }                    
    "Flag_geo_fruit" {
                  set inter_Flag_geo_fruit $c(2)
                   }                    
    "Flag_geo_light" {
                  set inter_Flag_geo_light $c(2)
                   }                     
    "Flag_geo_skeleton" {
                  set inter_Flag_geo_skeleton [lrange $cc 1 6]
                   } 
    "Flag_geo_lig" {
                  set inter_Flag_geo_lig $c(2)
                   }                   
    "Flag_windows" {
                  set inter_Flag_windows $c(2)
                   }                                        
    "Allom_Blade(a_bB)" {
                  set inter_a_bB [lrange $cc 1 6]
                  }
    "(a_aB)" {
                  set inter_a_aB [lrange $cc 1 6]
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




