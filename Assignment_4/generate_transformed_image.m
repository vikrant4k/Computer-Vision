function generated_img = generate_transformed_image(image, best_transformation)
        
    image = im2double(image);            
    [h, w] = size(image);
    x = [1,w];
    y = [1,h];
    
    max_y = -inf; 
    max_x = -inf;
    min_y = inf;
    min_x = inf;
    
    for i = 1:length(x)
        for j = 1:length(y)
           transformed_point = [x(i), y(j), 0, 0, 1, 0; 0, 0, x(i), y(j), 0, 1] * best_transformation;
           if(round(transformed_point(1)) > max_x)
               max_x = floor(transformed_point(1))  ;
           end
           if (round(transformed_point(1)) < min_x)
               min_x = floor(transformed_point(1))  ;
           end
           if(round(transformed_point(2)) > max_y)
               max_y = floor(transformed_point(2)) ;
           end
           if (round(transformed_point(2)) < min_y)
               min_y = floor(transformed_point(2)) ;
           end
        end
    end
    
    
    %max_y 
    %max_x
    %min_y
    %min_x
    
    
    
    generated_img = im2double((zeros(max_y-min_y+1,max_x-min_x+1)));    
    
    for j = 1:size(image,1)%y
       for i = 1:size(image,2)%x
           A = [i, j, 0, 0, 1, 0; 0, 0, i, j, 0, 1] ;
           b = A * best_transformation;
           %round(b(2))-min_y+1
           %round(b(1))-min_x+1 
           generated_img(round(b(2))-min_y+1, round(b(1))-min_x+1) = image(j,i);%Ia_gray(j,i);
       end
    end 
    

end