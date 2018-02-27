clc
close all
im_gauss = im2double(imread('images/image1_gaussian.jpg'));
%im_salt = im2double(imread('images/image1_saltpepper.jpg'));
orig = im2double(imread('images/image1.jpg'));


sigma = [0.5, 1, 2];
denoised = cell(3, 3);
ks = [3, 5, 7];
for s=1:3
    for k=1:3
    denoised{s, k} = denoise(im_gauss, 'gaussian', ks(k), sigma(s));
    end
end

figure (1);
for s=1:3
    for k=1:3
        subplot(3,3, k+(s-1)*3), imshow(denoised{s, k},[]),title(sprintf('%.2f , %d * %d',sigma(s),ks(k),ks(k)));
    end
end
saveas(figure(1), 'gauss_gauss_denoise.png');


psnr = zeros(3,3);
for s=1:3
    for k=1:3
        psnr(s, k) = myPSNR(orig, denoised{s, k});
    end
end

disp('psnr(sigma,kernel size):')
disp(psnr)


