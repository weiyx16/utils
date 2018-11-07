clear; clc; close all;

file_path =  '~/Desktop/data_results/lip_res/'; 
file_mask =  '*.mat';

file_path_list = dir(strcat(file_path, file_mask)); 
file_num = length(file_path_list);  
disp(file_num)
file_list = cell(file_num, 1);
if file_num > 0 
    for j = 1:file_num 
        mat_name = file_path_list(j).name;
        file_list{j} = [file_path, mat_name];
    end
end

if file_num > 0 
    for j = 1:file_num 
        
        info = ['Now Filenum ', num2str(j), ' from ' ,file_list{j}];
        disp(info);
	
	%% according to the path do anything you want
	load(file_list{j});
    end
end


