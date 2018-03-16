function plot_matches(Ia,Ib,iter,p_percent)
    [fa, ~, fb, ~, matches, ~]=keypoint_matching(Ia,Ib);
    plot_sift_matches(Ia, Ib, fa, fb, matches, p_percent);
    [~,x,y,new_x,new_y] = ransac(fa, fb, matches,iter, p_percent);
    plot_best_transformation(x,y,new_x,new_y,Ia, Ib,p_percent);
end