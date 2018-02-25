function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    width=(kernel_size-1)/2;
    norm=1/(sigma*sqrt(2*pi));
    index=1;
    sum=0;
    for i=-width:width
        value=norm*exp(-((i*i)/(2*sigma*sigma)));
        G(1,index)=value;
        sum=sum+value;
        index=index+1;
    end
    for i=1:kernel_size
        G(1,i)=G(1,i)/sum;
    end
    
    
end
