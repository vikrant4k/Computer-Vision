function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
    [x_s, y_s, c_s] = size(input_image);
    output_image = zeros(x_s, y_s, c_s);
    output_image(:,:,1) = input_image(:,:,1) ./ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
    output_image(:,:,2) = input_image(:,:,2) ./ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
    output_image(:,:,3) = input_image(:,:,3) ./ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
end

