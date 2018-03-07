%img=imread('pingpong/0000.jpeg');
for l=99:103
pre='person_toy/0000000';
pre1='person_toy/000000';
pre2='person_toy/00000';
pst='.jpg';
if(l<=8)
img1 = imread(strcat(pre,num2str(l),pst));
img=imread(strcat(pre,num2str(l),pst));
img2 = imread(strcat(pre,num2str(l+1),pst));
end
if(l==9)
img1 = imread(strcat(pre,num2str(l),pst));
img=imread(strcat(pre,num2str(l),pst));
img2 = imread(strcat(pre1,num2str(l+1),pst));
end
if(l>=10 && l<=98)
img1 = imread(strcat(pre1,num2str(l),pst));
img=imread(strcat(pre1,num2str(l),pst));
img2 = imread(strcat(pre1,num2str(l+1),pst));
end
if(l>=99)
if(l==99)
img1 = imread(strcat(pre1,num2str(l),pst));
img=imread(strcat(pre1,num2str(l),pst));
else
img1 = imread(strcat(pre2,num2str(l),pst));
img=imread(strcat(pre2,num2str(l),pst));
end
img2 = imread(strcat(pre2,num2str(l+1),pst));
end
%img = imread('person_toy/00000001.jpg');
img_gray=rgb2gray(img);
%img=im2double(img);
[H,~,~]=harris_corner_detector(img_gray,1.5,5,1,5);
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
im1=rgb2gray(img1);
im2=rgb2gray(img2);
im1=im2double(im1);
im2=im2double(im2);
[u,v]=lucas_kanade_motion(im1,im2,15,arr);
imshow(img);
hold on;            
quiver(u,v,10,'blue')
saveas(gcf,strcat('vid/',num2str(l),'.png'));
clearvars  -except l
end
