function [ PSNR ] = myPSNR( orig_image, approx_image )
[h w]=size(orig_image);
sum=0;
for i=1:h
    for j=1:w
    diff=orig_image(i,j)-approx_image(i,j);
    diff=diff*diff;
    sum=sum+diff;
    end
end
mse=sum/(h*w);
rmse=sqrt(mse);
PSNR=20*log10(1/rmse);
end

