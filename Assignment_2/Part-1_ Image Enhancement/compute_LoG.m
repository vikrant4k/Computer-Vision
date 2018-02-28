function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        im=denoise(image,'gaussian',0.5,5);
       [Gx,Gy] = gradient(im);   
       [Gxx,Gxy] = gradient(Gx);
       [Gyx,Gyy] = gradient(Gy);
       Gxx=Gxx+Gyy;
       surf(Gxx);
       imOut=Gxx;
    case 2
       lap=gauss2D(0.5,5);
       [Gx,Gy] = gradient(lap);   
       [Gxx,Gxy] = gradient(Gx);
       [Gyx,Gyy] = gradient(Gy);
       Gxx=Gxx+Gyy;
       imOut=conv2(image,Gxx,'same');
       surf(imOut)
    case 3
        %method 3
       lap=gauss2D(0.5,5);
       lap_1=gauss2D(1,5);
       lap_1=lap_1-lap;
       surf(lap_1);
       imOut=conv2(image,lap_1,'same');
     
end
end

