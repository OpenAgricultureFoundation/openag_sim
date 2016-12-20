// this script is to read parameters

OrganType = 7;//number of type of organs

// chr ages
Name = mfscanf(fid,"%s");
N = mfscanf(fid,"%d");

// maximum of phy ages
Name = mfscanf(fid,"%s");
maxp = mfscanf(fid,"%d");

// sample size
temp=[];Tr=[];
Name = mfscanf(fid,"%s");temp=[];
temp = mfscanf(fid,"%d %d %d %d %d %d")';
Tr(1,1:maxp) = (temp(1:maxp,1))';

//printf("  fileID =%s\n",FileID);
//printf("  ......\n");

//printf("  filename = %s \n",realFile);
printf("  Plant age = %d \n",N);
printf("  maxp      = %d \n",maxp);


// PARAMATERS FOR TOPOLOGY
temp=[];
for j = 1:5;
  i = 1;
  Name = mfscanf(fid,"%s");
  while 1
    row=zeros(1,7-i);
    for k=1:7-i
       row(1,k) = mfscanf(fid,"%d ");
    end
    temp(i+(j-1)*6,i:6) = row;
    if i==6 then break;end;
    i = i+1;
  end;
end;


// Microstate paprameter
Nu_O = zeros(4,maxp,6);// 1 leaf, 2 female flower, 3 male flower, 4 branch
Nu_I= zeros(maxp,6);
for i = 1:maxp;
  // Axillary Number
  Nu_O(4,i,i:6) = temp(i,i:6);
  // Leaf number
  Nu_O(1,i,i:6) = temp(i+6,i:6);
  // Male Flower number
  Nu_O(2,i,i:6) = temp(i+2*6,i:6);
  // Female flower number
  Nu_O(3,i,i:6) = temp(i+3*6,i:6);
  // Internode number
  Nu_I(i,i:6) = temp(i+4*6,i:6);
end;

