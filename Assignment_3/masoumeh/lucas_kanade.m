function[velocity]= lucas_kanade(patch_1, patch_2, Ix, Iy)
    [Ix_h, Ix_w] = size(Ix);
    Ix = reshape(Ix,Ix_h * Ix_w,1);
    
    [Iy_h, Iy_w] = size(Iy);
    Iy = reshape(Iy,Iy_h * Iy_w,1);
    
    A = [Ix, Iy];
    
    It = patch_2 - patch_1;
    [It_h, It_w] = size(It);
    b = -1 * (reshape(It,It_h * It_w,1));
    velocity = pinv(A)*b;

end






