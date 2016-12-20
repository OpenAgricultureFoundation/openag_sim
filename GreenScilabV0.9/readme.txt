Version 0.9  ( 2006-11-09)

First you need to install Scilab free software in your computer.

There are several way to start GreenScilab.

1. Quick start.
   Put the 'GreenScilab x' folder  under SCI/contrib. 
   SCI stands for the installation directory of scilab software.
   Then anytime you start Scilab sofware, there will be a menu 'toolboxes', and you click the 'GreenScilab  x'.

2. Run 'GreenScilab' from any place.
   either (a): go to GreenScilab folder, right click the file loader.sce, and choose 'run with scilab';
   or (b) first start scilab,  from menu 'File', choose 'Exec..', open the file 'loader.sce'. 
   
In both cases the GreenScilab windows will open. Only one GreenScilab windows is allowed at the same time.

3. Run GreenScilab without interface by Scilab command. (for advanced user)
We Suppose here that PATH stands for the path of the directory that contain the file loader.sce.
      
      for simulation:
		            exec('PATH\Gl_simulate.sci'); 		           
		            
	    for fitting:		
		            exec('PATH\gl_fit_para.sci'); 
 		 
If any problem concerning this toolbox, please mail to greenscilab@liama.ia.ac.cn.

Visit www.greenscilab.org for the last version, and related documents.

MengZhen KANG