//Macrostate number
temp=[];Nu_Ma=[];
Name = mfscanf(fid,"%s");
temp(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';
Nu_Ma(1:maxp,1) = temp(1:maxp,1);

// jump in physiological age for ending structures
temp=[];st_j=[];
Name = mfscanf(fid,"%s");
temp(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';
st_j(1:maxp,1) = temp(1:maxp,1);

// Reiteration Control
temp=[];b_o=[];br_a=[];re_a=[];
for i = 1:3;
  Name = mfscanf(fid,"%s ");
  temp(1:6,i) = mfscanf(fid,"%d %d %d %d %d %d")';
end;

// reiteration branching order
b_o(1:maxp,1) = temp(1:maxp,1);
// control phy_age/ch_age on branches ; 0 = no control = 1 top effect
br_a(1:maxp,1) = temp(1:maxp,2);
// control phy_age/ch_age on reiteration ; 1 = no control = 0 top effect
re_a(1:maxp,1) = temp(1:maxp,3);

// Reiteration Control
temp=[];rs_A=[];rs_B=[];rt_a=[];
for i = 1:3;
  Name = mfscanf(fid,"%s ");
  ttt = mfscanf(fid,"%f %f %f %f %f %f")';
  temp=[temp ttt];
end;

//rest before functioning, rs_n=A+B(N-k+1), k being position from the bottom
rs_A(1:6,1) = temp(1:6,1);
rs_B(1:6,1) = temp(1:6,2);
// rythm ratio
rt_a(1:6,1) = temp(1:6,3);

temp=[];
for i = 1:4;
  Name = mfscanf(fid,"%s");
  temp(1:6,i) =mfscanf(fid,"%f %f %f %f %f %f")';
end;

// stochastic Control
//branching probability
a = temp(1:maxp+1,1);
//%growth probability of macrostates
b = temp(1:maxp+1,2);
// %growth probability of microstates
bu = temp(1:maxp+1,3);
// %growth probability of macrostates
c = temp(1:maxp+1,4);

Name = mfscanf(fid,"%s");//read a line
Name = mfscanf(fid,"%s");//read a line

//function time   existence area Tu_O(:,1) = span;Tu_O(:,2) <---> Tu_O(:,3)
Tu_O = zeros(OrganType+1,5,maxp);temp=[];
for J = 1:6;
  Name = mfscanf(fid,"%s");  //read a comment line
  for i = 1:5;
    Name = mfscanf(fid,"%s");  //read a comment line
    for k=1:OrganType+1
    		temp(k,i,J) = mfscanf(fid,"%f");
    end;
  end;
end;
Tu_O(1:OrganType+1,1:5,1:maxp) = temp(1:OrganType+1,1:5,1:maxp);
//////////////////////// below ?????????????????????????   /////////////////
Tu_O(6,:,:) = Tu_O(1,:,:);

// Parameters FOR ORGANS EXPANSION LAWS independant of phy age
t_exp = zeros(OrganType,1);Bt_N = zeros(OrganType,1);Bt_p = zeros(OrganType,1);temp=[];
for i = 1:3;
  Name = mfscanf(fid,"%s");
  for k=1:OrganType
   	temp(k,i) = mfscanf(fid,"%f");
  	end;
end;

t_exp(1:OrganType,1) = temp(1:OrganType,1);
Bt_N(1:OrganType,1) = temp(1:OrganType,2);
Bt_p(1:OrganType,1) = temp(1:OrganType,3);

//Sink of organs
temp=[];S_O=[];
for i = 1:OrganType;
  Name = mfscanf(fid,"%s");
  temp(i,1:6) = mfscanf(fid,"%f %f %f %f %f %f");
end;
S_O(1:OrganType,1:maxp) = temp(1:OrganType,1:maxp);

temp=[];a_bI=[];a_aI=[];a_bP=[];a_aP=[];Th_B=[];Den_Ff=[];Den_Fm=[];Den_I=[];r_B=[];r_P=[];
for i = 1:10;
  Name = mfscanf(fid,"%s");
  temp(1:6,i) = mfscanf(fid,"%f %f %f %f %f %f")';
end;
// *************************************
// * allometry parameters*
// *************************************
a_bI(1:maxp,1) = temp(1:maxp,1);
a_aI(1:maxp,1) = temp(1:maxp,2);
a_bP(1:maxp,1) = temp(1:maxp,3);
a_aP(1:maxp,1) = temp(1:maxp,4);
a_bB(1:maxp,1) = temp(1:maxp,5);
a_aB(1:maxp,1) = temp(1:maxp,6);
//Leaf thickness
Th_B(1:maxp,1) = temp(1:maxp,7);
//fruit density
Den_Ff(1:maxp,1) = temp(1:maxp,8);
//male flower density
Den_Fm(1:maxp,1) = temp(1:maxp,9);
//internode density
Den_I(1:maxp,1) = temp(1:maxp,10);

Name = mfscanf(fid, "%s");
Flag_field = mfscanf(fid, "%d");

//hydraulic parameters---resistance
Name = mfscanf(fid, "%s");
r_B = mfscanf(fid, "%f");
Name = mfscanf(fid, "%s");
r_P = mfscanf(fid, "%f");
Name = mfscanf(fid, "%s");
r_R = mfscanf(fid, "%f");
Name = mfscanf(fid, "%s");
Sp = mfscanf(fid, "%f");
Name = mfscanf(fid, "%s");
rp = mfscanf(fid, "%f");
Name = mfscanf(fid, "%s");
kp = mfscanf(fid, "%f");

temp=[];
for i = 1:4;
  Name = mfscanf(fid,"%s");
  temp(i,1) = mfscanf(fid,"%f");
end;
//seed biomass
Q0 = temp(1,1);
dQ0 = temp(2,1);
RingOption = temp(3,1);// 0 if layer is proportional to number of leaves above, 1 if section of layer is constant during a cycle
coff_L = temp(4,1);

temp=[];
for i=1:2;
  Name = mfscanf(fid, "%s");
  temp(i,1) = mfscanf(fid,"%f");
end;
N_SI = temp(1,1);
kp_SI = temp(2,1);

//pruning age of branche if metamorphosis
sum_br = 0;
for i = 1:maxp;
  sum_br = sum_br+br_a(i,1);
end;

//T_Pr is prinning age of a substructure. Only if both its terminal and lateral structure are funished
T_Pr = zeros(1,maxp);
for p = maxp:-1:1;
  age = 0;
  for p_b = p:maxp;   // rename b to p_b  QR 2006 04 20
    if mtlb_logic(p,">",p_b) then //normal branch
     if bool2s(mtlb_logic(Nu_I(p,p_b),">",0))&bool2s(Nu_O(4,p,p_b)>0) then
       age1 = T_Pr(p_b);
       age = max(age,age1);
     end;
    else
      if bool2s(mtlb_logic(Nu_I(p,p_b),">",0))&bool2s(Nu_O(4,p,p_b)>0) then
        age1 = T_Pr(p_b)+b_o(p_b,1);
        age = max(age,age1);
      end;
    end;
  end;
  age2 = 0;
  if bool2s(st_j(p)>p)&bool2s(st_j(p)<=maxp) then
    st_b = st_j(p);   // rename b to st_b  QR 2006 04 20
    age2 = T_Pr(st_b);
  end;
  age = max(age,age2);
  T_Pr = mtlb_i(T_Pr,1,Nu_Ma(p)+age);
end;

//flagr is to judge whether the substructure is infloresence. it can be reiteration
flagr = zeros(1,maxp);
for p = 1:maxp;
  if bool2s(re_a(p)==1)&bool2s((Nu_O(4,p,p)*Nu_I(p,p))>0) then
    flagr(p) = 1;
  end;
  if br_a(p)==1 then
    for p_b = p+1:maxp;   // rename b to p_b  QR 2006 04 20
      if (Nu_O(4,p,p_b)*Nu_I(p,p_b))>0 then
        flagr(p_b) = 1;
      end;
    end;
  end;
end;

u=sum(Nu_I,2);
//NM = zeros(1,maxp);
//NM = Nu_Ma';
//for p = maxp:-1:1;
//  if bool2s(st_j(p)>p)&bool2s(st_j(p)<=maxp) then
//    b = st_j(p);
//    NM = mtlb_i(NM,1,NM(p)+NM(b));
//  end;
//end;


NM = zeros(1,maxp);//maximum number of G.U. in an axis p
NM = Nu_Ma';
for p = maxp:-1:1;
  if (st_j(p)>p) & (st_j(p) <=maxp) then
    st_b = st_j(p);  // rename b to st_b  QR 2006 04 20
    NM(p)=NM(p)+NM(st_b);
  end;
end;      


%v0 = b_o(:);nr = mtlb_a(max(%v0,firstnonsingleton(%v0)),1);


E = zeros(1,N);
q_O = zeros(OrganType,maxp,N,N);
q_L = zeros(maxp,N,N,N);

Q = zeros(N+1,1);
// first allocation of biomass from the seed
Q(1,1) = Q0*(1-dQ0);

QO = zeros(OrganType,maxp,N+1);

R_Struct = zeros(1,N);
I_H = [];I_S = [];B_S = [];P_H = [];P_S = [];L_S = zeros(maxp,N,N,N);Ff_V = zeros(maxp,N,N);Fm_V = zeros(maxp,N,N);


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////                           Read Geometrical Parameters                                     //////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Name =mfscanf(fid,"%s");
Smb_I = "100";

Name =mfscanf(fid,"%s");
Smb_L =mfscanf(fid,"%s");

Name =mfscanf(fid,"%s");
Smb_Ff =mfscanf(fid,"%s");

Name =mfscanf(fid,"%s");
Smb_Fm =mfscanf(fid,"%s");

Name =mfscanf(fid,"%s");//color of leaf
temp=[];
for i = 1:2;
  temp=mfscanf(fid,"%f %f %f");
  Color_B(i,1:3) = matrix(temp,1,3);
end;

Name =mfscanf(fid,"%s");//color of internode
temp=[];
for i = 1:2;
  temp =mfscanf(fid,"%f %f %f");
  Color_I(i,1:3) =matrix(temp,1,3);
end;


Name =mfscanf(fid,"%s");//color of female flower
temp=[];
for i = 1:2;
  temp =mfscanf(fid,"%f %f %f");
  Color_Ff(i,1:3) = matrix(temp,1,3);
end;

Name =mfscanf(fid,"%s");//color of male flower
temp=[];
for i = 1:2;
  temp =mfscanf(fid,"%f %f %f");
  Color_Fm(i,1:3) = matrix(temp,1,3);
end;

//color of skeleton line
Name =mfscanf(fid,"%s");temp=[];
for i = 1:6;
  temp =mfscanf(fid,"%f %f %f");
  Color_P(i,1:3) = matrix(temp,1,3);
end;

temp=[];
for j = 1:4;
  i = 1;
  Name =mfscanf(fid,"%s ");
  while 1
  		for k=1:7-i
    			temp(i+(j-1)*6,i+k-1) = mfscanf(fid,"%f ");
    		end;
    if i==6 then break;end;
    i = i+1;
  end;
end;


// axxilary organ angles
Ang_O = zeros(4,maxp,6);// 1 leaf, 2 female flower, 3 male flower, 4 branch
for i = 1:maxp;
  Ang_O(3,i,i:6) = (temp(i,i:6)*%pi)/180;
  Ang_O(2,i,i:6) = (temp(i+6,i:6)*%pi)/180;
  Ang_O(1,i,i:6) = (temp(i+2*6,i:6)*%pi)/180;
  Ang_O(4,i,i:6) = (temp(i+3*6,i:6)*%pi)/180;
end;



Name =mfscanf(fid,"%s ");
temp=mfscanf(fid,"%f %f %f %f %f %f");
Ang_Ph= temp(1:maxp)*%pi/180;


//%%%%%%%%%%%%%%%%%%%%%parameters about branch bending%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp=[];InitNum=[];
for i = 1:8;
  Name =mfscanf(fid,"%s ");
  ttt =mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;

Ey(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),1);
fp(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),2);
End_Ang(mtlb_imp(1,maxp),1) = (temp(mtlb_imp(1,maxp),3)*%pi)/180;
End_N(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),4);
InitMin(mtlb_imp(1,maxp),1) = (temp(mtlb_imp(1,maxp),5)*%pi)/180;
InitMax(mtlb_imp(1,maxp),1) = (temp(mtlb_imp(1,maxp),6)*%pi)/180;
InitNum(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),7);
Flag_Bending_by_node = temp(mtlb_imp(1,maxp),8);
// openning
temp=[];
for i = 1:2;
  Name =mfscanf(fid,"%s ");
  ttt=mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;
