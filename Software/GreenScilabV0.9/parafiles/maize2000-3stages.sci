    
Chr_Age(N) 33
Phy_Age(Maxp) 1
Sample_Size(Tr) 1 1 1 1 1 500
   
Axillary_Num(Nu_A) 0 0 0 0 0 0
                     0 0 0 0 0
                       0 0 0 0
                         0 0 0
                           0 0
                             0
Leaf_Num(Nu_B) 0 1 0 0 0 0
                 0 0 0 0 0
                   0 0 0 0
                     0 0 0
                       0 0
                         0
Female_Num(Nu_Ff) 0 1 0 0 0 0
                   0 0 0 0 0
                     0 0 0 0
                       0 0 0
                         0 0
                           0
Male_Num(Nu_Fm) 0 1 0 0 0 0
                   0 0 0 0 0
                     0 0 0 0
                       0 0 0
                         0 0
                           0
Micro_Num(Nu_I) 0 1 0 0 0 0
                  0 0 0 0 0
                    0 0 0 0
                      0 0 0
                        0 0
                          0
   
Macro_Num(Nu_Ma) 21 0 0 0 0 0
Struc_Jump(st_j) 0 0 0 0 0 0
Reiter_Order(b_o)    0 0 0 0 0 0
Bran_Control(br_a)   0 0 0 0 0 0
Reiter_Control(re_a) 0 0 0 0 0 0
Rest_Func(rs_A)      0 0 0 0 0 0
Rest_Func(rs_B)      0 0 0 0 0 0
rythm_Ratio(rt_a)    1 1 1 1 1 1
  
branching_proba(a)   1 1 0 0 0 0
Growth_macro(b)      1 1 1 1 1 1
Growth_micro(bu)     1 1 1 1 1 1
Survive(c)           1 1 1 1 1 1
  
%***********************Hydro*********************
%OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root
%phy_age=1
Time_Function(Tu_O(1))  12 10 10 18 5 1 1 1
Time_appearance(2)      1 1 1 15 21 1 1 1
Time_disappearance(3)   99 99 99 16 99 99 99 99
Time_busy(4)            1 1 1 1 1 1 1 1
Time_idle(5)            0 0 0 0 0 0 0 0
%phy_age=2
Time_Function(Tu_O(1))  12 12 12 18 10 1 1 1
Time_appearance(2)      1 1 1 10 16 10 1 1
Time_disappearance(3)   99 99 99 11 17 99 99 99
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
   
Time_Expansion(t_exp)   12 12 12 18 2 1 1
Para_a(Bt_a)            1.4 1.9 3.3 6.6 1 1 1
Para_b(Bt_b)            2.287166 2.566926 1.221665 2.645986 1 0 0
   
Sink_Blade(S_B)     1 0 0.0 0.0 0.0 0.0
Sink_Petiole(S_P)   0.681206 0 0.0 0.0 0.0 0.0
Sink_Internode(S_I) 2.558497 0 0.0 0.0 0.0 0.0
Sink_Female(S_Ff)   465.123146 0 0.0 0.0 0.0 0.0
Sink_Male(S_Fm)     4.9 0 0.0 0.0 0.0 0.0
Sink_Layer(S_L)     0.0 0.0 0.0 0.0 0.0 0.0
Sink_Root(S_R)      0.0 0.0 0.0 0.0 0.0 0.0
  
Allom_Internode(a_bI) 2 10 3 3 3 3
(a_aI)                0 0 -1 -1 -1 0
Allom_Petiole(a_bP)    40 40 40 40 40 40
(a_aP)                0 0 0 0 0 0
Allom_Blade(a_bB)     0.1 0.1 0.1 0.1 0.1 0.1
(a_aB)                1 1 1 1 1 1
Allom_Thick(Th_B)     0.025 0.023 0.05 0.05 0.05 0.05
Female_Density(Den_Ff) 1 1 1 1 1 1
Male_Density(Den_Fm)  0.02 1 1 1 1 1
Internode_Dens(Den_I) 0.7 0.5 1 1 1 1
  
