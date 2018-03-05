
%function[]= lucas_kanade()
%img_1 = imread('../synth1.pgm');%rgb2gray(imread('../synth2.pgm'));
%img_2 = imread('../synth2.pgm');

img_1 = im2double(rgb2gray(imread('../sphere1.ppm')));%rgb2gray(imread('../synth2.pgm'));
img_2 = im2double(rgb2gray(imread('../sphere2.ppm')));


Gx = gradient(fspecial('gauss', [1, 3]));
Gy = gradient(fspecial('gauss', [3, 1]));
%Ix = conv2(img_2,Gx,'same');
%Iy = conv2(img_2,Gy,'same');
Ix = imfilter(img_2, Gx);
Iy = imfilter(img_2, Gy);

slice_size = 15;
[h w] = size(img_1);
patch_num = floor(w/slice_size) * floor(h/slice_size);
patches_1 = zeros(patch_num, 15,15);
patches_2 = zeros(patch_num, 15,15);
patches_ix=  zeros(patch_num, 15,15);
patches_iy=  zeros(patch_num, 15,15);
c = 1;
for i = 1:floor(h/slice_size)
    for j = 1:floor(w/slice_size)
        patches_1(c, :,:) = img_1((i-1)*slice_size+1:i*slice_size, (j-1)*slice_size+1:j*slice_size);
        patches_2(c, :,:) = img_2((i-1)*slice_size+1:i*slice_size, (j-1)*slice_size+1:j*slice_size);
        patches_ix(c, :,:) = Ix((i-1)*slice_size+1:i*slice_size, (j-1)*slice_size+1:j*slice_size);
        patches_iy(c, :,:) = Iy((i-1)*slice_size+1:i*slice_size, (j-1)*slice_size+1:j*slice_size);
        c = c + 1;
    end
end


%figure(1)
%imshow(img)
sigma = 1.5;
filter_size = 3;
u = zeros(patch_num,1);
v = zeros(patch_num,1);
c = 1;
num_of_patches
for i = 1:num_of_patches
    patch_of_1 = reshape(patches_1(i,:,:), slice_size, slice_size);
    patch_of_2 = reshape(patches_2(i,:,:), slice_size, slice_size);
    patch_Ix = reshape(patches_ix(i, :, :), slice_size, slice_size);
    patch_Iy = reshape(patches_iy(i, :, :), slice_size, slice_size);
    x = lucas_kanade(patch_of_1,patch_of_2, patch_Ix, patch_Iy, sigma , filter_size);
    u(c,1) = x(1);
    v(c,1) = x(2);
    c = c + 1;
end
u = reshape(u, 13, 13)
v = reshape(v, 13, 13)
m = floor(slice_size/2)+1;
[x,y] = meshgrid(m:slice_size:w-m,m:slice_size:h-m);
figure(1);
imshow(img_1);  
hold on;
quiver(y, x , u, v, 'red')



