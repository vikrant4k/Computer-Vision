real_image = imread('ball.png');
reflectance=imread('ball_reflectance.png');
shading=imread('ball_shading.png');
green_reflec=repmat(reflectance,1);
mage_reflec=repmat(reflectance,1);
r=0;
g=0;
b=0;
for i=1:266
    for j=1:480
        if reflectance(i,j,1)>0 
             green_reflec(i,j,1)=reflectance(i,j,1)-20;
             green_reflec(i,j,2)=reflectance(i,j,2)+60;
             green_reflec(i,j,3)=reflectance(i,j,3);
             mage_reflec(i,j,1)=reflectance(i,j,1)+20;
             mage_reflec(i,j,2)=reflectance(i,j,2)-20;
             mage_reflec(i,j,3)=reflectance(i,j,3)+20;
        end
    end
end
shading=im2double(shading);
real_image=im2double(real_image);
green_reflec=im2double(green_reflec);
mage_reflec=im2double(mage_reflec);
o1=green_reflec.*shading;
o2=mage_reflec.*shading;
subplot(1,3,1);
imshow(real_image);
subplot(1,3,2);
imshow(o1);
subplot(1,3,3);
imshow(o2);