Flag_field             1
Resist_Blade(r_B)      38000
Resist_Petiole(r_P)    0
Resist_Root(r_R)       0
Projected_area(Sp)     3600
Beer_law(rp)           367.619202
Beer_law(kp)           0.661397
  
Seed_Biomass(Q0)       0.15
Flow_Biomass(dQ0)      0.0
Flag_RingOption        0
Coefficient_for_layer  1
   
ShortInter_Number(N_SI)    6
ShortInter_RelaSink(kp_SI) 0.1
   
%***********************Geometry*********************
Leaf_shape(smb_L)  maizeleaf
Female_shape(smb_Ff) maizecone
Male_shape(smb_Fm)   maizetassel
  
Leaf_color(Color_B)
0.0549020 0.7254902 0.0156863
0.0549020 0.7254902 0.0156863
Internode_color(Color_I)
0.0117647 0.3607843 0.039215
0.0117647 0.3607843 0.039215
Female_color(Color_Ff)
0 1 0
0 1 0
Male_color(Color_Fm)
0.7921569 0.6941176 0.0156863
0.7921569 0.6941176 0.0156863
  
Phy_Color(Color_P)
0 0 1
0 1 0
1 0 0
0.5 0.1 0.5
0.5 0.5 0.1
0.1 0.5 0.5
  
Angle_Male(Ang_Fm)       0 90 60 60 30 0
                           0 90 60 60 0
                             0 60 60 0
                               0 60 0
                                 0 0
                                   0
Angle_Female(Ang_Ff)     0 30 60 60 80 0
                           0 30 60 80 0
                             0 60 80 0
                               0 80 0
                                 0 0
                                   0
Angle_Blade(Ang_B)     0 -30 60 60 80 0
                          0 -30 60 80 0
                            0 60 80 0
                              0 80 0
                                0 0
                                  0
Angle_Axillary(Ang_A) 0 120 90 90 0 0
                         0 90 90 0 0
                           0 90 0 0
                             0 0 0
                               0 0
                                 0
Angle_Phyllotaxy(Ang_Ph)  180 180 180 180 1 1
  
Young_Modulus(Ey)         2000 2000 10000 10000 100 100
Force_point(fp)           1 1 1.0 1.0 1.0 1.0
Terminal_Angle(Eng_Ang)   0 0 0 0 0 0
Righting_point(Eng_N)     0 0 0 0 5 5
InitialMin_angle(InitMin) 0 0 20 0 10 10
InitialMax_angle(InitMax) 0 0 80 0 10 10
InitialNum_angle(InitNum) 1 1 1 1 1 1
Flag_Bending_by_node      1 1 1 1 1 1
 
Max_Angle(wb)             60 90 90 90 0 0
Openning_cycle(wbn)       0 0 0 0 1 1
 
Organ(Flag_organ_bending) 0 0 0 0 0 0
Bending_branch(Theta_B)   0 0 0 0 0 0
Bending_leaf(Theta_L)     90 90 0 0 0 0
Bending_fruit(Theta_F)    0 0 0 0 0 0
  
Flag_plagiotropic         1 1 0 0 1 1
Leaf_direction(Flag)      1 1 0 0 0 0
  
Pruning(Flag_pruning)     0 0 0 0 0 0
Delay(Pruning_delay)      3 0 0 0 0 0
Leaf_display(Flag_leaf)   1 1 1 1 1 1
Fruit_display(Flag_fruit) 1 1 1 1 1 1
 
Internode_Volume(VI)      1 1 1 1 1 1
Blade_Volume(VB)          1 1 1 1 1 1
Fruit_Volume(VF)          0.04 0.04 0.04 0.04 0.04 0.04
Internode_C(CI)           0.9 0.9 0.9 0.9 0.9 0.9
Blade_C(CB)               0.9 0.9 0.9 0.9 0.9 0.9
Fruit_C(CF)               0.9 0.9 0.9 0.9 0.9 0.9
  
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
PotentialCondition(E0)      11
   
%***********************OutputOption*********************
Flag_topo_disp              1 0 0 0 0 0
  
