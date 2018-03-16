function [min_dim,avg_dim] =read_files()
    folders={'airplanes_train/','cars_train/','faces_train/','motorbikes_train/'};
    max_files=200;
    pre_index='../Caltech4/ImageData/';
    file_type='.jpg';
    img_index='00';
    img_index_1='0';
    min_dim = inf;
    avg_dim = 0;
    counter = 0;
    for i=1:4
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
            image_name=convertStringsToChars(image_name)
            im=imread(image_name);

            [~, da] = feature_extraction(im);
            if size(da,2)< min_dim
                min_dim = size(da,2);
                %min_da_size = size(da);            
            end
            avg_dim = avg_dim + size(da,2);
            counter = counter + 1;
        end
    end

    avg_dim = double(avg_dim)/counter;
end