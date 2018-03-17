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
img_hist_data=gather(img_hist_data);
x_axis=zeros(numClusters,1);
y_axis=zeros(numClusters,1);
for i=1:numClusters
    x_axis(i,1)=i;
    y_axis(i,1)=img_hist_data(190,i);
end
%scatter(x_axis,y_axis)
%histogram(y_axis,1200)
%% 
image_hist_train_data=create_train_data(101,numClusters,centers);
image_hist_test_data=create_train_data(151,numClusters,centers);
%% 
file_train_name=create_svm_data(image_hist_train_data,'train.txt');
file_test_name=create_svm_data(image_hist_test_data,'test.txt');
%% 
dirData = '/home/vik1/Downloads/subj/cv/github/Computer-Vision/FinalProject/Code/'; 
[image_train_label, image_train_data] = libsvmread(fullfile(dirData,'train.txt'));
model=train(image_train_label,image_train_data, '-c 1 ');
%% 
[image_test_label, image_test_data] = libsvmread(fullfile(dirData,'test.txt'));
[predictions,accuracy,~]=predict(image_test_label, image_test_data,model);
