%im= rgb2gray(im2double(imread('../pingpong/0000.jpeg')));
img = imread('../person_toy/00000001.jpg');
%img = imread('../pingpong/0000.jpeg');
img=imrotate(img,10);
im= rgb2gray(img);


filter_sigma = 1.5;
filter_size = 5;
w_sigma = 1;
w_filter_size = 5;

[H,Ix, Iy] = harris_corner_detector(im,filter_sigma, filter_size, w_sigma , w_filter_size);

n = 10;
threshold = 200;
corner_points = find_local_maxima(H,n,threshold);

figure(11)
%imshow(corner_points);

subplot(1,3,1);
imshow(Ix);
title('Derivative x-axis');
subplot(1,3,2);
imshow(Iy);
title('Derivative y-axis');
subplot(1,3,3);

[h w]=size(H);
for i=1:h
    for j=1:w
        if(corner_points(i,j)>0)
            img(i,j,1)=255;
            img(i,j,2)=0;
            img(i,j,3)=0;
        end
    end
end

imshow(img);
title('Corners on image');






