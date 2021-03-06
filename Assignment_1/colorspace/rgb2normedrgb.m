function [output_image] = rgb2normedrgb(input)
% converts an RGB image into normalized rgb
output_image=zeros(384,512,3);

for i=1:384
    for j=1:512
        const=input(i,j,1)+input(i,j,2)+input(i,j,3);
        o1=input(i,j,1)/const;
        o2=input(i,j,2)/const;
        o3=input(i,j,3)/const;
        output_image(i,j,1)=o1;
        output_image(i,j,2)=o2;
        output_image(i,j,3)=o3;
    end
end
end

