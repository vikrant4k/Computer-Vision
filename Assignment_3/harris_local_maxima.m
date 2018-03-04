function[H_new]=harris_local_maxima(H,siz,threshold)
size(H)
[h,w]=size(H);
H_new=double(zeros(size(H)));
for i=1:h
    for j=1:w
        max=H(i,j);
        x=i;
        y=j;
        if((i+siz)<=h && (j+siz)<=w)
        for k=i:i+siz
            for l=j:j+siz
                if (H(k,l)>max)
                    max=H(k,l);
                    x=k;
                    y=l;
                end
            end
        end
        if(max>threshold)
        H_new(x,y)=max;
        end
        end
        j=j+siz;
    end
    i=i+siz;
end
end 