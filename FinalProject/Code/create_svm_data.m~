function[file_name]=create_svm_data(image_hist_data,file_name,min_index,max_index)
tot_images=size(image_hist_data,1);
fileID = fopen(file_name,'w');
for i=1:tot_images
    str="";
    if(i>=min_index && i<=max_index)
        str=strcat(str,"+","1"," ");
    else
        str=strcat(str,"-","1"," ");
    end
    for j=1:size(image_hist_data,2)
        str=strcat(str,num2str(j),":",num2str(image_hist_data(i,j))," ");
    end
    str=strcat(str,"\n");
    fprintf(fileID,str);
end
fclose(fileID);
end 
