clear all;
close all; 
clc;

output_folder = 'vid/';


folder_name = 'pingpong';
images_folder = strcat('vid/',folder_name);
file_name = strcat(folder_name, '_vid_out.avi');
%make_video(images_folder, output_folder, file_name);




folder_name = 'toy';
images_folder = strcat('vid/',folder_name);
file_name = strcat(folder_name, '_vid_out.avi');
make_video(images_folder, output_folder, file_name);