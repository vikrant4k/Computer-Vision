clear
clc
close all
ref_img = im2double(imread('ball_reflectance.png'));
shade_img = im2double(imread('ball_shading.png'));
orig_img = im2double(imread('ball.png'));

rec_img = ref_img .* shade_img;
figure
imshow(rec_img)

