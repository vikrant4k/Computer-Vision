function [output_image] = rgb2opponent(input)
% converts an RGB image into opponent color space
output_image=zeros(384,512,3);
t=sqrt(2);
t1=sqrt(6);
t2=sqrt(3);
for i=1:384
    for j=1:512
        o1=(input(i,j,1)-input(i,j,2))/t;
        o2=(input(i,j,1)+input(i,j,2)-2*input(i,j,3))/t1;
        o3=(input(i,j,1)+input(i,j,2)+input(i,j,3))/t2;
        output_image(i,j,1)=o1;
        output_image(i,j,2)=o2;
        output_image(i,j,3)=o3;
    end
end

end