wb(mtlb_imp(1,maxp),1) = (temp(mtlb_imp(1,maxp),1)*%pi)/180;
wbn(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),2);
// organ bending
temp=[];
for i = 1:4;
  Name =mfscanf(fid,"%s ");
  ttt =mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;

Flag_organ_bending(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),1);
Theta_O = zeros(4,real(maxp));
Theta_O(4,mtlb_imp(1,maxp)) = (matrix(temp(mtlb_imp(1,maxp),2),1,maxp)*%pi)/180;//branch
Theta_O(1,mtlb_imp(1,maxp)) = (matrix(temp(mtlb_imp(1,maxp),3),1,maxp)*%pi)/180;//leaf
Theta_O(2,mtlb_imp(1,maxp)) = (matrix(temp(mtlb_imp(1,maxp),4),1,maxp)*%pi)/180;//female flower
Theta_O(3,mtlb_imp(1,maxp)) = Theta_O(2,mtlb_imp(1,maxp));//male flower

// direction control
temp=[];
for i = 1:2;
  Name =mfscanf(fid,"%s ");
  ttt =mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;

Flag_plagiotropic(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),1);
Leaf_direction(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),2);
// Prunning control
temp=[];
for i = 1:4;
  Name =mfscanf(fid,"%s ");
  ttt =mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;

