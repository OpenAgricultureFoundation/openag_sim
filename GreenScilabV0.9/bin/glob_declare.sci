
//
//   globa variables declaration for light and temperature environmental 
//   factor parameter estimation
//

//
//   invariant global variables
//

global      Flag_hydro      Flag_environment        Flag_sumt       Flag_climate E0

global      NumPlt N   N0   maxp      Tr       Nu_Ma   OrganType   u

global      dQ0     Q0     RingOption

global      t_exp   Bt_N    Bt_p  Tu_O S_O N_SI kp_SI

global      a_aI    a_aP        Th_B        Den_Ff      Den_Fm      Den_I       a_bI        a_bP

global      r_B     r_P         r_R     Sp rp kp    

global      env_funame          env_adfuname    env_tgfuname

global      Omega               aux_paras   

global      QSWMAX  QSWMIN      C1          C2


//global variables for fitting control, that is, to choose parameters that
//need to be fit by setting 0 or 1.

global   target_i

global   LoDSample PosLowestGU 

global  t_exp_i     Bt_N_i     Bt_p_i      S_O_i       S_O_j

global  a_bI_i      a_aI_i      a_bP_i      a_aP_i      Th_B_i      Den_Ff_i      Den_Fm_i    Den_I_i

global  r_B_i       r_P_i

global  C_r_R       C_Q0        C_dQ0 C_Sp C_rp C_kp    

global  C_Tar

global  CASample    N_ParaFit  target_set

//for geometrical setting

global  Color_B     Color_I     Color_Ff    Color_Fm 

global  Flag_geo_leaf       Flag_geo_fruit

//
//   Temporary variant global variables only for simulator calculation.
//   That is to say, althought these variables are declared as global,
//   they are used only in simulater routine.
//   Their values are calculated for each simulation of plant growth.
//

global      DL      Nb_BI       MAT_EX      Nb_O       

global      q_O     q_L     QO  

global      B_S     P_H     P_S     I_H    I_S     L_S     Fm_V        Ff_V

global      R_Struct

global      QSW     QTW     E       Q

//
//   variant global variables that might be used by other routines
//   

global      water_sequence      theta_sequence      light_sequence
