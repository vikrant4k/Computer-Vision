
clear all;
close all; 
clc;

original_image =imread('../person_toy/00000001.jpg');% imread('../pingpong/0000.jpeg');

filter_sigma = 1.5;
filter_size = 5;
w_sigma = 1;
w_filter_size = 5;
% for pingpong n = 15 trhld = 15*255
%for person toy n = 20 trhld = 8*255
n = 20;
threshold = 8*255;


[H,Ix, Iy,r,c,corner_points] = harris_corner_detector(original_image,filter_sigma, filter_size, w_sigma , w_filter_size,n,threshold);


figure, subplot(1,3,3), imshow(original_image); hold on; plot(c, r,'o', 'MarkerSize', 5); hold off;title('corners')
subplot(1,3,1), imshow(Ix);title('Ix');
subplot(1,3,2), imshow(Iy);title('Iy');