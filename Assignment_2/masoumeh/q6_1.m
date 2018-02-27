clc
close all
im = im2double(imread('images/image1_saltpepper.jpg'));
im_enh = im2double(imread('images/image1.jpg'));
disp("psnr:")
psnr = myPSNR(im_enh, im)