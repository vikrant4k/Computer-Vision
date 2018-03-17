function [min_key_points, min_da_size] = find_min_da_size(path)
    files = dir(path);
    min_key_points = inf;
    min_da_size = [];
    for i = 1:length(files)-1 
        file_name = files(i).name;
        if contains(file_name, '.jpeg') || contains(file_name, '.jpg')
            Ia = imread(strcat(path, file_name));
            %imshow(Ia)
            [~, da] = feature_extraction(Ia);
            if size(da,2)< min_key_points
                min_key_points = size(da,2);
                min_da_size = size(da);
            end
        end
    end
end