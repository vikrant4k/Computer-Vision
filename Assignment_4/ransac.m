function [best_transformation,xa_T,ya_T,rounded_x_estimation,rounded_y_estimation] = ransac(fa, fb, matches,iter, p_percent)

    xa_T = fa(1,matches(1,:)) ;    
    ya_T = fa(2,matches(1,:)) ;

    xb_T = fb(1,matches(2,:)) ;
    yb_T = fb(2,matches(2,:)) ; 
    
    max_inlier = 0;
    best_transformation = [];
    best_x_estimation = [];
    best_y_estimation = [];
    for j = 1:iter

        p_size = round(p_percent * size(matches,2));
        perm = randperm(size(matches,2));
        sel = perm(1:p_size);
        sub_matches = matches(:, sel);

        x = find_transformation(fa, fb, sub_matches);

        estimated_xb = [];
        estimated_yb = [];
        for i = 1:size(xa_T,2)
            A_T = [xa_T(i), ya_T(i), 0, 0, 1, 0; 0, 0, xa_T(i), ya_T(i), 0, 1] ;
            %b = [xb_T(i);yb_T(i)];
            y_T = A_T * x;

            estimated_xb = cat(2, estimated_xb, y_T(1));
            estimated_yb = cat(2, estimated_yb, y_T(2));

        end

        err = sqrt((estimated_yb - yb_T).^2 + (estimated_xb - xb_T).^2);
        inliers = length(err(err < 10));

        if inliers > max_inlier
            max_inlier = inliers;
            best_transformation = x;
            best_x_estimation = estimated_xb;
            best_y_estimation = estimated_yb;
        end

    end
    %disp(best_transformation);
    %disp(max_inlier);

    total_keypoints_num = size(matches,2);
    %disp("transformation accuracy before rounding the coordinations:")
    %disp(max_inlier / total_keypoints_num);

    rounded_x_estimation = round(best_x_estimation);
    rounded_y_estimation = round(best_y_estimation);

    %disp(rounded_x_estimation(1:10))
    %disp(best_x_estimation(1:10))

    err = sqrt((rounded_y_estimation - yb_T).^2 + (rounded_x_estimation - xb_T).^2);
    inliers = length(err(err < 10));
    
    disp("transformation accuracy after rounding the coordinations:")
    disp(inliers / total_keypoints_num);


end

