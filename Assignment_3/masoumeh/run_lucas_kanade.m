clear all;
close all; 
clc;
%----------------------------load images---------------------
%original_image = imread('../synth1.pgm');
%moved_image = imread('../synth2.pgm');

original_image = imread('../sphere1.ppm');
moved_image = imread('../sphere2.ppm');


size(original_image)
size(moved_image)

%------convert colored image to gray scale---covert gray to double--------
if length(size(original_image)) == 3
    img_1 = im2double(rgb2gray(original_image));
else
    img_1 = im2double(original_image);
end
    
if length(size(moved_image)) == 3
    img_2 = im2double(rgb2gray(moved_image));
else
    img_2 = im2double(moved_image);
end


%--------------Calculate Ix and Iy for whole image---------------------
sigma = 1.5;
filter_size = 3;
Gx = gradient(fspecial('gauss', [1, filter_size], sigma));
Gy = gradient(fspecial('gauss', [filter_size, 1], sigma));
Ix = imfilter(img_1, Gx,'conv');
Iy = imfilter(img_1, Gy,'conv');


%-----------slice both images to 15*15 patches------------------
slice_size = 15;
[h, w] = size(img_1);
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



%-----Find velocity between every two matching patches from two images-----
u = zeros(patch_num,1);
v = zeros(patch_num,1);
c = 1;

for i = 1:patch_num
    patch_of_1 = reshape(patches_1(i,:,:), slice_size, slice_size);
    patch_of_2 = reshape(patches_2(i,:,:), slice_size, slice_size);
    patch_Ix = reshape(patches_ix(i, :, :), slice_size, slice_size);
    patch_Iy = reshape(patches_iy(i, :, :), slice_size, slice_size);
    solution = lucas_kanade(patch_of_1,patch_of_2, patch_Ix, patch_Iy);
    u(c,1) = solution(1);
    v(c,1) = solution(2);
    c = c + 1;
end


%--------------- Plot velocity vectors on original image-----------------
p_x = floor(w/slice_size);
p_y = floor(h/slice_size);
u = reshape(u, p_x, p_y);
v = reshape(v, p_x, p_y);
size(u)
m = floor(slice_size/2)+1;
[x,y] = meshgrid(m:slice_size:w-m,m:slice_size:h-m);


figure(1);
imshow(original_image);  
hold on;
quiver(y, x , u, v, 'red')

