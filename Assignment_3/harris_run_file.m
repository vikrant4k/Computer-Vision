%img=imread('pingpong/0000.jpeg');
img = imread('person_toy/00000001.jpg');
% To rotate the image
%img=imrotate(img,10);
img_gray=rgb2gray(img);
%img=im2double(img_gray);
[H,img_x,img_y]=harris_corner_detector(img_gray,1.5,5,1,5);
H_new=harris_local_maxima(H,70,20);
subplot(1,3,1);
imshow(img_x);
title('Derivative x-axis');
subplot(1,3,2);
imshow(img_y);
title('Derivative y-axis');
subplot(1,3,3);
[h w]=size(H);
for i=1:h
    for j=1:w
        if(H_new(i,j)>0)
            img(i,j,1)=255;
            img(i,j,2)=0;
            img(i,j,3)=0;
        end
    end
end
imshow(img);
title('Corners on image');