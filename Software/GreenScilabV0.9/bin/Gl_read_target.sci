// this script is to read target file of fitting, i should add more target later

disp('Reading target file...')

//read the (initial) parameters
//exec(GL_SYS_DIR+'bin'+SEPARATOR+'gl_read.sci');

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
//  READ CONTROL ON PARAMETERS
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
// Read fitting control file to decide which parameters need to be fit. filename is FileID_con.m
//1 yes and 0 no

Name = mfscanf(fid,"%s");
Name = mfscanf(fid,"%s");

// Parameters FOR ORGANS EXPANSION LAWS independant of phy age
C_t_exp=zeros(OrganType,1);C_Bt_N=zeros(OrganType,1);C_Bt_p=zeros(OrganType,1);
temp=zeros(OrganType,3);

for i = 1:3
    Name = mfscanf(fid,'%s');
    for k=1:OrganType
        temp(k,i) = mfscanf(fid,"%f");
    end;    
end
C_t_exp(1:OrganType,1)=temp(1:OrganType,1);
C_Bt_N(1:OrganType,1)=temp(1:OrganType,2);
C_Bt_p(1:OrganType,1)=temp(1:OrganType,3);

//Sink of organs
C_S_O=zeros(OrganType,maxp);
for i = 1:OrganType
    Name = mfscanf(fid,'%s');
    temp(i,1:6) = mfscanf(fid,"%f %f %f %f %f %f");
end
C_S_O(1:OrganType,1:maxp) = temp(1:OrganType,1:maxp);

// *************************************
// * allometry parameters*
// *************************************
temp=zeros(6,8);
for i = 1:8
    Name = mfscanf(fid,'%s');
    for j=1:6
    	temp(j,i) = mfscanf(fid,"%f");
    	end
end
C_a_bI(1:maxp,1) = temp(1:maxp,1);
C_a_aI(1:maxp,1) = temp(1:maxp,2);
C_a_bP(1:maxp,1) = temp(1:maxp,3);
C_a_aP(1:maxp,1) = temp(1:maxp,4);
//Leaf thickness
C_Th_B(1:maxp,1) = temp(1:maxp,5);
//fruit density
C_Den_Ff(1:maxp,1) = temp(1:maxp,6);
//male flower density
C_Den_Fm(1:maxp,1) = temp(1:maxp,7);
//internode density
C_Den_I(1:maxp,1) = temp(1:maxp,8);

for i = 1:8
    Name = mfscanf(fid,'%s');
    temp(i,1) = mfscanf(fid,'%d');
end
C_r_B = temp(1,1);                         
C_r_P = temp(2,1);
C_Sp = temp(3,1);                         
C_rp = temp(4,1);
C_kp = temp(5,1);
C_r_R = temp(6,1);
//seed biomass
C_Q0 = temp(7,1);
C_dQ0 = temp(8,1);

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
//  find indice that are 1s
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

N_ParaFit=0;//number of parameters need to be fit
x_Para=[]; //vector of initial parameters

//[t_exp_i,t_exp_j]=find(C_t_exp); N_ParaFit=N_ParaFit+size(t_exp_i,1);
[t_exp_i,t_exp_j]=find(C_t_exp); N_ParaFit=N_ParaFit+size(t_exp_i,2);
for a=1:size(t_exp_i,2)
    x_Para=[x_Para t_exp(t_exp_i(a),t_exp_j(a))];
end

[Bt_N_i,Bt_N_j]=find(C_Bt_N); N_ParaFit=N_ParaFit+size(Bt_N_i,2);  // 1
for a=1:size(Bt_N_i,2)   //  1
    x_Para=[x_Para Bt_N(Bt_N_i(a),Bt_N_j(a))];
end

[Bt_p_i,Bt_p_j]=find(C_Bt_p); N_ParaFit=N_ParaFit+size(Bt_p_i,2);   //  1
for a=1:size(Bt_p_i,2)  // 1
    x_Para=[x_Para Bt_p(Bt_p_i(a),Bt_p_j(a))];
end

[S_O_i,S_O_j]=find(C_S_O);  N_ParaFit=N_ParaFit+size(S_O_i,2);
for a=1:size(S_O_i,2)
    x_Para=[x_Para S_O(S_O_i(a),S_O_j(a))];
end

//resistance, they are really hidden parameters
//[r_B_i,r_B_j]=find(C_r_B); N_ParaFit=N_ParaFit+size(r_B_i,1);
//for a=1:size(r_B_i,1)
//    x_Para=[x_Para r_B(r_B_i(a),r_B_j(a))];
//end

