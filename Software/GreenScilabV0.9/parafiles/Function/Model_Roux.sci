    
Chr_Age(N) 40
Phy_Age(Maxp) 2
Sample_Size(Tr) 1 1 1 1 1 500
   
Axillary_Num(Nu_A) 0 1 0 0 0 0
                     0 0 0 0 0
                       0 0 0 0
                         0 0 0
                           0 0
                             0
Leaf_Num(Nu_B) 0 1 0 0 0 0
                 0 1 0 0 0
                   0 0 0 0
                     0 0 0
                       0 0
                         0
Female_Num(Nu_Ff) 0 1 0 0 0 0
                   0 1 0 0 0
                     0 0 0 0
                       0 0 0
                         0 0
                           0
Male_Num(Nu_Fm) 0 0 0 0 0 0
                      0 0 0 0 0
                        0 0 0 0
                          0 0 0
                            0 0
                              0
Micro_Num(Nu_I) 0 1 0 0 0 0
                  0 1 0 0 0
                    0 0 0 0
                      0 0 0
                        0 0
                          0
   
Macro_Num(Nu_Ma) 40 12 0 0 0 0
Struc_Jump(st_j) 0 0 0 0 0 0
Reiter_Order(b_o)    0 0 0 0 0 0
Bran_Control(br_a)   0 0 0 0 0 0
Reiter_Control(re_a) 0 0 0 0 0 0
Rest_Func(rs_A)      0 0 0 0 0 0
Rest_Func(rs_B)      0 0 0 0 0 0
rythm_Ratio(rt_a)    1 1 0 0 0 0
  
branching_proba(a)   1 1 1 1 1 1
Growth_macro(b)      1 1 1 1 1 1
Growth_micro(bu)     1 1 1 1 1 1
Survive(c)           1 1 1 1 1 1
  
%***********************Hydro*********************
%OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root
%phy_age=1
Time_Function(Tu_O(1))  15 1 5 5 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=2
Time_Function(Tu_O(1))  12 1 5 5 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=3
Time_Function(Tu_O(1))  1 1 1 1 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=4
Time_Function(Tu_O(1))  1 1 1 1 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=5
Time_Function(Tu_O(1))  1 1 1 1 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=6
Time_Function(Tu_O(1))  1 1 1 1 1 1 1 1
Time_appearance(2)      1 1 1 1 1 1 1 1
Time_disappearance(3)   99 99 99 99 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
   
Time_Expansion(t_exp)   12 1 12 12 1 1 1
Para_a(Bt_a)            1 1 1 1 1 1 1
Para_b(Bt_b)            1 1 1 1 1 1 1
   
Sink_Blade(S_B)     1 1 0.0 0.0 0.0 0.0
Sink_Petiole(S_P)    0.0 0.0 0.0 0.0 0.0 0.0
Sink_Internode(S_I) 0.4 0.4 0.0 0.0 0.0 0.0
Sink_Female(S_Ff)  3 4 0.0 0.0 0.0 0.0
Sink_Male(S_Fm)  0.0 0 0.0 0.0 0.0 0.0
Sink_Layer(S_L)     0.3 0.3 0.0 0.0 0.0 0.0
Sink_Root(S_R)      0.0 0.0 0.0 0.0 0.0 0.0
  
Allom_Internode(a_bI) 40 40 0 0 0 0
(a_aI)                0 0 0 0 0 0
Allom_Petiole(a_bP)    40 0 0 0 0 0
(a_aP)                0 0 0 0 0 0
Allom_Blade(a_bB)     1 1 1 1 1 1
(a_aB)                0.5 0.5 0.5 0.5 0.5 0.5
Allom_Thick(Th_B)     0.03 0.03 0 0 0 0
Female_Density(Den_Ff) 1 1 1 1 1 1
Male_Density(Den_Fm) 1 1 1 1 1 1
Internode_Dens(Den_I) 1 1 1 1 1 1
  
Flag_field             1
Resist_Blade(r_B)      5
Resist_Petiole(r_P)     0.05
Resist_Root(r_R)       0
Projected_area(Sp)     250
Beer_law(rp)           30
Beer_law(kp)           1
  
Seed_Biomass(Q0)       1
Flow_Biomass(dQ0)      0.0
Flag_RingOption        0
Coefficient_for_layer  1
   
ShortInter_Number(N_SI)    0
ShortInter_RelaSink(kp_SI) 1
   
%***********************Geometry*********************
Leaf_shape(smb_L)  default
Female_shape(smb_Ff) cube2
Male_shape(smb_Fm) 0
  
Leaf_color(Color_B)
0.1 0.6 0.1
1 0.7 0
Internode_color(Color_I)
0.3 0.5 0.1
0.5 0.1 0.1
Female_color(Color_Ff)
0.1 0.9 0.6
1 0 0
Male_color(Color_Fm)
0.6 0.1 0.2
0.9 0.1 0.2
  
Phy_Color(Color_P)
0 0 1
0 1 0
1 0 0
0.5 0.1 0.5
0.5 0.5 0.1
0.1 0.5 0.5
  
