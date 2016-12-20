proc about {} {

       global w
############Create a window for General Parametre Setting
label .lab
set w .lab
catch {destroy $w}
toplevel $w
wm title $w "About GreenScilab"
wm iconname $w "Greenlab"

######### create "ok" and "cancel" buttons
frame $w.buttons 
button $w.buttons.ok -text "Ok" -command aboutTB_ok
pack $w.buttons -side bottom -fill x -pady 2
pack $w.buttons.ok -side left -expand 1 -fill y

##### Creat a text on which the content of toolbox is shown 
set t $w.t
text $t -relief raised  -border 2 -width 80 -height 40 -font {Courier -12} \
-yscrollcommand {$w.scroll set}
scrollbar $w.scroll -command {$t yview}
pack $w.scroll -side right -fill y
pack $w.t -side left -fill both -expand 1

$t delete 0.0 end
$t insert end "\n    GreenScilab WebSite : www.greenscilab.org\
               \n    Contact : greenscilab@liama.ia.ac.cn\
               \n\n    GreenScilab Developpers\
               \n      MengZhen KANG          mzkang@liama.ia.ac.cn\
               \n      Rui QI                 rqi@liama.ia.ac.cn\
               \n      Philippe de Reffye     philippe.de_reffye@liama.ia.ac.cn\
               \n      YunTao MA              mytao@cau.edu.cn\
               \n\n\n    GreenScilab Logo\
               \n      BaoGang HU             hubg@nlpr.ia.ac.cn\
               \n      Philippe de Reffye     philippe.de_reffye@liama.ia.ac.cn\
               \n\n\n    GreenScilab advisory\
               \n      Paul-Henry COURNEDE    (MAS,ECP)\
               \n      Thierry FOURCAUD       (LIAMA)\
               \n      Yan GUO                (CAU)\
               \n      Ep HEUVELINK           (HPC,WUR)\
               \n      BaoGang HU             (LIAMA)\
               \n      DanFeng HUANG          (ShangHai JiaoTong Univ.)\
               \n      Vos JAN                (CWE,WUR)\
               \n      Philippe de REFFYE     (LIAMA,INRIA,CIRAD)\
               \n      YiMing WANG            (CAU)\
               \n      BaoGui ZHANG           (CAU)\
               \n\n\n    GreenScilab associate team\
               \n      Projet DigiPlante      (INRIA,ECP)\
               \n      ViSCS                  (CAU)\
               \n\n\n    Scilab technical support\
               \n      Projet METALAU,(Maurice Goursat, Francois Delebecque, Serge STEER, Jean-Pierre QUADRAT,Ramine Nikoukhah)\
               \n      Scilab consortium,Claude Gomez.\
               "
$t configure -state disabled

}

proc aboutTB_ok {} {
    global w
    destroy $w
    }
    
    

                                           
