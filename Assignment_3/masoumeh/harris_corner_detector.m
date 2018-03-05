function[H,Ix, Iy]=harris_corner_detector(im,sigma, filter_size, w_sigma , w_filter_size )

    G=gauss1D( sigma , filter_size );%
    %G= fspecial('gaussian',[filter_size filter_size], sigma)
    Gx=gradient(G);
    Gy=gradient(reshape(G,filter_size,1));

    %[Gx,Gy] = gradient(G)
    size(Gx);
    size(im);
    Ix = conv2(im,Gx,'same');
    Iy = conv2(im,Gy,'same');

    %G2=fspecial('gaussian',[5 5], 1);
    G2 = gauss2D( w_sigma , w_filter_size);
    A = imfilter((Ix .^ 2),G2, 'conv');
    C = imfilter((Iy .^ 2),G2, 'conv');
    B = imfilter((Ix .* Iy),G2, 'conv');

    H = (A .* C) - (B .^ 2) - (0.04 * ((A + C) .^ 2));
    %figure(10)
    %imshow(H)

end