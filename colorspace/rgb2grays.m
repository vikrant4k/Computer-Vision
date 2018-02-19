function [output_image] = rgb2grays(input)
% converts an RGB into grayscale by using 4 different methods
output_image=zeros(384,512,4);
for i=1:384
    for j=1:512
        r=input(i,j,1);
        g=input(i,j,2);
        b=input(i,j,3);
        o1=(max(input(i,j))+min(input(i,j)))/2;
        o2=(r+g+b)/3;
        o3=0.21*r+0.72*g+0.07*b;
        o4=0.2989 * r + 0.5870 * g + 0.1140 * b;
        output_image(i,j,1)=o1;
        output_image(i,j,2)=o2;
        output_image(i,j,3)=o3;
        output_image(i,j,4)=o4;
    end
end
% ligtness method

% average method
 
% luminosity method

% built-in MATLAB function 

 
end

