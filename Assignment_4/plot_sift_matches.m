function plot_sift_matches(Ia, Ib, fa, fb, matches,p_percent)    
    p_size = round(p_percent * size(matches,2));
    perm = randperm(size(matches,2));
    sel = perm(1:p_size);
    sub_matches = matches(:, sel);   
    
    imshow(cat(2, Ia, Ib)) ;

    xa = fa(1,sub_matches(1,:)) ;    
    ya = fa(2,sub_matches(1,:)) ;
    
    xb = fb(1,sub_matches(2,:)) + size(Ia,2) ;    
    yb = fb(2,sub_matches(2,:)) ;

    hold on ;
    h = line([xa ; xb], [ya ; yb]) ;
    set(h,'linewidth', 1, 'color', 'b') ;

    vl_plotframe(fa(:,sub_matches(1,:))) ;
    fb(1,:) = fb(1,:) + size(Ia,2) ;
    vl_plotframe(fb(:,sub_matches(2,:))) ;
    axis image off ;
    
    title([num2str(100*p_percent), ' percent of sift detected matches'])
    saveas(gcf,"sift_matches.png")
end