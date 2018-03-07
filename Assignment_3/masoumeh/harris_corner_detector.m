function[H,Ix, Iy,r,c,corner_points]=harris_corner_detector(original_image,sigma, filter_size, w_sigma , w_filter_size, n,threshold)

    if length(size(original_image)) == 3
        im = rgb2gray(original_image);
    else
        im = original_image;
    end
    
    G=gauss1D( sigma , filter_size );
    Gx=gradient(G);
    Gy=gradient(reshape(G,filter_size,1));
    size(Gx);
    size(im);
    Ix = conv2(im,Gx,'same');
    Iy = conv2(im,Gy,'same');
   
    G2 = gauss2D( w_sigma , w_filter_size);
    A = imfilter((Ix .^ 2),G2, 'conv');
    C = imfilter((Iy .^ 2),G2, 'conv');
    B = imfilter((Ix .* Iy),G2, 'conv');

    H = ((A .* C) - (B .^ 2) - (0.04 * ((A + C) .^ 2)));
    [r,c,corner_points] = find_local_maxima(H,n,threshold);

end