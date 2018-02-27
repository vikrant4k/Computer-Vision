clc
close all
im_gauss = im2double(imread('images/image1_gaussian.jpg'));
im_salt = im2double(imread('images/image1_saltpepper.jpg'));
orig = im2double(imread('images/image1.jpg'));

denoised = cell(2, 2, 3);
ks = [3, 5, 7];
filter = {'box'; 'median'};
for f=1:2
    for k=1:3
        denoised{1, f, k} = denoise(im_salt, filter{f}, ks(k));
        denoised{2, f, k} = denoise(im_gauss, filter{f}, ks(k));
    end
end



figure (1);
for f=1:2
    for k=1:3
        subplot(2,3,k+(f-1)*3), imshow(denoised{1, f, k},[]), title(sprintf('%s , %d * %d',filter{f},ks(k),ks(k)));
    end
end
saveas(figure(1), 'salt_denoising.png');

figure (2);
for f=1:2
    for k=1:3
        subplot(2,3,k+(f-1)*3), imshow(denoised{2, f, k},[]), title(sprintf('%s , %d * %d',filter{f},ks(k),ks(k)));
    end
end
saveas(figure(2), 'gauss_denoising.png');

psnr = zeros(2,2,3);
for f=1:2
    for k=1:3
        psnr(1, f, k) = myPSNR(orig, denoised{1, f, k});
        psnr(2, f, k) = myPSNR(orig, denoised{2, f, k});
    end
end

im = {'salt', 'gauss'};
filter = {'box'; 'median'};
for i=1:2
    fprintf("%s---------\n", im{i});
    for f=1:2
        fprintf("%s:\t", filter{f});
        for k=1:3
            fprintf("%f ", psnr(i, f, k));
        end
        fprintf("\n");
    end
    fprintf("\n");
end

