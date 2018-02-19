
function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal
[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end


% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);
g=zeros(h,w,3);
arr=zeros(5,1);
for i =1:h
    for j=1:w
        for k=1:5
            arr(k,1)=image_stack(i,j,k);
        end
        I=zeros(5,5);
        for p=1:5
            I(p,p)=arr(p,1);
        end
        I1=I*arr;
        scrip=I*scriptV;
        tem=linsolve(scriptV,arr);
        le=length(tem);
        for p=1:le
            g(i,j,p)=tem(p);
        end
        arr=zeros(5,1);
    end
end
ar=zeros(3);
for i=1:h
    for j=1:w
        for k=1:3
            ar(k)=g(i,j,k);
            normal(i,j,k)=g(i,j,k);
        end
        nor=norm(ar);
        albedo(i,j,1)=nor;
        for l=1:3
            if nor~=0
                normal(i,j,l)=normal(i,j,l)/nor;
            end
        end
        ar=zeros(3);
    end
end
% ======================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|



% =========================================================================

end
