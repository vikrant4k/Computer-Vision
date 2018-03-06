%img=imread('pingpong/0000.jpeg');
im_number=1;
im_number=2;
pre='person_toy/0000000';
pre1='person_toy/000000'
pst='.jpg';
img = imread(strcat(pre,num2str(im_number),pst));
img_gray=rgb2gray(img);
%img=im2double(img);
[H,img_x,img_y]=harris_corner_detector(img_gray,1.5,5,1,5);
H_new=harris_local_maxima(H,70,600);
[h w]=size(H);
arr=zeros(40,2);
arr_count=1;
for i=1:h
    for j=1:w
        if(H_new(i,j)>0)
            arr(arr_count,1)=i;
            arr(arr_count,2)=j;
            arr_count=arr_count+1;
            img(i,j,1)=255;
            img(i,j,2)=0;
            img(i,j,3)=0;
        end
    end
end
for i=1:71
if(i<=8)
img1 = imread(strcat(pre,num2str(i),pst));
img2 = imread(strcat(pre,num2str(i+1),pst));
end
if(i==9)
img1 = imread(strcat(pre,num2str(i),pst));
img2 = imread(strcat(pre1,num2str(i+1),pst));
end
if(i>=10)
img1 = imread(strcat(pre1,num2str(i),pst));
img2 = imread(strcat(pre1,num2str(i+1),pst));
end
im1=rgb2gray(img1);
im2=rgb2gray(img2);
im1=im2double(im1);
im2=im2double(im2);
[u,v]=lucas_kanade_motion(im1,im2,15,arr);
imshow(img);
hold on;            
quiver(u,v,10,'blue')
saveas(gcf,strcat('vid/',num2str(i),'.png'));
end