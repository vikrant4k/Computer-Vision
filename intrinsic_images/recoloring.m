clear
clc
close all
ref_img = im2double(imread('ball_reflectance.png'));
shade_img = im2double(imread('ball_shading.png'));
orig_img = im2double(imread('ball.png'));


[x_s, y_s, c_s] = size(ref_img);
new_ref = zeros(x_s, y_s, c_s);

new_ref(:,:,1) = 0;
new_ref(:,:,2) = 1;
new_ref(:,:,3) = 0;


%rec_img = ref_img .* shade_img;
rec_img = new_ref .* shade_img;
figure
subplot(1,3,1);
imshow(orig_img)
subplot(1,3,2);
imshow(rec_img)

new_ref(:,:,1) = 1;
new_ref(:,:,2) = 0;
new_ref(:,:,3) = 1;


%rec_img = ref_img .* shade_img;
rec_img = new_ref .* shade_img;
subplot(1,3,3);
imshow(rec_img)
