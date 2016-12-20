
currenttime=timer();

StrFileName=GL_SYS_DIR+'str'+SEPARATOR+FileID+'.str';

StrInf=GL_SYS_DIR+'str'+SEPARATOR+'inftemporary.str';

StrBlock=GL_SYS_DIR+'str'+SEPARATOR+'blocktemporary.str';

[fidInf, err] = mopen(StrInf, 'wb');
[fidBl, %v] = mopen(StrBlock, 'wb');

nr=max(b_o(:))+1;

I_D=sqrt(I_S/%pi)*2; //get diamater of stem according to section area

V=[];ID=[];Age=[];gs=[];mr=[];O=[];Sz=[];

printf('Processing geometrical structure with physiological age: ');
NumStr=0;//number of structures

if Flag_geo_full==0 then //compute only plant geometry at age N
    i0=N;
else
    i0=1;
end

StateO=Gl_StateOccupy(Tu_O);

for p = maxp:-1:1; 	//for substructure of each phy_age     
    printf(' %4d ',p);      
    for i =i0:N;  		//for substructure p of each chr_age        
        for g=1:InitNum(p); 	//for each initial angle        
            if InitNum(p)>1 then  	//get the absolute initial angle          
                InitAngle=InitMin(p)+(g-1)*(InitMax(p)-InitMin(p))/(InitNum(p)-1);            
            else  				// if only one initial gangle, take the min one          
                InitAngle=InitMin(p);            
            end      
            L0=min(i,Nu_Ma(p));	//number of actural G.U. in axis, no more than Nu_Ma(p)
            L0=L0*u(p);h0=L0;	   //bending according to number of microstate, and each microstate has a value
            theta=Draw_bending(p,L0,h0,Ey,InitAngle,fp,End_Ang(p),End_N(p)*u(p),InitNum(p)); //angle of each metamer to z axis from bottom to top
            if p==1 & Nu_O(4,1,1)==0 then //main axis and no reiteration
                j1=i;j2=i;           //for main plant we need only one at that given age i. This can save time.
            else
                j1=1;j2=i;          //for branch, at given plant age i, branches with age 1 to i-1 may exist. for reiteration, we need the main structure with age i
            end      
            
            for j=j1:j2; 			//for each possible chr_age of axis. When p is substructure inside another structure, at given plant chr_age i, the substructure can have chr_age ranging 1-(i-1))
                
                for m=1:nr; 		//for each reiteration order
                    if flagr(p)==0	then //case of branch,no need to cut it, this can save time
                        k0=j;
                    else			//case of infloresence, we need intermediate part from top of the structure, so I calculate each cut from top 1 to j for substructure with age j
                        k0=1;       
                    end;
                    for k=k0:j;                       
                        NO=0;			//number of organs(internode, leaf, or substructure)
                        mr=[];   
                        
                        if j>Nu_Ma(p,1) then		//chr_age>Nu_Ma(p,1), terminal structure may exit
                            b=st_j(p);   			//defined jump state                       
                            if b>=p & b<=maxp then   //if it is in reasonable scope
                                age=[b min(k,j-Nu_Ma(p,1)) min(k,j-Nu_Ma(p,1)) i];  //phy_age,chr_age,chr_age of terminal structure and chr_age of main structure
                                //w3=Nu_Ma(p)*Ang_Ph(p); 	 phylotaxy is related with number of G.U.(maybe internode better?) previously                                                                  
                                w3=0; //let terminal structure stay in same plane with axis
                                Vz=[cos(w3) -sin(w3) 0;sin(w3) cos(w3) 0; 0 0 1];	 //z-axis rotation matrix, counterclockwise.                                                             %Vz=[cos(w3) sin(w3) 0;-sin(w3) cos(w3) 0; 0 0 1];
                                ap=theta(Nu_Ma(p)*u(p)); //terminal angle of axis           
                                Vy=[cos(ap) 0 sin(ap);0 1 0;-sin(ap) 0 cos(ap)];    //y-axis rotation matrix, counterclockwise.                                                            
                                VO=Vy*Vz; 					 //compound matrix. sequence of multiply can't be changed
                                [VO,g_O]=Draw_AngleShift(VO,InitMax(b),InitMin(b),InitNum(b));//choose a nearest angle ID g_O
                               
                                if p<b then                  //normal terminal substructure            
                                    m_O=m;                               
                                else                     //reiteration          
                                    if m<=b_o(p) then                                 
                                        m_O=m+1;           //eiteration id of less reiterated structure, otherwise reiteration can't be stopped
                                    end;                               
                                end;
                                sz_O=[0 0];					 //no size information for substructure
                                o=[0 0 0];					 //terminal structure is add before the main axis, so its position is 0.
                                
                                [NO,ID,Age,gs,mr,V,O,Sz]=Draw_GetOrgan(NO,ID,Age,gs,mr,V,O,Sz,4,age,g_O,m_O,VO,o,sz_O); //write information into matrices and vectors                                                                                    
                            end;                         //end for terminal substructure
                        end;   
                        
                        Posi=1;                        //increasing number of metamer in axis
                        Sumi=sum(max(1,k-Nu_Ma(p,1)):k)*sum(Nu_I(p,:));   //total number of metamer in axis
                        if j>Nu_Ma(p,1) then               //age1 is chr_age of top G.U. in axis, 1 if axis is young, otherwise j-Nu_Ma(p,1)+1;
                            age1=j-Nu_Ma(p,1)+1;
                        else
                            age1=1;
                        end ;                 
                        for kk=age1:k;                  //for each G.U. in axis from top
                            Ir=I_D(p,kk,j,i);           //diameter of G.U
                            age=[p kk j i];             // phy_age and chr_age of G.U., chr_age of substructure and plant
                            
                            if Flag_Bending_by_node(p)==0 then			//save by G.U.                       
                                sz=[u(p)*I_H(p,kk,i) I_D(p,kk,j,i)];//length and diameter of G.U.                                
                                ap=theta((j-kk)*u(p)+1);            //angle to z-axis of G.U. *number of G.U. below current one is j-kk
                                if k<j then //if k<Nu_Ma(p) if the branch's length is smaller than its full length
                                    //ap=ap-theta( (i-k) *u(p));%changed 2004.5.26
                                    ap=ap-theta( (j-k) *u(p));
                                end;                        
                                VI=[sin(ap) 0 cos(ap) ;0 1 0;cos(ap) 0 -sin(ap)];  //3 direction of G.U., not rotation matrix
                                o=[0 0 0];                        
                                [NO,ID,Age,gs,mr,V,O,Sz]=Draw_GetOrgan(NO,ID,Age,gs,mr,V,O,Sz,1,age,g,m,VI,o,sz);    
                                for axis=1:3;													//for x,y,z
                                    O(1:NO-1,axis)=O(1:NO-1,axis)+VI(axis,1)*u(p)*I_H(p,kk,i);     //the new G.U. is in the bottom, shift all previous organs to top position of G.U.                           
                                end;                                                   
                            end ;                                 
                            
                            Numi=0;						//number of microstate in G.U. kk
                            for b=p:6;					//for each kind of possible microstate
      ////////////////////  for b=p:9;   original
                                for ii=1:Nu_I(p,b);     //for each microstates on kind b 
                                    Posi=Posi+1;        //the total number of metamer in axis increase
                                    Numi=Numi+1;		//the number of metamer in G.U. increase
                                    
                                    if Flag_Bending_by_node(p)==1 then		//save by internode
                                        sz=[I_H(p,kk,i) I_D(p,kk,j,i)];	//length and diameter of internode
                                        //ap=theta(L0-Posi+2)-theta(L0-(k-age1)*u(p));%angle to z-axis of internode                           
                                        ap=theta(L0-Posi+2);
                                        //ap=theta((j-kk)*u(p)+1);            //angle to z-axis of G.U. *number of G.U. below current one is j-kk
                                        if k<i then
                                            ap=ap-theta(( min(i,Nu_Ma(p))-(k-age1) )*u(p));//set first angle to z-axis of G.U. to 0.
                                        end ;                       
                                        ap=ap+InitAngle;
                                        VI=[sin(ap) 0 cos(ap) ;0 1 0;cos(ap) 0 -sin(ap)];  //3 direction of internode
                                        o=[0 0 0];                              
                                        [NO,ID,Age,gs,mr,V,O,Sz]=Draw_GetOrgan(NO,ID,Age,gs,mr,V,O,Sz,1,age,g,m,VI,o,sz);                                                  
                                        for axis=1:3;												//for x,y,z                                 
                                            O(1:NO-1,axis)=O(1:NO-1,axis)+VI(axis,1)*I_H(p,kk,i);     //the new G.U. is in the bottom, shift all previous organs to top position of G.U.                                 
                                        end ;                                                                                      
                                    end;
                                    
                                    for OrgId=1:4;                                //for each kind of axillary organs;
                                        select OrgId                             //1 leaf, 2 female flower, 3 male flower, 4 substructure
                                        case 1 	then								 // 1 leaf
                                            id_O=10;Age_O=[p kk j i];m_O=m;g_O=g;//id, age
                                            sz_O=[B_S(p,kk,i) B_S(p,kk,i)];		 //size
                                            if Leaf_direction(p)==0  then            //in smb file, leaf primary direction is x-axis, with secondary direction in xy-plane(y-axis)
                                                V0=[0 0 1;0 1 0;1 0 0];			 //rotate to z-axis, let primary direction z-axis, with secondary direction y-axis
                                            else            
                                                V0=[0 1 0;0 0 1;1 0 0];			 //compound of y-axis rotation[0 0 1;0 1 0;1 0 0] and z-axis rotation[0 -1 0;1 0 0;0 0 1].primary direction z-axis, with secondary direction x-axis, %V0=[1 0 0;0 0 1;0 1 0];                                    
                                            end ;                                                    
                                            flag=( Flag_leaf(p) & (kk<Tu_O(1,1,p)+Pruning_delay(p)+1 | Flag_pruning(p)~=1) );//if leaf deisplayed and not prunned. no consideration on appearence and disapperance time because I suppose leaf always exist
                                            flag=(flag & StateO(1,j-kk+1,p));       //organ occupied state
                                        case 2 then //2 female flower
                                            id_O=20;Age_O=[p kk-1 j i];m_O=m;g_O=g;flag=0;//id, age
                                            if kk-1>0 then
                                                sz_O=[Ff_V(p,kk-1,i-1) Ff_V(p,kk-1,i-1)];//size                                                                            
                                                V0=[0 0 1;0 1 0;1 0 0]; 
                                                //V0=[0 1 0;0 0 1;1 0 0];
                                                flag=( Flag_fruit(p)==1 );
                                                flag=( flag & (kk-1>0) & (kk-1<Tu_O(4,1,p)+Pruning_delay(p)+1 | Flag_pruning(p)~=1) );
                                                flag=flag & StateO(2,j-kk+1+m-1,p);       //organ occupied state                                                
                                            end; 
                                        case 3 then //3 male flower, nothing
                                            id_O=30;Age_O=[p kk-1 j i];m_O=m;g_O=g;//id, age
                                            if kk-1>0 then
                                                sz_O=[Fm_V(p,kk-1,i-1) Fm_V(p,kk-1,i-1)];//size
                                            end ;                                
                                            V0=[0 0 1;0 1 0;1 0 0]; 
                                            //V0=[0 1 0;0 0 1;1 0 0];
                                            flag=( Flag_fruit(p)==1 );
                                            flag=( flag & (kk-1>0) & (kk-1<Tu_O(4,1,p)+Pruning_delay(p)+1 | Flag_pruning(p)~=1) );                                 
                                            flag=flag & StateO(3,j-kk+1,p);       //organ occupied state
                                        case 4 then //4 branch
                                            if b<=maxp	then												//if branch exist
                                                id_O=4;
                                                if (br_a(p)==0 & b>p) | (re_a(p)==0 & b==p) then //if branch structure  
                                                    //Age_O=[b kk-1 kk-1 i];						  // age of branch
                                                    rs_n=round(rs_A(b,1)+rs_B(b,1)*(kk-max(j-Nu_Ma(p,1)+1,1)));
                                                    kkb=floor((kk-1-rs_n)*rt_a(b,1));//the ch_age of substructure 
                                                    Age_O=[b kkb kkb i];						   // age of branch

                                                else  			        
                                                    //br_a(p)==1, infloresence
                                                    rs_n=round((rs_B(b,1)-1)*(kk-age1)); //for inflo, MZ, 2005.8
                                                    
                                                    pos=Nu_Ma(p)-(kk-age1);
                                                    
                                                    if pos< (Nu_Ma(p)-Nu_Ma(b)) then
                                                        rs_n=rs_n+(Nu_Ma(p)-Nu_Ma(b))-pos;
                                                    end
                                                    if rs_n<0 then
                                                        rs_n=rs_A(b,1)+0;
                                                    else
                                                        rs_n=rs_A(b,1)+rs_n;
                                                    end                                                
                                                    
                                                    kkb=floor((kk-1-rs_n)*rt_a(b,1));//the ch_age of substructure 
                                                    
                                                    np=kk-1+NM(p)-j;								//cut the branch. NM from gl_read
                                                    if NM(b)>np then
                                                        nb=j+NM(b)-NM(p)-rs_n;
                                                        Age_O=[b kkb nb i];
                                                    else
                                                        Age_O=[b kkb kkb i];
                                                    end
                                                end;
                                                if p<b	then											//normal branch
                                                    m_O=m;                                              //reiteration order is same as the axis                                     
                                                else 													// p==b,reiteration branch
                                                    m_O=m+1;                                            //stick the branch with higher reiteration. Order nr has no reiteration
                                                end                                 
                                                sz_O=[0 0];                                                       
                                                V0=eye(3,3);	
                                                //V0=[0 0 1;0 1 0;1 0 0]; 
                                                flag= ( (br_a(p)==0) | ( (br_a(p)==1) & (Age_O(3)>0) )  ) ; //chr_age of substructure>0                                                                    
                                                flag=(flag &  (Age_O(2)>0) & ( (b<=maxp &  b>p) | (p==b & m<=b_o(p)) ) );
                                                if flag then
                                                   //flag=( flag & (Flag_pruning(b)~=1) | (kk-1<=T_Pr(b)+Pruning_delay(b)) );//not prunned
                                                   flag=( flag & (Flag_pruning(b)~=1) | (kk-1<=Nu_Ma(b)+Pruning_delay(b)) );//not prunned, according to AnneLaure 2004.07.01
                                                end ;                                   
                                                flag=flag & StateO(4,j-kk+1,p);       //organ occupied state                                                
                                            else
                                                flag=0;                                    
                                            end;
                                        end;
                                        
                                        if flag  then                                                                                         
                                            for jj=1:Nu_O(OrgId,p,b); //for each organ on the same internode
                                                w3=3.14+(Sumi-Posi)*Ang_Ph(p)+(jj-1)*2*%pi/Nu_O(OrgId,p,b);  //phylotaxy angle        
                                                if OrgId==3 | OrgId==2 then
                                                    //w3=(Sumi-Posi-1)*Ang_Ph(p)+(jj-1)*2*%pi/Nu_O(OrgId,p,b);  //phylotaxy angle        
                                                end;
                                                if Flag_plagiotropic(p)==1 then                                      
                                                    w3=w3+1.57;                                       
                                                end;                                    
                                                Vz=[cos(w3) -sin(w3) 0;sin(w3) cos(w3) 0; 0 0 1];   	 //z-rotation matrix.Vz=[cos(w3) sin(w3) 0;-sin(w3) cos(w3) 0; 0 0 1];                                                                 
                                                
                                                if (kk-age1+1)<=wbn(p) 	& (OrgId==1 | OrgId==4)	then												 //opening angle, still openning
                                                    aa=Ang_O(OrgId,p,b)+(kk-age1+1)/wbn(p)*(wb(p)-Ang_O(OrgId,p,b));
                                                else 																	 
                                                    if wbn(p)>0 then
                                                        aa=wb(p);													 //if kk>wbn(p),keep stable
                                                    else
                                                        aa=Ang_O(OrgId,p,b);										 //if wbn(p)==0, nothing to change
                                                    end;
                                                end ;                                                                       
                                                VBy=[cos(aa) 0 sin(aa);0 1 0;-sin(aa) 0 cos(aa)];		 //y-axis rotation matrix for axilary angle
                                                
                                                Vy=[cos(ap) 0 sin(ap);0 1 0;-sin(ap) 0 cos(ap)];       //y-axis rotation matrix for axis angle
                                                
                                                VO=Vy*Vz*VBy*V0;													//compound rotation matrix, the sequence can't change
                                                if  OrgId==4 & Flag_plagiotropic(p)==1  then               //if plagiotropic, the substructure bend in plane parallel to z-axis
                                                    vn=VO(:,2);//norm of plane of v1 and v2
                                                    vz=[0 0 1]';
                                                    sina=sum(vn.*vz);
                                                    cosa=norm(gl_cross(vn,vz));//to be changed
                                                    //cosa=norm(vn);
                                                    Vaxis=[cosa sina 0; -sina cosa 0; 0 0 1];
                                                    VO=VO*Vaxis;
                                                end
                                                if Flag_organ_bending(p)==1 then 								//if bending organ to a certain angle to z axis
                                                    vn=VO(:,1);													//primary direction of organ                                       
                                                    alpha=acos(vn(3,1));										//angle to z axis 
                                                    if vn(1,1)>0 then                                           //x>0
                                                       shift=Theta_O(OrgId,p)-alpha;
                                                    else
                                                       shift=alpha-Theta_O(OrgId,p);                        // x<0, rotation to another side
                                                    end ;                                                   
                                                    Vyg=[cos(shift) 0 sin(shift);0 1 0;-sin(shift) 0 cos(shift)];		                                                                                                                           
                                                    VO=Vyg*VO;                                                          
                                                    vn=VO(:,1);													//primary direction of organ                                       
                                                    alpha=acos(vn(3,1));										//angle to z axis                                                     
                                                end;
                                                if OrgId==4 then												//choose heo id for substructure, but for other organ, it is same with axis
                                                    [VO,g_O]=Draw_AngleShift(VO,InitMax(b),InitMin(b),InitNum(b));                                                                              
                                                else
                                                    g_O=g;
                                                end;        
                                                
                                                VD=VO(:,1);														//direction of branch                                    
                                                v1n=VI(:,1);													//direction of axis
                                                //VD=VD+dot(VD,v1n)*v1n;											//direction from center of GU. to sticking point
                                                VD=gl_cross(v1n,gl_cross(v1n,VD));
                                                //VD=v1n;
                                                if norm(VD)>0	then													// VD is direction of blade
                                                    VD=VD/norm(VD);
                                                end;            
                                                if Flag_Bending_by_node(p)==1 then
                                                    O_O=v1n*I_H(p,kk,i)-Ir/2*VD; 								//stick organs on the surface of G.U.
                                                else
                                                    //O_O=v1n*(u(p)-Numi+1)*I_H(p,kk,i)+Ir/2*VD ; 
                                                    //O_O=v1n*(u(p)-Numi+1)*I_H(p,kk,i)-Ir/2*VD ;    //2004_04_03 Phillippe doesn't want floating branches. 
                                                    O_O=v1n*(u(p)-Numi+1)*I_H(p,kk,i) ;
                                                end;                                           
                                                [NO,ID,Age,gs,mr,V,O,Sz]=Draw_GetOrgan(NO,ID,Age,gs,mr,V,O,Sz,id_O,Age_O,g_O,m_O,VO,O_O',sz_O);                                                                                      
                                            end;
                                        end;
                                    end;                           
                                end;//jj 1:Nu_I
                            end;//b
                        end ;//kk
                        
                        for no=1:NO;    
                            M=matrix(V(no,:,:),3,3);
                            if gs(no)==0 then
                                break;
                            end;                     
                            Draw_AddOrgan(fidBl,ID(no),Age(no,:),1,gs(no),mr(no),M,O(no,:),Sz(no,:));                       
                        end;
                        data=[4 p k j i 1 g m NO 0 ];   //10*4=40bytes      
                        for tempi=1:10; //if one matrix is written to a file directly, more bytes are occupied
                            mput(data(tempi),'l',fidInf);
                        end;
                        NumStr=NumStr+1;    
                        
                    end ;//k
                end;//m
            end;//j
        end;//g
    end;//i
end;//p

mclose(fidInf);
mclose(fidBl);

printf('done.  ');
printf(string(timer())+' seconds.\n');

//open str file and combine two files

//write str file header information 30*4=120 bytes  
[fid, %v] = mopen(StrFileName, 'wb');

//get organ smb if according to their smb filename

[IDSmb]=Draw_SMB2ID(Smb_I,Smb_L,Smb_Ff,Smb_Fm);

data=[maxp N NumStr IDSmb(1) IDSmb(2) IDSmb(3) IDSmb(4) Tu_O(1,1,1) Tu_O(3,1,1) Tu_O(4,1,1)]; //I suppose here that life time of organ is uniform for each phy_age         
mput(data,'l',fid);
data=[matrix(Tr,1,maxp) zeros(1,10-maxp)];
mput(data,'l',fid);
data=[matrix(InitNum,1,maxp) zeros(1,10-maxp)];
mput(data,'l',fid);
data=[matrix(b_o+1,1,maxp) zeros(1,10-maxp)];
mput(data,'l',fid);

//write str file data structure information %write information of each substructure
[fidInf, %v] = mopen(StrInf, 'rb');
f=[];
while ~meof(fidInf)
	f=[f mget(1000,'c', fidInf)];
end;	
//disp(mtell(fidInf1));
mput(f,'c',fid);
mclose(fidInf);

// write each block information inside a structure
[fidBl, %v] = mopen(StrBlock, 'rb');
f=[];
while ~meof(fidBl)
	f= mget(100,'c', fidBl);
	mput(f,'c',fid); 
	//disp(mtell(fidBl));
end;	

mclose(fidBl);
mclose(fid);

//mdelete(StrInf);mdelete(StrBlock);
