######### construct the task file content from configuration
proc form_task {} {
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
set tline "    "
set lines($i) $tline
incr i


set tline "Chr_Age(N) "
append tline  $inter_N
set lines($i) $tline
incr i

set tline "Phy_Age(Maxp) "
append tline  $inter_maxp
set lines($i) $tline
incr i

set tline "Sample_Size(Tr) "
append tline  $inter_Tr
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "Axillary_Num(Nu_A) "
append tline $inter_Nu_A1
set lines($i) $tline
incr i
set tline "                     "
append tline $inter_Nu_A2
set lines($i) $tline
incr i
set tline "                       "
append tline $inter_Nu_A3
set lines($i) $tline
incr i
set tline "                         "
append tline $inter_Nu_A4
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Nu_A5
set lines($i) $tline
incr i
set tline "                             "
append tline $inter_Nu_A6
set lines($i) $tline
incr i

set tline "Leaf_Num(Nu_B) "
append tline $inter_Nu_B1
set lines($i) $tline
incr i
set tline "                 "
append tline $inter_Nu_B2
set lines($i) $tline
incr i
set tline "                   "
append tline $inter_Nu_B3
set lines($i) $tline
incr i
set tline "                     "
append tline $inter_Nu_B4
set lines($i) $tline
incr i
set tline "                       "
append tline $inter_Nu_B5
set lines($i) $tline
incr i
set tline "                         "
append tline $inter_Nu_B6
set lines($i) $tline
incr i

set tline "Female_Num(Nu_Ff) "
append tline $inter_Nu_Ff1
set lines($i) $tline
incr i
set tline "                   "
append tline $inter_Nu_Ff2
set lines($i) $tline
incr i  
set tline "                     "
append tline $inter_Nu_Ff3
set lines($i) $tline
incr i 
set tline "                       "
append tline $inter_Nu_Ff4
set lines($i) $tline
incr i
set tline "                         "
append tline $inter_Nu_Ff5
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Nu_Ff6
set lines($i) $tline
incr i

set tline "Male_Num(Nu_Fm) "
append tline $inter_Nu_Fm1
set lines($i) $tline
incr i
set tline "                   "
append tline $inter_Nu_Fm2
set lines($i) $tline
incr i
set tline "                     "
append tline $inter_Nu_Fm3
set lines($i) $tline
incr i
set tline "                       "
append tline $inter_Nu_Fm4
set lines($i) $tline
incr i
set tline "                         "
append tline $inter_Nu_Fm5
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Nu_Fm6
set lines($i) $tline
incr i

set tline "Micro_Num(Nu_I) "
append tline $inter_Nu_I1
set lines($i) $tline
incr i
set tline "                  "
append tline $inter_Nu_I2
set lines($i) $tline
incr i
set tline "                    "
append tline $inter_Nu_I3
set lines($i) $tline
incr i 
set tline "                      "
append tline $inter_Nu_I4
set lines($i) $tline
incr i 
set tline "                        "
append tline $inter_Nu_I5
set lines($i) $tline
incr i
set tline "                          "
append tline $inter_Nu_I6
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "Macro_Num(Nu_Ma) "
append tline $inter_Nu_Ma
set lines($i) $tline
incr i

set tline "Struc_Jump(st_j) "
append tline $inter_st_j
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline

set tline "Reiter_Order(b_o)    "
append tline $inter_b_o
set lines($i) $tline
incr i

set tline "Bran_Control(br_a)   "
append tline $inter_br_a
set lines($i) $tline
incr i

set tline "Reiter_Control(re_a) "
append tline $inter_re_a
set lines($i) $tline
incr i

set tline "Rest_Func(rs_A)      "
append tline $inter_rs_A
set lines($i) $tline
incr i

set tline "Rest_Func(rs_B)      "
append tline $inter_rs_B
set lines($i) $tline
incr i

set tline "rythm_Ratio(rt_a)    "
append tline $inter_rt_a
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "branching_proba(a)   "
append tline $inter_a
set lines($i) $tline
incr i

set tline "Growth_macro(b)      "
append tline $inter_b
set lines($i) $tline
incr i

set tline "Growth_micro(bu)     "
append tline $inter_bu
set lines($i) $tline
incr i

set tline "Survive(c)           "
append tline $inter_c
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "%***********************Hydro*********************"
set lines($i) $tline
incr i
set tline "%OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root"
set lines($i) $tline
incr i
set tline "%phy_age=1"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F1
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a1
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d1
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b1
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i1
set lines($i) $tline
incr i

set tline "%phy_age=2"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F2
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a2
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d2
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b2
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i2
set lines($i) $tline
incr i

set tline "%phy_age=3"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F3
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a3
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d3
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b3
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i3
set lines($i) $tline
incr i

set tline "%phy_age=4"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F4
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a4
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d4
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b4
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i4
set lines($i) $tline
incr i

set tline "%phy_age=5"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F5
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a5
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d5
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b5
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i5
set lines($i) $tline
incr i

set tline "%phy_age=6"
set lines($i) $tline
incr i

set tline "Time_Function(Tu_O(1))  "
append tline $inter_T_F6
set lines($i) $tline
incr i

set tline "Time_appearance(2)      "
append tline $inter_T_a6
set lines($i) $tline
incr i

set tline "Time_disappearance(3)   "
append tline $inter_T_d6
set lines($i) $tline
incr i

set tline "Time_busy(4)            "
append tline $inter_T_b6
set lines($i) $tline
incr i

set tline "Time_idle(5)            "
append tline $inter_T_i6
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "Time_Expansion(t_exp)   "
append tline $inter_t_exp
set lines($i) $tline
incr i

set tline "Para_a(Bt_a)            "
append tline $inter_Bt_a
set lines($i) $tline
incr i

set tline "Para_b(Bt_b)            "
append tline $inter_Bt_b
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "Sink_Blade(S_B)     "
append tline $inter_S_B
set lines($i) $tline
incr i

set tline "Sink_Petiole(S_P)   "
append tline $inter_S_P
set lines($i) $tline
incr i

set tline "Sink_Internode(S_I) "
append tline $inter_S_I
set lines($i) $tline
incr i

set tline "Sink_Female(S_Ff)   "
append tline $inter_S_Ff
set lines($i) $tline
incr i

set tline "Sink_Male(S_Fm)     "
append tline $inter_S_Fm
set lines($i) $tline
incr i

set tline "Sink_Layer(S_L)     "
append tline $inter_S_L
set lines($i) $tline
incr i

set tline "Sink_Root(S_R)      "
append tline $inter_S_R
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Allom_Internode(a_bI) "
append tline $inter_a_bI
set lines($i) $tline
incr i

set tline "(a_aI)                "
append tline $inter_a_aI
set lines($i) $tline
incr i

set tline "Allom_Petiole(a_bP)   "
append tline $inter_a_bP
set lines($i) $tline
incr i

set tline "(a_aP)                "
append tline $inter_a_aP
set lines($i) $tline
incr i

set tline "Allom_Blade(a_bB)     "
append tline $inter_a_bB
set lines($i) $tline
incr i

set tline "(a_aB)                "
append tline $inter_a_aB
set lines($i) $tline
incr i

set tline "Allom_Thick(Th_B)     "
append tline $inter_Th_B
set lines($i) $tline
incr i

set tline "Female_Density(Den_Ff) "
append tline $inter_Den_Ff
set lines($i) $tline
incr i

set tline "Male_Density(Den_Fm)  "
append tline $inter_Den_Fm
set lines($i) $tline
incr i

set tline "Internode_Dens(Den_I) "
append tline $inter_Den_I
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_field             "
append tline $inter_Flag_field  
set lines($i) $tline
incr i

set tline "Resist_Blade(r_B)      "
append tline $inter_r_B
set lines($i) $tline
incr i

set tline "Resist_Petiole(r_P)    "
append tline $inter_r_P
set lines($i) $tline
incr i

set tline "Resist_Root(r_R)       "
append tline $inter_r_R
set lines($i) $tline
incr i

set tline "Projected_area(Sp)     "
append tline $inter_Sp                                                          
set lines($i) $tline
incr i

set tline "Beer_law(rp)           "
append tline $inter_rp                                                                                                                   
set lines($i) $tline
incr i

set tline "Beer_law(kp)           "
append tline $inter_kp                                                                                                                    
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Seed_Biomass(Q0)       "
append tline $inter_Q0
set lines($i) $tline
incr i

set tline "Flow_Biomass(dQ0)      "
append tline $inter_dQ0
set lines($i) $tline
incr i

set tline "Flag_RingOption        "
append tline $inter_RingOption
set lines($i) $tline
incr i

set tline "Coefficient_for_layer  "
append tline $inter_coff_L
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "ShortInter_Number(N_SI)    "
append tline $inter_N_SI
set lines($i) $tline
incr i

set tline "ShortInter_RelaSink(kp_SI) "
append tline $inter_kp_SI
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "%***********************Geometry*********************"
set lines($i) $tline
incr i

set tline "Leaf_shape(smb_L)  "
append tline $inter_Smb_L
set lines($i) $tline 
incr i

set tline "Female_shape(smb_Ff) "
append tline $inter_Smb_Ff
set lines($i) $tline
incr i

set tline "Male_shape(smb_Fm)   "
append tline $inter_Smb_Fm
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline 
incr i

set tline "Leaf_color(Color_B)"
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_B_alive
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_B_dead
set lines($i) $tline
incr i

set tline "Internode_color(Color_I)"
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_I_alive
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_I_dead
set lines($i) $tline
incr i

set tline "Female_color(Color_Ff)"
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Ff_alive
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Ff_dead
set lines($i) $tline
incr i 

set tline "Male_color(Color_Fm)"
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Fm_alive
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Fm_dead
set lines($i) $tline
incr i 

set tline "  "
set lines($i) $tline
incr i

set tline "Phy_Color(Color_P)"
set lines($i) $tline
incr i

set tline ""
append tline $inter_Color_Phy1
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Phy2
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Phy3
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Phy4
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Phy5
set lines($i) $tline
incr i
set tline ""
append tline $inter_Color_Phy6
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Angle_Male(Ang_Fm)       "
append tline $inter_Ang_Fm1
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Ang_Fm2
set lines($i) $tline
incr i
set tline "                             "
append tline $inter_Ang_Fm3
set lines($i) $tline
incr i
set tline "                               "
append tline $inter_Ang_Fm4
set lines($i) $tline
incr i
set tline "                                 "
append tline $inter_Ang_Fm5
set lines($i) $tline
incr i
set tline "                                   "
append tline $inter_Ang_Fm6
set lines($i) $tline
incr i

set tline "Angle_Female(Ang_Ff)     "
append tline $inter_Ang_Ff1
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Ang_Ff2
set lines($i) $tline
incr i
set tline "                             "
append tline $inter_Ang_Ff3
set lines($i) $tline
incr i
set tline "                               "
append tline $inter_Ang_Ff4
set lines($i) $tline
incr i
set tline "                                 "
append tline $inter_Ang_Ff5
set lines($i) $tline
incr i
set tline "                                   "
append tline $inter_Ang_Ff6
set lines($i) $tline
incr i

set tline "Angle_Blade(Ang_B)     "
append tline $inter_Ang_B1
set lines($i) $tline
incr i
set tline "                          "
append tline $inter_Ang_B2
set lines($i) $tline
incr i
set tline "                            "
append tline $inter_Ang_B3
set lines($i) $tline
incr i
set tline "                              "
append tline $inter_Ang_B4
set lines($i) $tline
incr i
set tline "                                "
append tline $inter_Ang_B5
set lines($i) $tline
incr i
set tline "                                  "
append tline $inter_Ang_B6
set lines($i) $tline
incr i

set tline "Angle_Axillary(Ang_A) "
append tline $inter_Ang_A1
set lines($i) $tline
incr i
set tline "                         "
append tline $inter_Ang_A2
set lines($i) $tline
incr i
set tline "                           "
append tline $inter_Ang_A3
set lines($i) $tline
incr i
set tline "                             "
append tline $inter_Ang_A4
set lines($i) $tline
incr i
set tline "                               "
append tline $inter_Ang_A5
set lines($i) $tline
incr i
set tline "                                 "
append tline $inter_Ang_A6
set lines($i) $tline
incr i

set tline "Angle_Phyllotaxy(Ang_Ph)  "
append tline $inter_Ang_Ph
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Young_Modulus(Ey)         "
append tline $inter_Ey
set lines($i) $tline
incr i

set tline "Force_point(fp)           "
append tline $inter_fp
set lines($i) $tline
incr i

set tline "Terminal_Angle(Eng_Ang)   "
append tline $inter_Eng_Ang
set lines($i) $tline 
incr i

set tline "Righting_point(Eng_N)     "
append tline $inter_Eng_N
set lines($i) $tline
incr i

set tline "InitialMin_angle(InitMin) "
append tline $inter_InitMin
set lines($i) $tline
incr i

set tline "InitialMax_angle(InitMax) "
append tline $inter_InitMax
set lines($i) $tline
incr i

set tline "InitialNum_angle(InitNum) "
append tline $inter_InitNum
set lines($i) $tline
incr i

set tline "Flag_Bending_by_node      "
append tline $inter_Flag_Bending_by_node
set lines($i) $tline
incr i

set tline " "
set lines($i) $tline
incr i

set tline "Max_Angle(wb)             "
append tline $inter_wb
set lines($i) $tline
incr i

set tline "Openning_cycle(wbn)       "
append tline $inter_wbn
set lines($i) $tline
incr i

set tline " "
set lines($i) $tline
incr i

set tline "Organ(Flag_organ_bending) "
append tline $inter_Flag_Organ_bending
set lines($i) $tline
incr i

set tline "Bending_branch(Theta_B)   "
append tline $inter_Theta_B
set lines($i) $tline
incr i

set tline "Bending_leaf(Theta_L)     "
append tline $inter_Theta_L
set lines($i) $tline
incr i

set tline "Bending_fruit(Theta_F)    "
append tline $inter_Theta_F
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_plagiotropic         "
append tline $inter_Flag_Plagiotropic
set lines($i) $tline
incr i

set tline "Leaf_direction(Flag)      "
append tline $inter_Flag
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Pruning(Flag_pruning)     "
append tline $inter_Flag_pruning
set lines($i) $tline
incr i

set tline "Delay(Pruning_delay)      "
append tline $inter_Pruning_delay
set lines($i) $tline
incr i

set tline "Leaf_display(Flag_leaf)   "
append tline $inter_Flag_leaf
set lines($i) $tline
incr i

set tline "Fruit_display(Flag_fruit) "
append tline $inter_Flag_fruit
set lines($i) $tline
incr i

set tline " "
set lines($i) $tline
incr i

set tline "Internode_Volume(VI)      "
append tline $inter_VI
set lines($i) $tline
incr i

set tline "Blade_Volume(VB)          "
append tline $inter_VB
set lines($i) $tline
incr i

set tline "Fruit_Volume(VF)          "
append tline $inter_VF
set lines($i) $tline
incr i

set tline "Internode_C(CI)           "
append tline $inter_CI
set lines($i) $tline
incr i

set tline "Blade_C(CB)               "
append tline $inter_CB
set lines($i) $tline
incr i

set tline "Fruit_C(CF)               "
append tline $inter_CF
set lines($i) $tline 
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "%***********************Environment*********************"
set lines($i) $tline
incr i

set tline "%soil_water_budget"
set lines($i) $tline
incr i
set tline "Flag_climate                "
append tline $inter_Flag_climate
set lines($i) $tline
incr i
set tline "SoilWaterEffect(K1)         "
append tline $inter_K1
set lines($i) $tline
incr i
set tline "SoilWaterEffect(K2)         "
append tline $inter_K2
set lines($i) $tline
incr i
set tline "Soil_budget_para(C1)        "
append tline $inter_C1
set lines($i) $tline
incr i
set tline "Soil_budget_para(C2)        "
append tline $inter_C2
set lines($i) $tline
incr i
set tline "InitialSoilWater(QSW0)      "
append tline $inter_QSW0
set lines($i) $tline
incr i
set tline "MaxPlantSoilWater(QSWMAX)   "
append tline $inter_QSWMAX
set lines($i) $tline 
incr i
set tline "MinPlantSoilWater(QSWMIN)   "
append tline $inter_QSWMIN
set lines($i) $tline
incr i
set tline "MaxEnvFSoilWater(QSW_MAX)   "
append tline $inter_QSW_MAX
set lines($i) $tline
incr i
set tline "MinEnvFSoilWater(QSW_MIN)   "
append tline $inter_QSW_MIN
set lines($i) $tline
incr i
set tline "   "
set lines($i) $tline
incr i

set tline "%temperature_effect"
set lines($i) $tline
incr i
set tline "Flag_temperature            "
append tline $inter_Flag_temperature
set lines($i) $tline
incr i
set tline "SumTEffect(Flag_sumt)       "
append tline $inter_Flag_sumt
set lines($i) $tline
incr i
set tline "Temperature(E_ALPHA)        "
append tline $inter_E_ALPHA
set lines($i) $tline 
incr i
set tline "Temperature(E_BETA)         "
append tline $inter_E_BETA
set lines($i) $tline
incr i
set tline "SumTEffect(KSUMT)           "
append tline $inter_KSUMT
set lines($i) $tline
incr i
set tline "SumTEffect(THETA_BASE)      "
append tline $inter_THETA_BASE
set lines($i) $tline
incr i
set tline "MaxPlantTemp(THETAMAX)      "
append tline $inter_THETAMAX
set lines($i) $tline
incr i
set tline "MinPlantTemp(THETAMIN)      "
append tline $inter_THETAMIN
set lines($i) $tline
incr i
set tline "MaxEnvFTemp(THETA_MAX)      "
append tline $inter_THETA_MAX
set lines($i) $tline
incr i
set tline "MinEnvFTemp(THETA_MIN)      "
append tline $inter_THETA_MIN
set lines($i) $tline
incr i
set tline "  "
set lines($i) $tline
incr i

set tline "%light_effect"
set lines($i) $tline
incr i
set tline "Flag_light                  "
append tline $inter_Flag_light
set lines($i) $tline
incr i
set tline "Light(E_A)                  "
append tline $inter_E_A
set lines($i) $tline
incr i
set tline "Light(E_B)                  "
append tline $inter_E_B
set lines($i) $tline
incr i
set tline "MaxEnvFLight(LIGHTMAX)      "
append tline $inter_LIGHTMAX
set lines($i) $tline
incr i
set tline "MinEnvFLight(LIGHTMIN)      "
append tline $inter_LIGHTMIN
set lines($i) $tline
incr i
set tline "MaxEnvFLight(LIGHT_MAX)     "
append tline $inter_LIGHT_MAX
set lines($i) $tline
incr i
set tline "MinEnvFLight(LIGHT_MIN)     "
append tline $inter_LIGHT_MIN
set lines($i) $tline
incr i
set tline "PotentialCondition(E0)      "
append tline $inter_E0
set lines($i) $tline
incr i

set tline "   "
set lines($i) $tline
incr i

set tline "%***********************OutputOption*********************"
set lines($i) $tline
incr i

set tline "Flag_topo_disp              "
append tline $inter_Flag_topo_disp
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_topo_disp_total        "
append tline $inter_Flag_topo_disp_s
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_topo_disp_living       "
append tline $inter_Flag_topo_disp_l
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_topo_disp_living_aboveGU "
append tline $inter_Flag_topo_disp_a
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_hydro                  "
append tline $inter_Flag_hydro
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_demand_biomass_layer   "
append tline $inter_Flag_layer_disp
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_demand_biomass_plant   "
append tline $inter_Flag_demand_biomass
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_biomass_repartition    "
append tline $inter_Flag_biomass_num 
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_biomass_fig            "
append tline $inter_Flag_biomass_fig  
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_biomassdemand_fig      "
append tline $inter_Flag_bioprod_fig  
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_biomass_fig_accumulated "
append tline $inter_Flag_biomass_fig_a  
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_disp_LAI               "
#append tline $inter_Flag_disp_LAI
append tline 1
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_organ_biomass_fig_phy  "
append tline $inter_Flag_biomass_fig_phy  
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_organ_size_fig_phy     "
append tline $inter_Flag_size_fig_phy  
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geometry               "
append tline $inter_Flag_geometry   
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_full               "
append tline $inter_Flag_geo_full   
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_3D                 "
append tline $inter_Flag_geo_3D    
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_leaf               "
append tline $inter_Flag_geo_leaf     
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_fruit              "
append tline $inter_Flag_geo_fruit     
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_light              "
append tline $inter_Flag_geo_light     
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_skeleton           "
append tline $inter_Flag_geo_skeleton     
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_geo_lig                "
append tline $inter_Flag_geo_lig      
set lines($i) $tline
incr i

set tline "  "
set lines($i) $tline
incr i

set tline "Flag_windows                "
append tline $inter_Flag_windows      
set lines($i) $tline
incr i

catch {unset content}

	for {set i 1 } { $i <= [array size lines]} {incr i} {
			set content($i)  $lines($i)
	}

updateTask	                                   
}   





















