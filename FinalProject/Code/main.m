clear all;
close all; 
clc;


%% please read this:

%for debuging i read from pre-saved file from preproccecing, to not run kmeans every time:
% if you prefer to generate online use this:
%[arr_dim,counter,arr_counter,img_count] =read_files();
tic;
filename = 'descriptors.mat';
data = matfile(filename);
whos -file descriptors.mat
arr_dim = data.arr_dim;
counter = data.counter;
arr_counter = data.arr_counter;
img_count = data.img_count;
toc;


%% Kmeans
numClusters=800;

tic;
[centers, assignments] = vl_kmeans(arr_dim, numClusters, 'Initialization', 'plusplus') ;
toc;


%% Histogram
img_hist_data=double(zeros(100*4,numClusters));%,'gpuArray'));
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
