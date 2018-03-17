clear all;
close all; 
clc;



[arr_dim,counter,arr_counter,img_count] = read_files();


%Histogram Creation for Images%
%% 

numClusters=600;
arr_dim=reshape(arr_dim,128,154130);
[centers, assignments] = vl_kmeans(arr_dim, numClusters, 'Initialization', 'plusplus') ;

%% 
img_hist_data=double(zeros(100*4,numClusters,'gpuArray'));
assig_count=1;
for i=1:img_count-1
    desc_count=arr_counter(i,1);
    for j=assig_count:assig_count+desc_count-1
        val=assignments(1,j);
        img_hist_data(i,val)=img_hist_data(i,val)+1;
    end
    assig_count=assig_count+desc_count;
end
%% 
%img_hist_data=gather(img_hist_data);
x_axis=zeros(numClusters,1);
y_axis=zeros(numClusters,1);
for i=1:numClusters
    x_axis(i,1)=i;
    y_axis(i,1)=img_hist_data(190,i);
end
%scatter(x_axis,y_axis)
%histogram(y_axis,1200)