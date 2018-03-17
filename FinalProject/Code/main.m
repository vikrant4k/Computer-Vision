clear all;
close all; 
clc;



[arr_dim,counter,arr_counter,img_count] = read_files();


%Histogram Creation for Images%
%% 

numClusters=600;
arr_dim=reshape(arr_dim,128,counter);
[centers, assignments] = vl_kmeans(arr_dim, numClusters, 'Initialization', 'plusplus') ;

%% 
img_hist_data=double(zeros(img_count-1,numClusters,'gpuArray'));
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
max_train_files=200;
max_test_files=50;
image_hist_train_data=create_train_data(201,numClusters,centers,max_train_files,"train");
image_hist_test_data=create_train_data(1,numClusters,centers,max_test_files,"test");
%% 
file_train_airplane_name=create_svm_data(image_hist_train_data,'train_airplane.txt',1,max_train_files);
file_test_airplane_name=create_svm_data(image_hist_test_data,'test_airplane.txt',1,max_test_files);

file_train_cars_name=create_svm_data(image_hist_train_data,'train_cars.txt',max_train_files+1,max_train_files*2);
file_test_cars_name=create_svm_data(image_hist_test_data,'test_cars.txt',max_test_files+1,max_test_files*2);

file_train_faces_name=create_svm_data(image_hist_train_data,'train_faces.txt',max_train_files*2 +1,max_train_files*3);
file_test_faces_name=create_svm_data(image_hist_test_data,'test_faces.txt',max_test_files*2 +1,max_test_files*3);

file_train_bikes_name=create_svm_data(image_hist_train_data,'train_bikes.txt',max_train_files*3 +1 ,max_train_files*4);
file_test_bikes_name=create_svm_data(image_hist_test_data,'test_bikes.txt',max_test_files*3 +1,max_test_files*4);

%% 
dirData = '/home/vik1/Downloads/subj/cv/github/Computer-Vision/FinalProject/Code/'; 
[image_train_label, image_train_data] = libsvmread(fullfile(dirData,'train_airplane.txt'));
model_airplane=train(image_train_label,image_train_data, '-c 1 -s 2');

[image_train_label, image_train_data] = libsvmread(fullfile(dirData,'train_cars.txt'));
model_cars=train(image_train_label,image_train_data, '-c 1 -s 2');

[image_train_label, image_train_data] = libsvmread(fullfile(dirData,'train_faces.txt'));
model_faces=train(image_train_label,image_train_data, '-c 1 -s 2');

[image_train_label, image_train_data] = libsvmread(fullfile(dirData,'train_bikes.txt'));
model_bikes=train(image_train_label,image_train_data, '-c 1 -s 2');
%% 
[image_test_label, image_test_data] = libsvmread(fullfile(dirData,'test_airplane.txt'));
[predictions_airplane,accuracy_airplane,~]=predict(image_test_label, image_test_data,model_airplane);

[image_test_label, image_test_data] = libsvmread(fullfile(dirData,'test_cars.txt'));
[predictions_cars,accuracy_cars,~]=predict(image_test_label, image_test_data,model_cars);

[image_test_label, image_test_data] = libsvmread(fullfile(dirData,'test_faces.txt'));
[predictions_faces,accuracy_faces,~]=predict(image_test_label, image_test_data,model_faces);

[image_test_label, image_test_data] = libsvmread(fullfile(dirData,'test_bikes.txt'));
[predictions_bikes,accuracy_bikes,~]=predict(image_test_label, image_test_data,model_bikes);
