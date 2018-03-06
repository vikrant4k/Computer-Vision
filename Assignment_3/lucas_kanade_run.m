im11=imread('synth1.pgm');
im22=imread('synth2.pgm');
% im1=rgb2gray(im11);
% im2=rgb2gray(im22);
im1=im2double(im11);
im2=im2double(im22);
[u,v]=lucas_kanade(im1,im2,15);
imshow(im11);
hold on;            
quiver(u,v,10,'red')