Flag_topo_disp_total        0
  
Flag_topo_disp_living       1 0 0 0 0 0
  
Flag_topo_disp_living_aboveGU 0 0 0 0 0 0
  
Flag_hydro                  1
  
Flag_demand_biomass_layer   0
  
Flag_demand_biomass_plant   0
  
Flag_biomass_repartition    1 0 0 0 0 0
  
Flag_biomass_fig            1
  
Flag_biomassdemand_fig      0
  
Flag_biomass_fig_accumulated 0
  
Flag_disp_LAI               1
  
Flag_organ_biomass_fig_phy  0 0 0 0 0 0
  
Flag_organ_size_fig_phy     1 0 0 0 0 0
  
Flag_geometry               1
  
Flag_geo_full               0
  
Flag_geo_3D                 1
  
Flag_geo_leaf               1
  
Flag_geo_fruit              1
  
Flag_geo_light              0
  
Flag_geo_skeleton           0 0 0 0 0 0
  
Flag_geo_lig                0
  
Flag_windows                0
    
//---------------------Control_Parameters_on_Fitting---------------------
//OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root
Time_Expansion(c_t_exp) 0 0 0 0 0 0 0
Para_a(c_Bt_a) 0 0 0 0 0 0 0
Para_b(c_Bt_b) 1 1 1 1 0 0 0
    
Sink_Blade(c_S_B)      0 0 0 0 0 0
Sink_Petiole(c_S_P)    1 0 0 0 0 0
Sink_Internode(c_S_I)  1 0 0 0 0 0
Sink_Female(c_S_Ff)    1 0 0 0 0 0
Sink_Male(c_S_Fm)      0 0 0 0 0 0
Sink_Layer(c_S_L)      0 0 0 0 0 0
Sink_Root(c_S_R)       0 0 0 0 0 0
  
Allom_Internode(c_a_bI) 0 0 0 0 0 0
(c_a_aI)                0 0 0 0 0 0
Allom_Petiole(c_a_bP)   0 0 0 0 0 0
(c_a_aP)                0 0 0 0 0 0
Allom_Thick(c_Th_B)     0 0 0 0 0 0
Female_Density(c_Den_Ff) 0 0 0 0 0 0
Male_Density(c_Den_Fm)  0 0 0 0 0 0
Internode_Dens(c_Den_I) 0 0 0 0 0 0
  
Resist_Blade(c_r_B)      0
Resist_Petiole(c_r_P)    0
Projected_area(c_Sp)     0
Beer_law(c_rp)           1
Beer_law(c_kp)           1
  
Resist_Root(c_r_R)       0
Seed_Biomass(c_Q0)       0
Flow_Biomass(c_dQ0)      0
  
  
//TargetFlag(C_Tar)  
WeightRoot(Q_R)      0
WeightBlade(Q_B)     1 0 0 0 0 0  
WeightPetiole(Q_P)   1 0 0 0 0 0 
WeightInternode(Q_I) 1 0 0 0 0 0
WeightFemale(Q_Ff)   1 0 0 0 0 0
WeightMale(Q_Fm)     1 0 0 0 0 0
AreaInternode(S_B)   0 0 0 0 0 0
HeightInternode(S_I) 0 0 0 0 0 0
AreaBlade(H_I)       0 0 0 0 0 0


//**********************Target*data***************************
NumberPlant(NumPlt)  1

