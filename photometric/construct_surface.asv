function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        for i =1:h
            for j=1:w
                sum=0;
                for l=1:j
                    sum=sum+p(1,l);
                end
                for l=1:i
                    sum=sum+q(l,j);
                end
                height_map(i,j)=sum;
                
            end
        end
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        

       
        % =================================================================
               
    case 'row'
        for i =1:h
            for j=1:w
                sum=0;
                for l=1:i
                    sum=sum+q(l,1);
                end
                for l=1:j
                    sum=sum+p(i,l);
                end
                height_map(i,j)=sum;
                
            end
        end
        
        % =================================================================
        % YOUR CODE GOES HERE
        

        % =================================================================
          
    case 'average'
        for i =1:h
            for j=1:w
                sum=0;
                for l=1:j
                    sum=sum+p(1,l);
                end
                for l=1:i
                    sum=sum+q(l,j);
                end
                height_map(i,j)=sum;
                
            end
        end
         for i =1:h
            for j=1:w
                sum=0;
                for l=1:i
                    sum=sum+q(l,1);
                end
                for l=1:j
                    sum=sum+p(i,l);
                end
                height_map(i,j)=sum+height_map(i,j);
                
            end
         end
         height_map=height_map./2;
        % =================================================================
        % YOUR CODE GOES HERE

        
        % =================================================================
end


end

