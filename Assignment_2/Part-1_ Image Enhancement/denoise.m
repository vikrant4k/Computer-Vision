function [ imOut ] = denoise( image, kernel_type, varargin)
imOut=0;
switch kernel_type
    case 'box'
        imOut = imboxfilt(image,varargin{1});
    case 'median'
        imOut=medfilt2(image,[varargin{1},varargin{1}]);
    case 'gaussian'
        imOut=zeros(size(image));
        g=gauss2D(varargin{1},varargin{2});
        diff=floor(varargin{2}/2);
        [h w]=size(image);
        for i=1+diff:(h-diff)
            for j=1+diff:(w-diff)
                sum=0;
                i_index=1;
                j_index=1;
                for k=i-diff:i+diff
                    for l=j-diff:j+diff
                        sum=sum+g(i_index,j_index)*image(k,l);
                        j_index=j_index+1;
                    end
                    i_index=i_index+1;
                    j_index=1;
                end
                imOut(i,j)=sum;
            end
        end
end
end
