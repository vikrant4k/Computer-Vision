function convert_image(Ia,Ib,iter,p_percent,which_photo)
    [fa, ~, fb, ~, matches, ~]=keypoint_matching(Ia,Ib);
    [best_transformation,~,~,~,~] = ransac(fa, fb, matches,iter, p_percent);
    generated_img = generate_transformed_image(Ia, best_transformation);
    
    figure;imshow(generated_img);   
    title(['transformed image from ',which_photo, ' image with best found transformation by ransac'])        
    saveas(gcf,strcat(which_photo,"_generated_image.png")) ;
        
        
    pause(1)
    denoised_img = medfilt2(generated_img);
    figure;imshow(denoised_img);
    title(['denoised image of transformed image from ',which_photo, ' image with best found transformation by ransac'])        
    saveas(gcf,strcat(which_photo,"_denoised_generated_image.png"));
    pause(1)
    
    %using matlab built in functions to generate transformed image
    w = [best_transformation(1),best_transformation(2);best_transformation(3),best_transformation(4)];
    t = [best_transformation(5);best_transformation(6)];
    w_inv = w .* (- ones(length(w)) + 2 * eye(length(w)));
    t_inv = maketform('affine', [w_inv ; t']);
    matlab_img = imtransform(im2double(Ia),t_inv, 'nearest');
    figure; imshow(matlab_img)   
    title(['transformed image from ',which_photo, ' image with matlab imtransform function'])        
    saveas(gcf,strcat(which_photo,"_matlab_transformed_image.png"));
end