function [fa, da] = feature_extraction(Ia)

if length(size(Ia)) == 3
    Ia1 =  im2single(rgb2gray(Ia));
else
    Ia1 =  im2single(Ia);
end

[fa, da] = vl_sift(Ia1) ;

end