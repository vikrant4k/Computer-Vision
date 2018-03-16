clear all;
close all; 
clc;

% { 'cars_train', 'airplanes_train', 'motorbikes_train', 'faces_train'}
%{
folders_names = {'cars_train/', 'airplanes_train/', 'motorbikes_train/', 'faces_train/'};
path = '../Caltech4/ImageData/';
for i=1:4%length(folders_names)
    %fileID = fopen('min_da_size_info.txt','w');
    string(folders_names(i))
    [min_key_points, min_da_size] = find_min_da_size(strcat(path,string(folders_names(i))))
    %fprintf(fileID,min_key_points, min_da_size,'\n');
    %fclose(fileID);
end
%}

[min_dim, avg_dim] = read_files();


%% Feature extraction

%Ia = imread('../Caltech4/ImageData/cars_train/img001.jpg') ;
%[fa, da] = feature_extraction(Ia);
%size(da)
%size(fa)








