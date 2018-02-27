function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        g = imfilter(image,gauss2D(0.5 , 5));
        h = fspecial('laplacian');
        imOut = imfilter(g,h);

    case 2
        %method 2
        log_filter = fspecial('log',5,0.5);
        imOut = imfilter(image,log_filter);
        

    case 3
        %method 3
        g1 = gauss2D(0.5/sqrt(2) , 5);
        g2 = gauss2D(sqrt(2)/0.5 , 5);
        imOut = imfilter(image,g1 -g2);


end
end

