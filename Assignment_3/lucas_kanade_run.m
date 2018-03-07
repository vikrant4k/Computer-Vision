im11=imread('sphere1.ppm');
im22=imread('sphere2.ppm');
im1=rgb2gray(im11);
im2=rgb2gray(im22);
im1=im2double(im1);
im2=im2double(im2);
[u,v]=lucas_kanade(im1,im2,15);

m = floor(slice_size/2)+1;
[x,y] = meshgrid(m:slice_size:w-m,m:slice_size:h-m);


size(u)
imshow(im11);
hold on;
quiver(u,v)
