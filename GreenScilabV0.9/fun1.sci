function []=fun1(plantParam,envParam,outputParam)
//[i]=type(plantParam);
//Checked possibilities for types

//Correct way to print vars
//disp(i);
envFiles=listfiles([envParam]);

//for i=1:
y=size(envFiles);
disp("Starting simulations");
[referenceFile,err]=mopen(outputParam+"referenceFile.txt","w");
for i=1:y(1)
   mfprintf(referenceFile,envFiles(i,:))
   mfprintf(referenceFile,"\n")
end
mclose(referenceFile);

//Also creates a reference text file in order to know the order
for i=1:y(1)
   exec("C:\Program Files (x86)\scilab-4.1\contrib\GreenScilabV0.9\Gl_simulate.sci");
   accessParams(plantParam,envFiles(i),outputParam,i);
end
   
endfunction 
