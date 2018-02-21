function [albedo,normals]=test_data(image_path,shadow)
% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = strcat('D:\subj\cv1\Lab1_Photometric_Color\Lab1_Photometric_Color\photometric\photometrics_images\',image_path,'\');   % TODO: get the path of the script
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV,shadow);

end