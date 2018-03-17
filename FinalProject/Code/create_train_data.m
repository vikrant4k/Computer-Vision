function[image_hist_train_data]=create_train_data(initial_index,numClusters,centers)
folders={'airplanes_train/','cars_train/','faces_train/','motorbikes_train/'};
    max_files=50;
    num_folders=4;
    pre_index='../Caltech4/ImageData/';
    file_type='.jpg';
    img_index='00';
    img_index_1='0';
    counter=1;
    image_hist_train_data=double(zeros(max_files*num_folders,numClusters));
    for i=1:4
        for j=initial_index:initial_index+max_files-1
            
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
            desc_size=size(da,2);
           for lo=1:desc_size  
           temp_arr = double(zeros(128,1));
           for li=1:128
             temp_arr(li,1)=da(li,lo);
           end
           [~, k] = min(vl_alldist(temp_arr, centers)) ;
           image_hist_train_data(counter,k)=image_hist_train_data(counter,k)+1;
           end
           counter=counter+1;
       end
    end
end