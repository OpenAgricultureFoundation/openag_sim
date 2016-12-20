

//output virtual target from simulation. mz, 10/2006
printf('\n');                
//prompt dialogue
labels=['Number of stages'];//suppose Init_Ang=1 and Reiter Order=1
init=['1'];      
dlgTitle='Number of stages for fitting';   
[ok,NumPlt]=getvalue(dlgTitle,labels,list("vec",1),init);
 
if  ~ ok then        
   NumPlt=0;
end      


LoD=zeros(NumPlt,maxp);
CA_plant=zeros(1,NumPlt);

for np=1:NumPlt
  labels=['Plant age:(1-'+string(N)+')'];
  init=[string(N)];def=list("vec",1);
  for p=1:maxp
    labels=[labels; 'LoD for PA '+string(p)+ ':(0-'+string(2)+')'];
    init=[init; '0'];
    def(length(def)+1)="vec";
    def(length(def)+1)=1;
  end

  dlgTitle='Info of stage '+string(np);   tmp2=zeros(1,maxp);
  [ok,tmp1,tmp2]=getvalue(dlgTitle,labels,def,init);
  CA_plant(np)=tmp1;LoD(np,:)=tmp2;
 
end    


printf('//**********************Target*data***************************\n');
printf('NumberPlant(NumPlt)  %4d\n',NumPlt);                                        
printf('\n');                                        

for np=1:NumPlt

  printf('InfoPlant(CA,PA,LoD)');                                        
  printf('%4d%4d%4d\n',CA_plant(np),maxp,LoD(np));
  printf('Root(Q_R)  ');  
  printf('%4.1f\n',-1);//need to be replaced

  for p=1:maxp  
  select LoD(np,p)
  case 0 //detailed data
    printf('//--------GU----NbSub----IDSub----Q_B----Q_P----Q_I----Q_Ff----Q_Fm----S_B----S_I----H_I-\n');
    printf('InfoAxis(ID,PA,CA,LowestPos)');                                        

    if p==1 then
    
      ID=0;IDmum=-1;
      printf('%4d%4d%4d%4d\n',ID,p,CA_plant(np),1);

      for Pos=1:min(Nu_Ma(p),CA_plant(np))//for each GU from bottom to up
        printf('GU\t');
        printf('%3d\t%3d\t%3d\t',Pos,ID,IDmum);

        //CA of organs in metamer of position Pos
        CA_O=CA_plant(np)-Pos+1;
        //----------- blade in the main stem
        printf('%7.2f\t',q_O(1, 1,CA_O, CA_plant(np)));

        //----------- pietiole in the main stem
        printf('%7.2f\t',q_O(2, 1,CA_O, CA_plant(np)));

        //--------- internode in the main stem with layers
        QL=0;
        for k=0:CA_O-1
            QL=QL+q_L(1,CA_O-k,CA_plant(np)-k,CA_plant(np)-k);
        end
        printf('%7.2f\t',q_O(3, 1,CA_O, CA_plant(np))+QL);
        
        //--------- female organ in the main stem         
        printf('%7.2f\t',q_O(4, 1,CA_O, CA_plant(np)));
                
        //--------- female flower in the main stem 
        printf('%7.2f\t',q_O(5, 1,CA_O, CA_plant(np)));
        
        //--------- leaf area in the main stem 
        printf('%7.2f\t',B_S(p,CA_O,CA_plant(np))); 

        //--------- Internode section area the main stem 
        printf('%7.2f\t',I_S(p,CA_O,CA_plant(np),CA_plant(np)));

        //--------- Internode length the main stem 
        printf('%7.2f\t',I_H(p,CA_O,CA_plant(np)));
        
        printf('\n');
      end//for Pos=1:min(Nu_Ma(p),CA_plant(np))
    end//if p==1 then
    
    case 1 //compartment data
      printf('InfoAxis(ID,PA,CA,LowestPos)');                                        

      if p==1 then
    
      ID=0;IDmum=-1;      
      printf('%4d%4d%4d%4d\n',ID,p,CA_plant(np),1);

      Pos=1:min(Nu_Ma(p),CA_plant(np));
      CA_O=CA_plant(np)-Pos+1;    
      //----------- blade
      no=matrix(Nb_O(1,1,CA_O,CA_plant(np),CA_plant(np),p),1,length(Pos));
      qo=matrix( q_O(1,1,CA_O,CA_plant(np)),1,length(Pos));
      printf('Blade:\t     %7.2f\n',sum(no.*qo));
      
      //----------- pietiole 
      no=matrix(Nb_O(2,1,CA_O,CA_plant(np),CA_plant(np),p),1,length(Pos));
      qo=matrix( q_O(2,1,CA_O,CA_plant(np)),1,length(Pos));
      printf('Petiole:\t  %7.2f\n',sum(no.*qo));
      
      //----------- internode
      no=matrix(Nb_O(3,1,CA_O,CA_plant(np),CA_plant(np),p),1,length(Pos));
      qo=[];        
      for CA_I=CA_plant(np):-1:CA_plant(np)-min(Nu_Ma(p),CA_plant(np))+1
        QL=0;
        for k=0:CA_I-1
          QL=QL+q_L(1,CA_I-k,CA_plant(np)-k,CA_plant(np)-k);
        end
        qo=[qo q_O(3, 1,CA_I, CA_plant(np))+QL];
      end      
      printf('Internode:\t  %7.2f\n',sum(no.*qo));
      end

      //----------- female organ //I should recall how the indices are arranged
      no=matrix(Nb_O(4,1,CA_O,CA_plant(np),CA_plant(np),p),1,length(Pos));
      qo=matrix( q_O(4,1,CA_O,CA_plant(np)),1,length(Pos));
      printf('FemaleOrgan:\t%7.2f\n',sum(no.*qo));

      //----------- male organ 
      no=matrix(Nb_O(5,1,CA_O,CA_plant(np),CA_plant(np),p),1,length(Pos));
      qo=matrix( q_O(5,1,CA_O,CA_plant(np)),1,length(Pos));
      printf('MaleOrgan:  \t%7.2f\n',sum(no.*qo));
    
    end//select
  end//end of one plant
  printf('\n');
end
  
