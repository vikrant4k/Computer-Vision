function [histograms] = extract_histograms(centers, images_path)
    histograms = zeros(length(images_path), length(centers));
    for i = 1: length(images_path)
        image = imread(strcat('../Caltech4/ImageData/',images_path{i},'.jpg'));
        [~, da] = feature_extraction(image); 
        for j = 1: size(da, 2)
            [~, k] = min(vl_alldist(double(da(:,j)), centers));
            histograms(i, k) = histograms(i, k) + 1;
        end
        %normalize the histogram just extracted
        histograms(i, :) = histograms(i, :)/(sum(histograms(i,:))+0.0001); 
    end       
end