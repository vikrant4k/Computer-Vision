function run_harris(file_name,file_path,rotate,angle,sigma1,k_size1,sigma2,k_size2,n, threshold)

if exist('results/','dir') ~= 7
    mkdir 'results/'
end


img = imread(file_path);


if rotate == 1
    % To rotate the image
    img=imrotate(img,angle);
end
img_gray=rgb2gray(img);


[H,img_x,img_y,r,c,H_new]=harris_corner_detector(img_gray,sigma1,k_size1,sigma2,k_size2,n, threshold);

figure(1), subplot(1,3,3), imshow(img); hold on; plot(c, r,'k.', 'MarkerSize', 5); hold off;title('corners')
subplot(1,3,1), imshow(img_x);title('Ix');
subplot(1,3,2), imshow(img_y);title('Iy');


if rotate == 1
     saveas(figure(1), [ 'results/' strcat('rotated_',num2str(angle),'_',file_name) '_' num2str(threshold) '.png']);    
else
    saveas(figure(1), [ 'results/' file_name '_' num2str(threshold) '.png']);
end


