function stitch_images(I_right,I_left,iter,p_percent);
    [f_right, ~, f_left, ~, matches, ~]=keypoint_matching(I_right,I_left);
    [right_best_transformation,~,~,~,~] = ransac(f_right, f_left, matches,iter, p_percent);
    figure
    stitch(I_right,I_left,right_best_transformation)
end