InfoPlant(CA,PA,LoD) 33 1 0
Root(Q_R)  -1
//-GU--NbSub--IDSub--Q_B--Q_P--Q_I--Q_Ff--Q_Fm-S_B--S_I--H_I- 
InfoAxis(ID,PA,CA)  0  1  33
GU	1	0	-1	0.09	0.09	2.01	0	0	5.7	2.01	0.65
GU	2	0	-1	0.23	0.19	2.01	0	0	12.8	2.01	0.65
GU	3	0	-1	0.41	0.34	2.01	0	0	14.34	2.01	0.65
GU	4	0	-1	1.03	0.95	2.01	0	0	45.26	2.01	0.65
GU	5	0	-1	4.5	2.75	2.01	0	0	178.38	2.01	0.65
GU	6	0	-1	8.22	7.76	26.23	0	0	315.23	26.23	3.73
GU	7	0	-1	11.46	10.29	44.21	0	0	409.82	44.21	6.33
GU	8	0	-1	15.46	13.23	52.53	0	0	535.42	52.53	8.88
GU	9	0	-1	19.78	15.26	53.34	0	0	670.34	53.34	10.43
GU	10	0	-1	23.58	16.24	50.71	0	0	792.32	50.71	11.75
GU	11	0	-1	26.45	17.17	44.32	0	0	908.06	44.32	12.73
GU	12	0	-1	28.38	17.63	39.92	0	0	977.94	39.92	13.75
GU	13	0	-1	28.11	17.25	34.48	0	0	1007.87	34.48	14.18
GU	14	0	-1	26.75	17.14	26.82	0	0	987.71	26.82	14.58
GU	15	0	-1	24.77	15.84	20.86	895.4	0	912.65	20.86	14.2
GU	16	0	-1	22.22	14.36	16.2	0	0	855.31	16.2	14.23
GU	17	0	-1	18.86	12.42	12.43	0	0	739.27	12.43	14.55
GU	18	0	-1	14.35	10.1	8.94	0	0	597.45	8.94	14.08
GU	19	0	-1	9.25	7.65	6.7	0	0	421.99	6.7	14.48
GU	20	0	-1	4.18	3.99	3.88	0	0	205.85	3.88	11.53
GU	21	0	-1	0.2	1.12	1.11	0	29.11	9.11	1.11	-1
end




//---------------------Control_Parameters_on_Fitting---------------------
//OrganType(id)--------Blade-Petiel-Internode-FemaleFlower-MaleFlower-Ring-Root
Time_Expansion(c_t_exp) 0 0 0 0 0 0 0
Para_a(c_Bt_a) 0 0 0 0 0 0 0
Para_b(c_Bt_b) 1 1 1 1 0 0 0
    
Sink_Blade(c_S_B)     0 0 0 0 0 0
Sink_Petiole(c_S_P)    1 0 0 0 0 0
Sink_Internode(c_S_I) 1 0 0 0 0 0
Sink_Female(c_S_Ff)  1 0 0 0 0 0
Sink_Male(c_S_Fm)  0 0 0 0 0 0
Sink_Layer(c_S_L)     0 0 0 0 0 0
Sink_Root(c_S_R)      0 0 0 0 0 0
  
Allom_Internode(c_a_bI) 0 0 0 0 0 0
(c_a_aI)                0 0 0 0 0 0
Allom_Petiole(c_a_bP)    0 0 0 0 0 0
(c_a_aP)                0 0 0 0 0 0
Allom_Thick(c_Th_B)     0 0 0 0 0 0
Female_Density(c_Den_Ff) 0 0 0 0 0 0
Male_Density(c_Den_Fm) 0 0 0 0 0 0
Internode_Dens(c_Den_I) 0 0 0 0 0 0
  
Resist_Blade(c_r_B)      0
Resist_Petiole(c_r_P)     0
Projected_area(c_Sp)     0
Beer_law(c_rp)           1
Beer_law(c_kp)           1
  
Resist_Root(c_r_R)       0
Seed_Biomass(c_Q0)       0
Flow_Biomass(c_dQ0)      0
  
//TargetFlag(C_Tar)  
WeightRoot(Q_R)      0
WeightBlade(Q_B)     1 0 0 0 0 0  
WeightPetiole(Q_P)   1 0 0 0 0 0 
WeightInternode(Q_I) 1 0 0 0 0 0
WeightFemale(Q_Ff)   1 0 0 0 0 0
WeightMale(Q_Fm)     1 0 0 0 0 0
AreaInternode(S_B)   0 0 0 0 0 0
HeightInternode(S_I) 0 0 0 0 0 0
AreaBlade(H_I)       0 0 0 0 0 0





