function plot_best_transformation(x,y,new_x,new_y,Ia, Ib,p_percent)
    figure ; clf ;
    imshow(cat(2, Ia, Ib)) ;
    
        
    p_size = round(p_percent * length(x));
    perm = randperm(length(x));
    sel = perm(1:p_size);
    x = x(sel); 
    y = y(sel); 
    new_x = new_x(sel) + size(Ia,2); 
    new_y = new_y(sel); 
    
    hold on ;
    h = line([x; new_x], [y; new_y]) ;
    set(h,'linewidth', 1, 'color', 'y') ;
    plot(x, y,'gO', 'MarkerSize', 10);
    plot(new_x, new_y,'gO', 'MarkerSize', 10);
    axis image off ;
    hold off;
    title([num2str(100*p_percent), 'percent of Matches found by best transformation'])
    saveas(gcf,"best_transformation_matches.png")
end