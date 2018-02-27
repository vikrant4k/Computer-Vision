clc
close all
sigma = 2;
kernel_size = 5 ;
disp("gauss 1D:")
gauss1D( sigma , kernel_size)
disp("gauss 2D:")
gauss2D( sigma , kernel_size)