Angle_Male(Ang_Fm)    0 0 0 0 0 0
                           0 0 0 0 0
                             0 0 0 0
                               0 0 0
                                 0 0
                                   0
Angle_Female(Ang_Ff)    0 30 0 0 0 0
                           0 0 0 0 0
                             0 0 0 0
                               0 0 0
                                 0 0
                                   0
Angle_Blade(Ang_B)     0 30 0 0 0 0
                          0 30 0 0 0
                            0 0 0 0
                              0 0 0
                                0 0
                                  0
Angle_Axillary(Ang_A) 0 30 0 0 0 0
                         0 0 0 0 0
                           0 0 0 0
                             0 0 0
                               0 0
                                 0
Angle_Phyllotaxy(Ang_Ph)  180 180 180 180 180 1
  
Young_Modulus(Ey)         10000 6000 1000 1000 1000 100
Force_point(fp)           1 1 1.0 1.0 1.0 1.0
Terminal_Angle(Eng_Ang)   0 0 0 0 0 0
Righting_point(Eng_N)     0 0 0 0 0 5
InitialMin_angle(InitMin)    0 0 0 0 0 0
InitialMax_angle(InitMax)    0 0 0 0 0 0
InitialNum_angle(InitNum)    1 1 0 0 0 0
Flag_Bending_by_node      0 0 0 0 0 0
 
Max_Angle(wb)             90 60 0 0 0 0
Openning_cycle(wbn)       20 10 0 0 0 0
 
Organ(Flag_organ_bending) 0 0 0 0 0 0
Bending_branch(Theta_B)   0 0 0 0 0 0
Bending_leaf(Theta_L)     90 0 0 0 0 0
Bending_fruit(Theta_F)    0 0 0 0 0 0
  
Flag_plagiotropic         0 0 0 0 0 0
Leaf_direction(Flag)      1 1 0 0 0 0
  
Pruning(Flag_pruning)     0 0 0 0 0 0
Delay(Pruning_delay)      5 5 0 0 0 0
Leaf_display(Flag_leaf)   1 1 0 0 0 0
Fruit_display(Flag_fruit) 1 1 0 0 0 0
 
Internode_Volume(VI)      1 1 1 1 1 1
Blade_Volume(VB)          1 1 1 1 1 1
Fruit_Volume(VF)          0.04 0.04 0.04 0.04 0.04 0.04
Internode_C(CI)           0.9 0 0 0 0 0
Blade_C(CB)               0.9 0 0 0 0 0
Fruit_C(CF)               0.9 0 0 0 0 0
  
%***********************Environment*********************
%soil_water_budget
Flag_climate                0
SoilWaterEffect(K1)         3
SoilWaterEffect(K2)         3
Soil_budget_para(C1)        0.006
Soil_budget_para(C2)        0.006
InitialSoilWater(QSW0)      900
MaxPlantSoilWater(QSWMAX)   1000
MinPlantSoilWater(QSWMIN)   800
MaxEnvFSoilWater(QSW_MAX)   1200
MinEnvFSoilWater(QSW_MIN)   800
   
%temperature_effect
Flag_temperature            0
SumTEffect(Flag_sumt)       0
Temperature(E_ALPHA)        3.5
Temperature(E_BETA)         3
SumTEffect(KSUMT)           0.05
SumTEffect(THETA_BASE)      5
MaxPlantTemp(THETAMAX)      35
MinPlantTemp(THETAMIN)      10
MaxEnvFTemp(THETA_MAX)      40
MinEnvFTemp(THETA_MIN)      5
  
%light_effect
Flag_light                  0
Light(E_A)                  1
Light(E_B)                  0.009
MaxEnvFLight(LIGHTMAX)      1000
MinEnvFLight(LIGHTMIN)      50
MaxEnvFLight(LIGHT_MAX)     1000
MinEnvFLight(LIGHT_MIN)     0
PotentialCondition(E0)      1
   
%***********************OutputOption*********************
Flag_topo_disp              1 0 0 0 0 0
  
Flag_topo_disp_total        1
  
Flag_topo_disp_living       1 1 1 1 1 1
  
Flag_topo_disp_living_aboveGU 1 1 1 1 1 1
  
Flag_hydro                  1
  
Flag_demand_biomass_layer   1
  
Flag_demand_biomass_plant   1
  
Flag_biomass_repartition    1 0 0 0 0 0
  
Flag_biomass_fig            1
  
Flag_biomassdemand_fig      0
  
Flag_biomass_fig_accumulated 1
  
Flag_disp_LAI               1
  
Flag_organ_biomass_fig_phy  1 1 1 1 1 1
  
Flag_organ_size_fig_phy     1 1 1 1 1 1
  
Flag_geometry               1
  
Flag_geo_full               0
  
Flag_geo_3D                 1
  
Flag_geo_leaf               1
  
Flag_geo_fruit              1
  
Flag_geo_light              1
  
Flag_geo_skeleton           0 0 0 0 0 0
  
Flag_geo_lig                0
  
Flag_windows                0





