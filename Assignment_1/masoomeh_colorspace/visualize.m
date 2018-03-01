function visualize(input_image)
    figure
    names = ["channel 1"; "channel 2"; "channel3"];
    subplot(2,2,1);
    imshow(input_image);
    title('whole');
    [xs, ys, cs] = size(input_image)
    if cs == 1
        return
    end
    for i = 2:4
        subplot(2,2,i);
        imshow(input_image(:,:,i-1));
        title(names(i-1,:));
    end
end

