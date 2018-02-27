im= im2double(imread('images/image2.jpg'));
LOG_type = {'Laplacian','LoG','DoG'}
figure(1)
for i= 1:3
    imOut= compute_LoG(im,i);
    subplot(1,3,i); imshow(imOut), title(sprintf('%s',LOG_type{i}));
end
saveas(figure(1), 'Laplacian_LoG_DoG.png');
