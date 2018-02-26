function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
[h w]=size(image);
Gx=[1 0 -1;2 0 -2;1 0 -1];
Gy=[1 2 1;0 0 0;-1 -2 -1];
im_magnitude=double(zeros(h,w));
im_magnitude_x=double(zeros(h,w));
im_magnitude_y=double(zeros(h,w));
im_direction=double(zeros(h,w));
diff=1;
for i=1+diff:(h-diff)
            for j=1+diff:(w-diff)
                sum_x=0;
                sum_y=0;
                i_index=1;
                j_index=1;
                for k=i-diff:i+diff
                    for l=j-diff:j+diff
                        sum_x=sum_x+Gx(i_index,j_index)*image(k,l);
                        sum_y=sum_y+Gy(i_index,j_index)*image(k,l);                         
                        j_index=j_index+1;
                    end
                    i_index=i_index+1;
                    j_index=1;
                end
                im_magnitude_x(i,j)=sum_x;
                im_magnitude_y(i,j)=sum_y;
                im_magnitude(i,j)=sqrt(sum_x*sum_x+sum_y+sum_y);
                im_direction(i,j)=atan(sum_y/sum_x);
            end
        end
        


imshow(im_direction);
end

