function G = gauss2D( sigma , kernel_size )
    g_row=gauss1D(sigma,kernel_size);
    g_col=gauss1D(sigma,kernel_size);
    g_col=reshape(g_col,kernel_size,1);
    G=g_col*g_row;
end
