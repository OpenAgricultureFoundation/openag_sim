function [StateO] = Gl_StateOccupy(Tu_O)

// Ouput variables initialisation (not found in input variables)
StateO=[];


//law of occupacy

// organ ID:  1 blade, 2 petiel, 3 internode, 4 female flower,  5 male flower, 6 layer, 7 root, 8 branch

tempSz=size(Tu_O)
maxp = tempSz(3);

StateO = zeros(4,99,maxp);
for p = 1:maxp;
  for id = 1:4; //id of axillary organ
   select id
     case 1 then // leaf
    OrgId = 1;
     case 2 then //female organ
    OrgId = 4;
     case 3 then //male organ
    OrgId = 5;
     case 4 then //branch
    OrgId = 8;
   end;
   StateO(id,1:Tu_O(OrgId,2,p)-1,p) = 0; //before organ appear, no occupy, state=0
   state = [ones(1,Tu_O(OrgId,4,p)),zeros(1,Tu_O(OrgId,5,p))]; //a cycle of occupacy(1) and non-occupacy(0)
   lc = max(size(state)); //length of cycle
   span = Tu_O(OrgId,3,p)-Tu_O(OrgId,2,p)+1; //life span of organ
   nc = floor(span/lc); //number of cycle

   nrem = span - lc.*fix(span./lc);
   tmp = [];
   for ab = 1:nc;
     tmp = [tmp,state];
   end;
   StateO(id,Tu_O(OrgId,2,p):Tu_O(OrgId,2,p)+nc*lc-1,p) = tmp;
   if nrem>0 then
   	StateO(id,Tu_O(OrgId,2,p)+nc*lc:Tu_O(OrgId,3,p),p) = state(1:nrem);
   	end;
  end;
end;
endfunction
