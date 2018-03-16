function stitch(I_right,I_left,right_best_transformation) 

    I_left = im2double(I_left);
    I_right = im2double(I_right);
    
    [h_left,w_left,~] = size(I_left);
    

    % corners of right image before transfomation:
    [h_right, w_right,~] = size(I_right);
    x = [1,w_right];
    y = [1,h_right];
    
    % finding dimension of stitched image by transforming corners of right image 
    % and comparing with coordination of left image   
    max_y = h_left; 
    max_x = w_left;
    min_y = 1;
    min_x = 1;
    
    for i = 1:length(x)
        for j = 1:length(y)
           transformed_point = [x(i), y(j), 0, 0, 1, 0; 0, 0, x(i), y(j), 0, 1] * right_best_transformation;
           if(round(transformed_point(1)) > max_x)
               max_x = round(transformed_point(1))  ;
           end
           if (round(transformed_point(1)) < min_x)
               min_x = round(transformed_point(1))  ;
           end
           if(round(transformed_point(2)) > max_y)
               max_y = round(transformed_point(2)) ;
           end
           if (round(transformed_point(2)) < min_y)
               min_y = round(transformed_point(2)) ;
           end
        end
    end
    

    composed_img = im2double((zeros(max_y-min_y+1,max_x-min_x+1,3)));
    for j = 1:h_left
       for i =1:w_left
           composed_img(j-min_y+1,i-min_x+1,:)=I_left(j,i,:);
       end
    end
    
    
    for j = 1:size(I_right,1)%y
       for i = 1:size(I_right,2)%x
           A_img2 = [i, j, 0, 0, 1, 0; 0, 0, i, j, 0, 1] ;
           b = A_img2 * right_best_transformation;                     
           %composed_img(round(b(2))-min_y+1, round(b(1))-min_x+1,:) = I_right(j,i,:);%Ia_gray(j,i);
           x_temp=round(b(1))-min_x+1;
           y_temp=round(b(2))-min_y+1;
           found=0;
           if(composed_img(y_temp,x_temp,1)>0)
               for k=max(y_temp-2,1):min(y_temp+2,max_y)
                   for u=max(x_temp-2,1):min(x_temp+2,max_x)
                      
                       
                       if(composed_img(k,u,1)<=0 && found==0)
                           composed_img(k,u,:)=I_right(j,i,:);
                           found=1;
                       end
                   end
               end
           else
               composed_img(y_temp,x_temp,:)=I_right(j,i,:);
           end
                           
       end
    end    
    
    imshow(composed_img)
    saveas(gcf,"stitch_result.png")
    
    %B = medfilt3(composed_img);
    %imshow(B)
    %saveas(gcf,"denoised_stitch_result.png")
   
end