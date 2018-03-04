im11=imread('sphere1.ppm');
im22=imread('sphere2.ppm');
im1=rgb2gray(im11);
im2=rgb2gray(im22);
im1=im2double(im1);
im2=im2double(im2);
[u,v]=lucas_kanade(im1,im2,15);
quiver(im1(:,1),im1(:,2),u,v)