//[r_P_i,r_P_j]=find(C_r_P); N_ParaFit=N_ParaFit+size(r_P_i,1);
//for a=1:size(r_P_i,1)
//    x_Para=[x_Para r_P(r_P_i(a),r_P_j(a))];//can not distinguish for different phy-age
//end

if C_r_B==1 then
    x_Para=[x_Para r_B];
    N_ParaFit=N_ParaFit+1;
end
if C_r_P==1 then
    x_Para=[x_Para r_P];
    N_ParaFit=N_ParaFit+1;
end
if C_Sp==1 then
    x_Para=[x_Para Sp];
    N_ParaFit=N_ParaFit+1;
end
if C_rp==1 then
    x_Para=[x_Para rp];
    N_ParaFit=N_ParaFit+1;
end
if C_kp==1 then
    x_Para=[x_Para kp];
    N_ParaFit=N_ParaFit+1;
end
if C_Q0==1 then
    x_Para=[x_Para Q0];
    N_ParaFit=N_ParaFit+1;
end
if C_dQ0 == 1 then
    x_Para=[x_Para dQ0];
    N_ParaFit=N_ParaFit+1;
end

//taget data to fit
Name=mfscanf(fid,'%s');
Name=mfscanf(fid,'%s');
C_Q_B=mfscanf(fid,'%d');

TargetType=8;//1-Q_B,2-Q_P,3-Q_I,4-Q_Ff,5-Q_Fm,6-S_B,7-S_I,8-H_I
C_Tar=zeros(TargetType,6);
for i=1:TargetType
  Name=mfscanf(fid,'%s');
  C_Tar(i,:)=mfscanf(fid,"%d %d %d %d %d %d");
end

///%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Read target data
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Name=mfscanf(fid,'%s');Name=mfscanf(fid,'%s');
NumPlt=mfscanf(fid,'%d');

CASample=zeros(1,NumPlt);
PASample=zeros(1,NumPlt);
LoDSample=zeros(NumPlt,maxp);

target_set=[];
PosLowestGU=zeros(NumPlt ,maxp);//the lowest position of GU in target data

for h=1:NumPlt // for each plant
  Name=mfscanf(fid,'%s');
  CASample(h)=mfscanf(fid,'%d');
  PASample(h)=mfscanf(fid,'%d');
  for p=1:PASample(h)
    LoDSample(p,h)=mfscanf(fid,'%d');
  end
  
  Name=mfscanf(fid,'%s');//root
  tempQR=mfscanf(fid,'%f');
  
  Name=mfscanf(fid,'%s');//info
  InfoAxis(1:4,1) = mfscanf(fid,"%d %d %d %d")';
     
    FitType=length(find(C_Tar(:,InfoAxis(2))));
    
    PA_axis=InfoAxis(2);
    
    PosLowestGU(h,p)=InfoAxis(4);//suppose all  axis of the same phave the same value
    
    //NumGU=min(Nu_Ma(InfoAxis(2)),InfoAxis(3));
    NumGU=min(Nu_Ma(InfoAxis(2)),InfoAxis(3))-PosLowestGU(h,p)+1;;
            
    select LoDSample(InfoAxis(2),h)
    
    case 0//detailed data
      //AxisData=zeros(FitType,min(Nu_Ma(InfoAxis(2)),InfoAxis(3)));
      AxisData=[];
      Name=mfscanf(fid,'%s');
      Name=mfscanf(fid,'%s'); //  IDSub=mfscanf(fid,'%d');
      while Name=='GU'
        GU = mfscanf(fid,'%d');
        Nb_Sub=mfscanf(fid,'%d');
        IDSub=mfscanf(fid,'%d');;

        tempData=mfscanf(fid,'%f %f %f %f %f %f %f %f')';
        AxisData=[AxisData tempData(find(C_Tar(:,1)))];
        Name=mfscanf(fid,'%s');//read key word
      end
      //the target data, in the order PA=1:maxp, Orgtype=1:TargetType, GU=1:max. It is average of organs of the same CA and PA. To be improved
      target_set=[target_set matrix(AxisData',1,-1)];
      
    case 1//compartment data, for those above LowestPos
      for id=1:5//five types of organs
        Name=mfscanf(fid,'%s');
        temp=mfscanf(fid,'%f');
        if C_Tar(id,PA_axis)==1 then
          target_set=[target_set temp];
        end
      end
    end
    
end

target_i=find(target_set==-1); //find the indices of missing data


mclose(fid);



