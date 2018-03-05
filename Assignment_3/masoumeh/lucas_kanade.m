function[velocity]= lucas_kanade(patch_1, patch_2, sigma , filter_size)
    %G=gauss1D( sigma , filter_size);
    %Gx=gradient(G);
    %Gy=gradient(reshape(G,filter_size,1));
    Gx = gradient(fspecial('gauss', [1, 3]));
    Gy = gradient(fspecial('gauss', [3, 1]));
    %Gdx = gradient(Gx);
    %Gdy = gradient(Gy);
    Ix = imfilter(patch_2, Gx);%conv2(patch_2,Gx,'same');
    Iy = imfilter(patch_2, Gy);%conv2(patch_2,Gy,'same');
    [Ix_h Ix_w] = size(Ix);
    Ix = reshape(Ix,Ix_h * Ix_w,1);
    

    [Iy_h Iy_w] = size(Iy);
    Iy = reshape(Iy,Iy_h * Iy_w,1);
    
    
    A = [Ix, Iy];
    A_T = A';
    

    It = patch_2 - patch_1;
    [It_h It_w] = size(It);
    b = -1 * (reshape(It,It_h * It_w,1));
    

    velocity = inv(A'*A) * A' * b;

end






