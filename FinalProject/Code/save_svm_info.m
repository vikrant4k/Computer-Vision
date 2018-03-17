function save_svm_info(image_hist_data,num_files,class_index,file_name)
    tic;
    %filename = 'svm.mat';
    save(filename,'image_hist_data','num_files','class_index','-v7.3');        
    toc;
end