Flag_pruning(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),1);
Pruning_delay(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),2);
Flag_leaf(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),3);
Flag_fruit(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),4);

//size of organs
temp=[];
for i = 1:6;
  Name =mfscanf(fid,"%s ");
  ttt =mfscanf(fid,"%f %f %f %f %f %f");
  temp=[temp ttt'];
end;

VI(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),1);
VB(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),2);
VF(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),3);
CI(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),4);
CB(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),5);
CF(mtlb_imp(1,maxp),1) = temp(mtlb_imp(1,maxp),6);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////                                Environment condition                                 ////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Name = mfscanf(fid,"%s ");

Name = mfscanf(fid,"%s ");

Name = mfscanf(fid,"%s ");

Flag_climate = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s ");

E_K1 = mfscanf(fid,"%f");

Name = mfscanf(fid,"%s ");
E_K2 = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
C1 = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
C2 = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
QSW0 = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
QSWMAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
QSWMIN = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
QSW_MAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
QSW_MIN = mfscanf(fid,"%f");

Name = mfscanf(fid,"%s ");
Name = mfscanf(fid,"%s ");
Flag_temperature = mfscanf(fid,"%d");
Name = mfscanf(fid,"%s ");
Flag_sumt = mfscanf(fid,"%d");
Name = mfscanf(fid,"%s ");
E_ALPHA = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
E_BETA = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
KSUMT = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
THETA_BASE = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
THETAMAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
THETAMIN = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
THETA_MAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
THETA_MIN = mfscanf(fid,"%f");

