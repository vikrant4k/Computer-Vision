clear all;
close all; 
clc;

folder_name = '../pingpong/';
files = dir(folder_name);


haris_filter_sigma = 1.5;
haris_filter_size = 5;
w_sigma = 1;
w_filter_size = 5;
% for pingpong n = 15 trhld = 15*255
%for person toy n = 20 trhld = 8*255
n = 20;
threshold = 8*255;

lk_sigma = 1.5;
lk_filter_size = 3;
slice_size = 15;

for i = 1:length(files)-1 
    file_name = files(i).name;
    if contains(file_name, '.jpeg') || contains(file_name, '.jpg')
        
        original_image = imread(strcat(folder_name, file_name));
        moved_image = imread(strcat(folder_name, files(i+1).name));
        [~,~, ~,r,c,~] = harris_corner_detector(original_image,haris_filter_sigma, haris_filter_size, w_sigma , w_filter_size,n,threshold);
        
        %{
        figure(1), subplot(1,3,3), imshow(original_image); hold on; plot(c, r,'o', 'MarkerSize', 5); hold off;title('corners')
        subplot(1,3,1), imshow(Ix);title('Ix');
        subplot(1,3,2), imshow(Iy);title('Iy');
        pause(1)
        %}
        
        
        img_1 = im2double(original_image);
        img_2 = im2double(moved_image);
        [h, w] = size(img_1);
        Gx = gradient(fspecial('gauss', [1, lk_filter_size], lk_sigma));
        Gy = gradient(fspecial('gauss', [lk_filter_size, 1], lk_sigma));
        Ix = imfilter(img_1, Gx,'conv');
        Iy = imfilter(img_1, Gy,'conv');
        
        u = [];
        v = [];
        %u = zeros(h,w);
        %v = zeros(h,w);
        
        for corners = 1:length(r)
            
            % calculate patch coordination
            pr = r-floor(slice_size/2):r+floor(slice_size/2);
            patch_r = pr(pr>0 & pr<=h);
            pw = c-floor(slice_size/2):c+floor(slice_size/2);
            patch_c = pw(pw>0 & pw<=w);
            
            patch_of_1 = img_1(patch_r,patch_c);
            patch_of_2 = img_2(patch_r,patch_c);
            patch_ix = Ix(patch_r,patch_c);
            patch_iy = Iy(patch_r,patch_c);
            solution = lucas_kanade(patch_of_1,patch_of_2, patch_ix, patch_iy);
            %u(r(corners), c(corners)) = solution(1);
            %v(r(corners), c(corners)) = solution(2);
            u = [u solution(1)]
            v = [v solution(1)]
            
        end
        
        figure(1);
        imshow(original_image);  
        hold on;
        quiver(c,r , u, v, 1/5, 'red')
        %quiver(u, v,10, 'red')
        pause(0.5)
    end
end