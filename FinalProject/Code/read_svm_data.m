function read_svm_data(filename)
    %filename = 'svm.mat';
    data = matfile(filename);
    %whos -file svm.mat      
    image_hist_data = data.image_hist_data;
    num_files = data.num_files;
    class_index = data.class_index;
end