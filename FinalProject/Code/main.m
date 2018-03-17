clear all;
close all; 
clc;



arr_dim = read_files();
numClusters=800;
arr_dim=reshape(arr_dim,128,1280000);
[centers, assignments] = vl_kmeans(arr_dim, numClusters, 'Initialization', 'plusplus') ;


%Histogram Creation for Images%

%% 
img_hist_data=double(zeros(1600,numClusters));
le=size(assignments,2);
counter=1;
for i=1:le-1
    if(mod(i,800)==0)
        counter=counter+1;
    end
    val=assignments(1,i);
    img_hist_data(counter,val)=img_hist_data(counter,val)+1;
end