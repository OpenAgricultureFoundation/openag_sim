function [VO,gb] = Draw_AngleShift(VO,InitMax,InitMin,InitNum)

// Ouput variables initialisation (not found in input variables)
gb=[];


//find ID of angle to z axis of cubstructure according to its actual substructure direction and the predefine one(s)
// mengzhen 2003

if InitNum>1  then //if more than 1 intial angles predefined
  vn=VO*[0; 0; 1]; // Find the actural direction of substrucure. Remember all substructures are stored with direction to z-axis.
 alpha = acos(vn(3,1)); //alpha is angle to z axis 
 if vn(2,1)>0	 then //alpha2 is angle to xz-plane
  alpha2 = acos(vn(1,1)/norm(vn(1:2))); //positive side
 else
  alpha2 = 2*%pi-acos(vn(1,1)/norm(vn(1:2)));  //negative side       
 end;
 tmpA = InitMin+(0:InitNum-1)*(InitMax-InitMin)/(InitNum-1); //tmpA is vector of predefined angles
  [Y,gb] =min(abs(alpha-tmpA)); //find the ID of nearest predefined angle to the actural one.                 
 init = alpha;
 Vyg = [cos(init),0,sin(init);0,1,0;-sin(init),0,cos(init)]; //y-rotation matrix
 Vzg = [cos(alpha2) -sin(alpha2) 0;sin(alpha2) cos(alpha2) 0; 0 0 1]; //z-rotation matrix
 //VO=Vzg*Vyg;                                              %compound of both
 VO = Vzg;
else
  gb = 1;
  VO = VO;
end;
endfunction
