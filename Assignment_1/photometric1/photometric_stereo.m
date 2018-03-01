
clear all
clc
warning('off');

disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')

mode = 0; % 1 for gray 0 for color

if mode == 1
    image_dir = 'D:\subj\cv1\Lab1_Photometric_Color\Lab1_Photometric_Color\photometric\photometrics_images\MonkeyGray_\';   % TODO: get the path of the script
    % image_dir = '/Users/gulfaraz/Desktop/ImageSets/SphereGray3WC/';   % TODO: get the path of the script
    [image_stack, scriptV] = load_syn_images(image_dir,1);

    [h, w, n] = size(image_stack);
else
    image_dir_color = 'D:\subj\cv1\Lab1_Photometric_Color\Lab1_Photometric_Color\photometric\photometrics_images\MonkeyColor\';   % TODO: get the path of the script
    [image_stack_1, scriptV_rgb] = load_syn_images(image_dir_color, 1);
    [image_stack_2, ~] = load_syn_images(image_dir_color, 2);
    [image_stack_3, ~] = load_syn_images(image_dir_color, 3);
    [h, w, n] = size(image_stack_1);
end
%image_dir = '/Users/gulfaraz/Desktop/ImageSets/SphereGray6WOC/';   % TODO: get the path of the script
%image_ext = '*.png';

fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
if mode == 1
    [albedo_rgb, normals_gray] = estimate_alb_nrm(image_stack, scriptV, false);
else
    [albedo_1, ~] = estimate_alb_nrm(image_stack_1, scriptV_rgb, false);
    [albedo_2, ~] = estimate_alb_nrm(image_stack_2, scriptV_rgb, false);
    [albedo_3, ~] = estimate_alb_nrm(image_stack_3, scriptV_rgb, false);
    
    albedo_rgb = cat(3, albedo_1, albedo_2, albedo_3);

    image_stack_1(isnan(image_stack_1))=0;
    image_stack_2(isnan(image_stack_2))=0;
    image_stack_3(isnan(image_stack_3))=0;
    % image_stack_2 = zeros(size(image_stack_2));

    image_stack_gray = zeros(size(image_stack_1));

    for i = 1:size(image_stack_1, 3)
        image_stack_gray(:,:,i) = cat(3, rgb2gray(cat(3, image_stack_1(:, :, i), image_stack_2(:, :, i), image_stack_3(:, :, i))));
    end
    [~, normals_gray] = estimate_alb_nrm(image_stack_gray, scriptV_rgb, false);
end
imshow(albedo_rgb)
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals_gray);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q ,'column');
height_map_1 = construct_surface( p, q ,'row');
height_map_2 = construct_surface( p, q ,'average');
subplot(3,1,1) 
surf(height_map)
title('Column wise Surface Map')
subplot(3,1,2) 
surf(height_map_1)
title('Row wise Surface Map')
subplot(3,1,3) 
surf(height_map_2)
title('Average wise Surface Map')

%% Display
show_results(albedo_rgb, normals_gray, SE);
show_model(albedo_rgb, height_map_2);


%% Face
[image_stack, scriptV] = load_face_images('D:\subj\cv1\Lab1_Photometric_Color\Lab1_Photometric_Color\photometric\photometrics_images\yaleB02\');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV,true);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q ,'column');
height_map_1 = construct_surface( p, q ,'row');
height_map_2 = construct_surface( p, q ,'average');


show_results(albedo, normals, SE);
show_model(albedo, height_map_2);

