function G = gauss1D( sigma , kernel_size )

    G = zeros(1, kernel_size);    
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on');
    end
    
    X = (-1)*floor(kernel_size/2) : floor(kernel_size/2);
    G = (1 / (sigma * sqrt(2*pi)))* exp(-1*(X.^2) / (2* (sigma^2))); 
    
    G = G ./ sum(G);

end
