function [ PSNR ] = myPSNR( orig_image, approx_image )
    mse = mean2((orig_image - approx_image) .^ 2);
    imax = max(max(orig_image));
    PSNR = 20 * log10(imax/sqrt(mse));
end

