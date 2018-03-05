function[H,img_x,img_y]=harris_corner_detector(image,sigma1,k_size1,sigma2,k_size2)
g_row=gauss1D(sigma1,k_size1);
g_col=gauss1D(sigma1,k_size1);
g_col=reshape(g_col,k_size1,1);
gx=gradient(g_row)
gy=gradient(g_col);
img_x=conv2(image,gx,'same');
img_y=conv2(image,gy,'same');
ix_ix=img_x.*img_x;
iy_iy=img_y.*img_y;
ix_iy=img_x.*img_y;
guass_2=gauss2D(0.5,3);
A=conv2(ix_ix,guass_2,'same');
B=conv2(ix_iy,guass_2,'same');
C=conv2(iy_iy,guass_2,'same');
first_part=(A.*C-(B.*B));
second_part=0.04*((A+C).*(A+C));
H=first_part-second_part;
end
