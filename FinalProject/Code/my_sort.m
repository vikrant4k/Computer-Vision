function [images_name, probs] = my_sort(images_name, probs)
    n = length(images_name);
    for i = 1:n
        for j = i:n-1
            if probs(j)<probs(j+1)
                [probs(j+1) probs(j)] = deal(probs(j), probs(j+1));
                [images_name(j+1) images_name(j)] = deal(images_name(j), images_name(j+1));
            end
        end
    end
end