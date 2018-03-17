function [arr_dim,counter,arr_counter,img_count] =read_files()
    folders = {'airplanes_train/','cars_train/','faces_train/','motorbikes_train/'};
    max_files=100;
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
                counter = counter + 1; % why we need this?
                img_count = img_count + 1; % why we need this?
                
            end
        end
    end
    


    %{
    file_type='.jpg';
    img_index='00';
    img_index_1='0';
    
    counter=1;
    
    length(folders)
    arr_dim=[];%double(zeros(1280000,128));
    
    for i=1:length(folders)
        for j=1:max_files
            image_name='img';
            if(j>0 && j<10)
                image_name=strcat(image_name,img_index,num2str(j));
            else
                if(j>=10 && j<100)
                     image_name=strcat(image_name,img_index_1,num2str(j));
                else
                     image_name=strcat(image_name,num2str(j));
                end
            end
            val=string(folders(i));
            image_name=strcat(pre_index,val,image_name,file_type);
            image_name=convertStringsToChars(image_name);
            im=imread(image_name);

            [~, da] = feature_extraction(im);  
            %size(double(da))
            %size(da)
            arr_dim = [arr_dim, double(da)];
            %size(arr_dim)

        end
    end

  %}
end