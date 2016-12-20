function [water_sequence, theta_sequence, light_sequence,NUM] = env_read_target(tar_filename);
// water supply environment is not considered in this version


global INTER_SYS_DIR
                               /////////////   '/env' /////////////   
	//tar_filename = xgetfile('*.dat',INTER_SYS_DIR+'/env', title='open environmental data file');
	printf tar_filename;
	printf 'hi';
   [fid, %v] = mopen(tar_filename, 'rb');
	if %v<0 then
	     fid = -1; disp('env file read error.');
	end
   
   itemNum=3;

	line=mgetl(fid,1);
	line=mgetl(fid,1);
	line=mgetl(fid,1);
    
    read_count = 1;
    i=0;
    while read_count ~= 0
        [read_count,date_str] = mfscanf(fid, '%s'); // read GCi:
        if read_count==-1 then
            break;
        end
        i = i+1;
        //date_num(i) = datenum(date_str);
        for j=1:itemNum
            data_sequence(j,i) = mfscanf(fid, '%f');
        //disp(data_sequence)
  
        end
    end
    

	NUM = i;

	mclose(fid);


   theta_sequence = data_sequence(2, :);

   light_sequence = data_sequence(3, :);

   water_sequence = data_sequence(1, :);
endfunction

