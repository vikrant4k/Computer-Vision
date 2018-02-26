orig_image=imread('images\image2.jpg');
orig_image=im2double(orig_image);
[Gx, Gy, im_magnitude,im_direction]=compute_gradient(orig_image);

