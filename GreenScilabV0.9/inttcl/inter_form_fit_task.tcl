######### construct the task file content from configuration
proc form_fit_task {} {

########################################## fitting
global inter_c_S_B
	global inter_c_S_P
	global inter_c_S_I
	global inter_c_S_Ff
	global inter_c_S_Fm
	global inter_c_S_L
	global inter_c_S_R
	global inter_c_t_exp
	global inter_c_Bt_a
	global inter_c_Bt_b
	global inter_c_Sp
	global inter_c_rp
	global inter_c_kp
	global inter_c_Q0
	global inter_c_dQ0
	global inter_c_r_B
	global inter_c_r_P
	global inter_c_r_R
	global inter_c_a_aI
global inter_c_a_bI
global inter_c_a_aI
global inter_c_a_bP
global inter_c_a_aP
global inter_c_Th_B
global inter_c_Den_Ff
global inter_c_Den_Fm
global inter_c_Den_I

####### content of the test file
global content

set i 1
set tline "//---------------------Control_Parameters_on_Fitting---------------------"
set lines($i) $tline
incr i

set tline "//OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root"
set lines($i) $tline
incr i

set tline "Time_Expansion(c_t_exp) "
append tline $inter_c_t_exp
set lines($i) $tline
incr i

set tline "Para_a(c_Bt_a) "
append tline $inter_c_Bt_a
set lines($i) $tline
incr i

set tline "Para_b(c_Bt_b) "
append tline $inter_c_Bt_b
set lines($i) $tline
incr i

set tline "    "
set lines($i) $tline
incr i

set tline "Sink_Blade(c_S_B)      "
append tline $inter_c_S_B
set lines($i) $tline
incr i

set tline "Sink_Petiole(c_S_P)    "
append tline $inter_c_S_P
set lines($i) $tline
incr i

set tline "Sink_Internode(c_S_I)  "
append tline $inter_c_S_I
set lines($i) $tline
incr i

set tline "Sink_Female(c_S_Ff)    "
append tline $inter_c_S_Ff
set lines($i) $tline
incr i

set tline "Sink_Male(c_S_Fm)      "
append tline $inter_c_S_Fm
set lines($i) $tline
incr i

set tline "Sink_Layer(c_S_L)      "
append tline $inter_c_S_L
set lines($i) $tline
incr i

set tline "Sink_Root(c_S_R)       "
append tline $inter_c_S_R
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Allom_Internode(c_a_bI) "
append tline $inter_c_a_bI
set lines($i) $tline
incr i

set tline "(c_a_aI)                "
append tline $inter_c_a_aI
set lines($i) $tline
incr i

set tline "Allom_Petiole(c_a_bP)   "
append tline $inter_c_a_bP
set lines($i) $tline
incr i

set tline "(c_a_aP)                "
append tline $inter_c_a_aP
set lines($i) $tline
incr i

set tline "Allom_Thick(c_Th_B)     "
append tline $inter_c_Th_B
set lines($i) $tline
incr i

set tline "Female_Density(c_Den_Ff) "
append tline $inter_c_Den_Ff
set lines($i) $tline
incr i

set tline "Male_Density(c_Den_Fm)  "
append tline $inter_c_Den_Fm
set lines($i) $tline
incr i

set tline "Internode_Dens(c_Den_I) "
append tline $inter_c_Den_I
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i


set tline "Resist_Blade(c_r_B)      "
append tline $inter_c_r_B
set lines($i) $tline
incr i

set tline "Resist_Petiole(c_r_P)    "
append tline $inter_c_r_P
set lines($i) $tline
incr i

set tline "Projected_area(c_Sp)     "
append tline $inter_c_Sp                                                          
set lines($i) $tline
incr i

set tline "Beer_law(c_rp)           "
append tline $inter_c_rp                                                                                                                   
set lines($i) $tline
incr i

set tline "Beer_law(c_kp)           "
append tline $inter_c_kp                                                                                                                    
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Resist_Root(c_r_R)       "
append tline $inter_c_r_R
set lines($i) $tline
incr i

set tline "Seed_Biomass(c_Q0)       "
append tline $inter_c_Q0
set lines($i) $tline
incr i

set tline "Flow_Biomass(c_dQ0)      "
append tline $inter_c_dQ0
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

catch {unset content}

	for {set i 1 } { $i <= [array size lines]} {incr i} {
			set content($i)  $lines($i)
	}
                                   
}   





















