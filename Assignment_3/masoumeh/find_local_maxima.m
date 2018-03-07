%function[corner_rows, corner_coloumns] = find_local_maxima(H,n,threshold)
function [r,c,corner_points] = find_local_maxima(H,n,threshold)
pad_size = floor(n/2);
padded_H = padarray(H,[pad_size pad_size],-inf);
[r_size,c_size] = size(padded_H);

%{
hLocalMax = vision.LocalMaximaFinder;
hLocalMax.MaximumNumLocalMaxima = 10 ;
hLocalMax.NeighborhoodSize = [n n];
hLocalMax.Threshold = -1;
location = step(hLocalMax, padded_H)
%}
size(H)
corner_points = zeros(size(H));
size(corner_points)
r = [];
c = [];
for i = 1 + pad_size : r_size - pad_size
    for j = 1 + pad_size : c_size - pad_size
        if (padded_H(i,j) > threshold)
            sub_H = padded_H([i - pad_size: i + pad_size],[j - pad_size: j + pad_size]);
            if(padded_H(i,j) == max(max(sub_H)))
                corner_points(i-pad_size, j - pad_size) = padded_H(i,j);
                c = [c j-pad_size];
                r = [r i-pad_size];
            end
        end
    end
end