Name = mfscanf(fid,"%s ");
Name = mfscanf(fid,"%s ");
Flag_light = mfscanf(fid,"%d");
Name = mfscanf(fid,"%s ");
E_A = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
E_B = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
LIGHTMAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
LIGHTMIN = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
LIGHT_MAX = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
LIGHT_MIN = mfscanf(fid,"%f");
Name = mfscanf(fid,"%s ");
E0 = mfscanf(fid,"%f");

Omega = [E_K1,E_K2,E_A,E_B,E_ALPHA,E_BETA];
aux_paras = [QSW_MIN,QSW_MAX,THETA_MIN,THETA_MAX,LIGHT_MIN,LIGHT_MAX,E0];
env_range = [QSWMIN,QSWMAX,THETAMIN,THETAMAX,LIGHTMIN,LIGHTMAX];

QTW=zeros (1,N+1);                 //total water supply
QSW=zeros (1,N+1);                //water in soil
water_sequence =zeros(1,N);                  //rain fall height
if Flag_climate
    QSW(1,1)=QSW0;
    QTW(1,1)=QSW(1,1);   //water for beginning,can't less than Qmin
end
E=E0*ones(1,N);

Flag_environment = [Flag_climate Flag_temperature Flag_light];


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////                                Option of output                                 ////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// this script is to read option file

Name = mfscanf(fid,"%s");
Name = mfscanf(fid,"%s");
Flag_topo_disp(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_topo_disp_s = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_topo_disp_l(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_topo_disp_a(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Name = mfscanf(fid,"%s");
Flag_hydro = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_layer_disp = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_demand_biomass = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_biomass_num(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_biomass_fig = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_bioprod_fig = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_biomass_fig_a = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_disp_LAI = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_biomass_fig_phy(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_size_fig_phy(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Name = mfscanf(fid,"%s");
Flag_geometry = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_geo_full = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_geo_3D(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_geo_leaf(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_geo_fruit(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_geo_light = mfscanf(fid,"%d");

Name = mfscanf(fid,"%s");
Flag_geo_skeleton(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

Name = mfscanf(fid,"%s");
Flag_geo_lig(1:6,1) = mfscanf(fid,"%d %d %d %d %d %d")';

//flag to tell whether the lig file is in windows(1) or unix(0) format.
Name = mfscanf(fid,"%s");
Flag_windows = mfscanf(fid,"%d");

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





