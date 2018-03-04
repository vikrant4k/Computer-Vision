function[u,v]=lucase_kanade(im1,im2,window_size)
[gx1,gy1]=gradient(im1);
gt=im1-im2;
size(gx1)
[h,w]=size(im1);
u=double(zeros(h,w));
v=double(zeros(h,w));
size(u)
for i=1:h
    for j=1:w
        A=double(zeros(window_size,2));
        b=double(zeros(window_size,1));
        counter=1;
        if((i+window_size)<=h && (j+window_size)<=w)
        for k=i:i+window_size
            for l=j:j+window_size
                A(counter,1)=gx1(k,l);
                A(counter,2)=gy1(k,l);
                b(counter,1)=gt(k,l);
                counter=counter+1;
                l=l+window_size;
            end
            k=k+window_size;
        end
        temp=inv(transpose(A)*A)*transpose(A)*b;
        u(i,j)=temp(1,1);
        v(i,j)=temp(2,1);
        end
        
    end
end
end


