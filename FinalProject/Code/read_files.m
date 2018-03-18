function [arr_dim,counter,arr_counter,img_count] =read_files(type_data)
    folders = {'airplanes_train/','cars_train/','faces_train/','motorbikes_train/'};
    max_files= 20 ;
    pre_index='../Caltech4/ImageData/';
    arr_dim = [];
    
    img_count=1;
    arr_counter = [];
    counter = 0;
    img_count = 0;
    
    length(folders)
    for i=1:length(folders)
        path = strcat(pre_index, folders{i})
        files = dir(path);
        file_iter = min(max_files + 3,length(files));                 
        for j = 1:file_iter
            file_name = files(j).name           
            if contains(file_name, '.jpeg') || contains(file_name, '.jpg') || contains(file_name, '.png')

                im =  imread(strcat(path,file_name));
                [~, da] = feature_extraction(im);  
                %size(double(da))
                %size(da)
                arr_dim = [arr_dim, double(da)];
                arr_counter = [arr_counter;size(da,2)];
                
                
                %%%%%%%% please read this:
                %%%%%%%% this two are literaly one thing:
                
                counter = counter + 1; % why we need this?
                img_count = img_count + 1; % why we need this?
                
            end
        end
    end
    

end