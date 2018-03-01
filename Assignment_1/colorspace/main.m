% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

%J = ConvertColorSpace(I,'opponent');

 
% close all
% J = ConvertColorSpace(I,'rgb');

% close all
% J = ConvertColorSpace(I,'hsv');

% close all
% J = ConvertColorSpace(I,'ycbcr');

% close all
 J = ConvertColorSpace(I,'gray');
subplot(1,4,1);
imshow(J(:,:,1))
subplot(1,4,2);
imshow(J(:,:,2))
subplot(1,4,3);
imshow(J(:,:,3))
subplot(1,4,4);
imshow(J(:,:,4))