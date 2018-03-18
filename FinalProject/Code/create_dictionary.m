function [centers] =create_dictionary(images_path, num_clusters, sift_type, color_space)
    total_desc = [];
    for i = 1: length(images_path)
        image = imread(strcat('../Caltech4/ImageData/',images_path{i},'.jpg'));
        [~, da] = feature_extraction(image);  
        total_desc = [total_desc, double(da)];
    end
    
    
    tic;
    [centers, assignments] = vl_kmeans(total_desc, num_clusters, 'Initialization', 'plusplus') ;
    toc;
    
end