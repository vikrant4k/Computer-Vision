im= im2double(imread('images/image2.jpg'));
[Gx, Gy, im_magnitude,im_direction] = compute_gradient(im);
figure(1)
subplot(2,2,1); imshow(Gx),title(sprintf('Gx'));
subplot(2,2,2); imshow(Gy),title(sprintf('Gy'));
subplot(2,2,3); imshow(im_magnitude),title(sprintf('magnitude'));
subplot(2,2,4); imshow(im_direction),title(sprintf('direction'));

saveas(figure(1), 'first_order_derivative_filter.png');
