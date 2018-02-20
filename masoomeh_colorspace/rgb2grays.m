function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
figure

% ligtness method
[x_s, y_s, c_s] = size(input_image);
output_image = zeros(x_s, y_s, 1);
max_rgb = max(max(input_image(:,:,1), input_image(:,:,2)), input_image(:,:,3));
min_rgb = min(min(input_image(:,:,1), input_image(:,:,2)), input_image(:,:,3));
output_image(:,:,1) = (max_rgb + min_rgb) ./2;
subplot(2,2,1);
imshow(output_image);
title('ligtness method');

% luminosity method;
output_image(:,:,1) = 0.21*input_image(:,:,1) + 0.72*input_image(:,:,2) + 0.07*input_image(:,:,3);
subplot(2,2,2);
imshow(output_image);
title('luminosity method');
% average method
output_image(:,:,1) = 0.333*input_image(:,:,1) + 0.333*input_image(:,:,2) + 0.333*input_image(:,:,3);
subplot(2,2,3);
imshow(output_image);
title('average method');
% built-in MATLAB function 
output_image(:,:,1) = rgb2gray(input_image);
subplot(2,2,4);
imshow(output_image);
title('built-in method'); 
end

