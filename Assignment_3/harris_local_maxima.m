function[H_new]=harris_local_maxima(H,siz,threshold)
size(H)
[h,w]=size(H);
H_new=double(zeros(size(H)));
for i=1:siz:h
    for j=1:siz:w
        max=H(i,j);
        x=i;
        y=j;
       
        for k=i:min(i+siz,h)
            for l=j:min(j+siz,w)
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
end
end 