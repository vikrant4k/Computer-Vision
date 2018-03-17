% preprocessing: 
tic;
filename = 'descriptors.mat';
[arr_dim,counter,arr_counter,img_count] =read_files();
size(arr_dim)
save(filename,'arr_dim','counter','arr_counter','img_count','-v7.3');
toc;