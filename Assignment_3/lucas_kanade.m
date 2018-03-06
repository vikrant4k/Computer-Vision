function[u,v]=lucase_kanade(im1,im2,window_size)
h=fspecial('gaussian',5,0.5);
im1=conv2(im1,h,'same');
im2=conv2(im2,h,'same');
[gx1,gy1]=gradient(im1);
gt=im1-im2;
[h,w]=size(im1);
u=double(zeros(h,w));
v=double(zeros(h,w));
count=1
for i=1:window_size:h
    for j=1:window_size:w
        A=double(zeros(window_size,2));
        b=double(zeros(window_size,1));
        counter=1;
        for k=i:min(i+window_size,h)
            for l=j:min(j+window_size,w)
                A(counter,1)=gx1(k,l);
                A(counter,2)=gy1(k,l);
                b(counter,1)=gt(k,l);
                counter=counter+1;
              
            end
        end
        temp=inv(transpose(A)*A)*transpose(A)*b;
        u(i,j)=temp(1,1);
        v(i,j)=temp(2,1);
        count=count+1; 
    
    end
  
end
u(isnan(u))=0;
v(isnan(v))=0;
count
end


