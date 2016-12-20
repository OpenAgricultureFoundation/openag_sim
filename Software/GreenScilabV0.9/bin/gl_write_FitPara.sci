// write fitted parameters
//write results to 'fit_out_result.sci'
[fres,err]=mopen(GL_SYS_DIR+'/bin/fit_out_result.sci','w');
mfprintf(fres,"%s\n","Fitting results:");
sump=0;
x_t_exp=t_exp;
//for a=1:size(t_exp_i,1)// if size(t_exp_i,1)>0, there is at least one t_exp is fit
for a=1:size(t_exp_i,2)// if size(t_exp_i,1)>0, there is at least one t_exp is fit
    sump=sump+1;
    x_t_exp(t_exp_i(a),1)=xval(sump);    
    mfprintf(fres,"%s","x_t_exp ( ");
    mfprintf(fres,"%d",t_exp_i(a));
    mfprintf(fres,"%s"," )");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%d\n", round(xval(sump)));    
    printf(strcat(['x_t_exp(',mtlb_num2str(t_exp_i(a)),')  =',mtlb_num2str(round(xval(sump))),'\n']));
end

x_Bt_N=Bt_N;
for a=1:size(Bt_N_i,2)   //   1
    sump=sump+1;
    x_Bt_N(Bt_N_i(a),1)=xval(sump);  
    mfprintf(fres,"%s","x_Bt_a ( ");
    mfprintf(fres,"%d",Bt_N_i(a));
    mfprintf(fres,"%s"," )");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%d\n", round(xval(sump))); 
    printf(strcat(['x_Bt_a(',mtlb_num2str(Bt_N_i(a)),')  =',mtlb_num2str(round(xval(sump))),'\n']));
end

x_Bt_p=Bt_p;
for a=1:size(Bt_p_i,2)   //  1
    sump=sump+1;
    x_Bt_p(Bt_p_i(a),1)=xval(sump); 
    mfprintf(fres,"%s","x_Bt_b ( ");
    mfprintf(fres,"%d",Bt_p_i(a));
    mfprintf(fres,"%s"," )");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_Bt_b(',mtlb_num2str(Bt_p_i(a)),')  =',mtlb_num2str(xval(sump)),'\n']));
