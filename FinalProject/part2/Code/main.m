clear all;
close all; 
clc;

%% Image Alignment
Ia = imread('boat1.pgm') ;
Ib = imread('boat2.pgm') ;
%Ia = vl_impattern('roofs1');
%Ib = vl_impattern('roofs2');

iter = 20;
p_percent = 0.05; % should be in range of 0 to 1
plot_matches(Ia,Ib,iter,p_percent);
convert_image(Ia,Ib,iter,p_percent,'left');
convert_image(Ib,Ia,iter,p_percent,'right');

%% Stitch
iter = 100;
p_percent = 0.05;  % should be in range of 0 to 1

I_right = imread('right.jpg') ;
I_left = imread('left.jpg') ;

%I_right = vl_impattern('roofs1');
%I_left = vl_impattern('roofs2');

stitch_images(I_right,I_left,iter,p_percent);









