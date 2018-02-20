clear
clc
close all
IMG = imread('awb.jpg');
IMG = im2double(IMG);
output = awb(IMG);
visualize(IMG, output);


% automatic white balancing algorithm
function [output] = awb(input_image)
    [x_s, y_s, c_s] = size(input_image);
    output = zeros(x_s, y_s, c_s);

    R = input_image(:,:,1);
    G = input_image(:,:,2);
    B = input_image(:,:,3);
    
    r_mean = mean2(R)
    g_mean = mean2(G)
    b_mean = mean2(B)
    
    output(:,:,1) =  input_image(:,:,1) + (0.5 - r_mean);   
    output(:,:,2) =  input_image(:,:,2) + (0.5 - g_mean);
    output(:,:,3) =  input_image(:,:,3) + (0.5 - b_mean);

end

function visualize(img1,img2)
    figure 
    subplot(1,2,1);
    imshow(img1);
    title('Before');
    subplot(1,2,2);
    imshow(img2);
    title('After');
end