end


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_S_B=S_O(1,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==1)
        sump=sump+1;
        x_S_B(S_O_i(a),S_O_j(a))=xval(sump);  
        mfprintf(fres,"%s","x_S_B ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
      printf(strcat(['x_S_B(',mtlb_num2str(S_O_j(a)),')   =',mtlb_num2str(xval(sump)),'\n']));
    end
end

x_S_P=S_O(2,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==2)
        sump=sump+1;
        x_S_P(S_O_i(a),S_O_j(a))=xval(sump); 
        mfprintf(fres,"%s","x_S_P ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
      printf(strcat(['x_S_P(',mtlb_num2str(S_O_j(a)),')   =',mtlb_num2str(xval(sump)),'\n']));        
    end
end

x_S_I=S_O(3,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==3)
      sump=sump+1;
      x_S_I(S_O_i(a),S_O_j(a))=xval(sump);  
      mfprintf(fres,"%s","x_S_I ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
      printf(strcat(['x_S_I(',mtlb_num2str(S_O_j(a)),')   =',mtlb_num2str(xval(sump)),'\n']));
    end
end

x_S_Ff=S_O(4,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==4)
        sump=sump+1;
        x_S_Ff(S_O_i(a),S_O_j(a))=xval(sump); 
        mfprintf(fres,"%s","x_S_Ff ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
        printf(strcat(['x_S_Ff(',mtlb_num2str(S_O_j(a)),')   =',mtlb_num2str(xval(sump)),'\n']));        
    end
end

x_S_Fm=S_O(5,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==5)
        sump=sump+1;
        x_S_Fm(S_O_i(a),S_O_j(a))=xval(sump);
        mfprintf(fres,"%s","x_S_Fm ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
        printf(strcat(['x_S_Fm(',mtlb_num2str(S_O_j(a)),')   =',mtlb_num2str(xval(sump)),'\n']));        
    end
end

x_S_L=S_O(6,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==6)
        sump=sump+1;
        x_S_L(S_O_i(a),S_O_j(a))=xval(sump); 
        mfprintf(fres,"%s","x_S_L ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
        printf(strcat(['x_S_L(',mtlb_num2str(S_O_j(a)),')   = ',mtlb_num2str(xval(sump)),'\n']));        
    end
end

x_S_R=S_O(6,:);
for a=1:size(S_O_i,2)
    if (S_O_i(a)==7)
        sump=sump+1;
        x_S_R(S_O_i(a),S_O_j(a))=xval(sump);  
        mfprintf(fres,"%s","x_S_R ( ");
      mfprintf(fres,"%d",S_O_j(a));
      mfprintf(fres,"%s"," )");
      mfprintf(fres,"%s"," = ");
      mfprintf(fres,"%f\n", xval(sump)); 
        printf(strcat(['x_S_R(',mtlb_num2str(S_O_j(a)),')   = ',mtlb_num2str(xval(sump)),'\n']));        
    end
end


//x_r_B=r_B;
//for a=1:size(r_B_i,1)
//    sump=sump+1;
//    x_r_B(r_B_i(a),1)=xval(sump);    
//    printf(strcat(['x_r_B(',mtlb_num2str(r_B_j(a)),')   =  ',mtlb_num2str(xval(sump)),'\n']));        
//end
//x_r_P=r_P;
//for a=1:size(r_P_i,1)
//    sump=sump+1;
//    x_r_P(r_P_i(a),1)=xval(sump);    
//    printf(strcat(['x_r_P(',mtlb_num2str(r_P_j(a)),')   =  ',mtlb_num2str(xval(sump)),'\n']));            
//end

if C_r_B == 1 then
    sump=sump+1;
    x_r_B = xval(sump);
    mfprintf(fres,"%s","x_r_B");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_r_B','   =  ',mtlb_num2str(xval(sump)),'\n']));
end

if C_r_P == 1 then
    sump=sump+1;
    x_r_P = xval(sump);
    mfprintf(fres,"%s","x_r_P");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_r_P','   =  ',mtlb_num2str(xval(sump)),'\n']));
end
if C_Sp == 1 then
    sump=sump+1;
    x_Sp = xval(sump);
    mfprintf(fres,"%s","x_Sp");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_Sp','   =  ',mtlb_num2str(xval(sump)),'\n']));
end
if C_rp == 1 then
    sump=sump+1;
    x_rp = xval(sump);
    mfprintf(fres,"%s","x_rp");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_rp','   =  ',mtlb_num2str(xval(sump)),'\n']));
end
if C_kp == 1 then
    sump=sump+1;
    x_rp = xval(sump);
    mfprintf(fres,"%s","x_kp");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_kp','   =  ',mtlb_num2str(xval(sump)),'\n']));
end
if C_Q0 == 1 then
    sump=sump+1;
    x_Q0 = xval(sump);
    mfprintf(fres,"%s","x_Q0");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_Q0','   =  ',mtlb_num2str(xval(sump)),'\n']));
end
if C_dQ0 == 1 then
    sump=sump+1;
    x_dQ0 = xval(sump);
    mfprintf(fres,"%s","x_dQ0");
    mfprintf(fres,"%s"," = ");
    mfprintf(fres,"%f\n", xval(sump)); 
    printf(strcat(['x_dQ0','   =  ',mtlb_num2str(xval(sump)),'\n']));
end

model_set = sim_fit_Hidden(xval);//compute model output according to estimated parameters

differ = sqrt(sum((model_set-target_set).^2));//error in square root

mfprintf(fres,"%s", "the square sum term is ");
mfprintf(fres,"%f\n",differ);
disp(['the square sum term is ', mtlb_num2str(differ)]);

mclose(fres);



