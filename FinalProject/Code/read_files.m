function [arr_dim] =read_files()
    folders={'airplanes_train/','cars_train/','faces_train/','motorbikes_train/'};
    max_files=400;
    pre_index='../Caltech4/ImageData/';
    file_type='.jpg';
    img_index='00';
    img_index_1='0';
    counter=1;
    arr_dim=double(zeros(1280000,128));
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
            image_name=convertStringsToChars(image_name);
            im=imread(image_name);

            [~, da] = feature_extraction(im);
            size_descrip=size(da,2);
            da=reshape(da,size_descrip,128);
            for k=1:size_descrip
                counter=counter+1;
                for o=1:128
                    arr_dim(counter,o)=da(k,o);
                end
            end
        end
    end

  
end