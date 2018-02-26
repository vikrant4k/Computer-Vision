orig_image=imread('images\image2.jpg');
orig_image=im2double(orig_image);
imout_1=compute_LoG(orig_image,2);
% imout_2=compute_LoG(orig_image,2);
% imout_3=compute_LoG(orig_image,3);
% subplot(2,2,1)
% imshow(orig_image);
% title('Original Image');
% subplot(2,2,2)
% imshow(imout_1);
% title('1st Method');
% subplot(2,2,3)
% imshow(imout_2);
% title('2nd Method');
% subplot(2,2,4)
% imshow(imout_3);
% title('3rd Method');
