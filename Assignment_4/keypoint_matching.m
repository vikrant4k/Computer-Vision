function [fa, da, fb, db, matches, scores]=keypoint_matching(Ia,Ib)


%size(Ia)

if length(size(Ia)) == 3
    Ia1 =  im2single(rgb2gray(Ia));
else
    Ia1 =  im2single(Ia);
end


if length(size(Ib)) == 3
    Ib1 =  im2single(rgb2gray(Ib));
else
    Ib1 =  im2single(Ib);
end

%Ia1 =  single(rgb2gray(Ia));
%Ib1 = single(rgb2gray(Ib));

[fa, da] = vl_sift(Ia1) ;
[fb, db] = vl_sift(Ib1) ;
[matches, scores] =  vl_ubcmatch(da, db) ;%vl_ubcread(da,db);




