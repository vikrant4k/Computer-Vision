clear all;
close all; 
clc;


if exist('vid/toy/','dir') ~= 7
    mkdir 'vid/toy/'
end
if exist('vid/pingpong/','dir') ~= 7
    mkdir 'vid/pingpong/'
end


folder_name = 'pingpong'
path = strcat(folder_name , '/')
files = dir(path)


haris_filter_sigma =2;
haris_filter_size = 7;%5;
w_sigma = 1;
w_filter_size = 5;
% for pingpong n = 15 trhld = 15*255
%for person toy n = 20 trhld = 8*255
n = 20;
threshold = 15*255;

lk_sigma = 1;%1.5;
lk_filter_size = 9;%3;

%for toy 17 is best
slice_size = 17;
r = [];
c = [];
is_it_first_frame = 0;
for i = 1:length(files)-1 
    file_name = files(i).name;
    if contains(file_name, '.jpeg') || contains(file_name, '.jpg')
        is_it_first_frame = is_it_first_frame + 1;
        
        original_image = imread(strcat(path, file_name));
        moved_image = imread(strcat(path, files(i+1).name));
        
        %-------we do corner detection by haris just for first frame:------
        %if (mod(is_it_first_frame,5) == 1)
        if (is_it_first_frame == 1)
            [~,~,~,r,c,~]=harris_corner_detector(original_image,haris_filter_sigma,haris_filter_size,w_sigma,w_filter_size,n, threshold);
            %[~,~, ~,r,c,~] = harris_corner_detector(original_image,haris_filter_sigma, haris_filter_size, w_sigma , w_filter_size,n,threshold);
        end
        
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
        u_temp=[];
        v = [];
        %u = zeros(h,w);
        %v = zeros(h,w);
        
        for corners = 1:length(r)

            % calculate patch coordination
            pr = round(r(corners))-floor(slice_size/2):round(r(corners))+floor(slice_size/2);% = -4:11
            patch_r = pr(pr>0 & pr<=h);
            pw = round(c(corners))-floor(slice_size/2):round(c(corners))+floor(slice_size/2);
            patch_c = pw(pw>0 & pw<=w);
            
            patch_of_1 = img_1(patch_r,patch_c);
            %{
            Gx = gradient(fspecial('gauss', [1, lk_filter_size], lk_sigma));
            Gy = gradient(fspecial('gauss', [lk_filter_size, 1], lk_sigma));
            Ix = imfilter(patch_of_1, Gx,'conv');
            Iy = imfilter(patch_of_1, Gy,'conv');
            %}
            
            
            [Ix, Iy] = imgradientxy(patch_of_1);
            patch_of_2 = img_2(patch_r,patch_c);
            
            %patch_ix = Ix(patch_r,patch_c)
            %patch_iy = Iy(patch_r,patch_c)
            
            solution = lucas_kanade(patch_of_1,patch_of_2, Ix,Iy);
            %solution = lucas_kanade(patch_of_1,patch_of_2, patch_ix,patch_iy);
            if (solution(1) == 0)
                new_vx = 0;
                new_vy = 1*sign(solution(2));
            else
                theta = atan(solution(2)/solution(1));
                new_vx = -20*cos(theta);
                new_vy = -20*sin(theta);                
            end
            
            %u = [u new_vx];
            %v = [v new_vy];
            
            u = [u 200*solution(1)]%Vx
            v = [v 200*solution(2)];%Vy
            size(u)
            size(v)
            r(corners) = r(corners) + 12*solution(2);%y + vy
            c(corners) = c(corners) + 12*solution(1);%x + vx
            
            
            disp(file_name)
            
        end
        
        figure(1);
        imshow(original_image);  
        hold on;
        plot(c, r,'bo', 'MarkerSize', 5);
        
        %u_temp = 100*u%u/abs(u);
        q = quiver(c,r , u, v,'red');
        q.AutoScale = 'off';
        
        %quiver(u, v,10, 'red')
        %pause(0.5)
        saveas(figure(1), [ 'vid/pingpong/' num2str(is_it_first_frame) '.png']);
    end
end



