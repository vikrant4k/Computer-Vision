clear all;
close all; 
clc;

if exist('results/','dir') ~= 7
    mkdir 'results/'
end




sigma1 = 2.8;
k_size1 = 7;
sigma2 = 0.5;
k_size2 = 3;
n = 30;
threshold = 70;

file_name = 'toy';
file_path = 'person_toy/00000001.jpg';

rotate = 0; % do not rotate
angle = 0;
run_harris(file_name,file_path,rotate,angle,sigma1,k_size1,sigma2,k_size2,n, threshold);


rotate = 1;%rotate
angle = 10;
run_harris(file_name,file_path,rotate,angle,sigma1,k_size1,sigma2,k_size2,n, threshold);



file_name = 'pingpong';
file_path = 'pingpong/0000.jpeg';

rotate = 0; % do not rotate
angle = 0;
run_harris(file_name,file_path,rotate,angle,sigma1,k_size1,sigma2,k_size2,n, threshold);

rotate = 1;%rotate
angle = 10;
run_harris(file_name,file_path,rotate,angle,sigma1,k_size1,sigma2,k_size2,n, threshold);


