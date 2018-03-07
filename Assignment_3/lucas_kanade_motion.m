function[u,v,arr_new]=lucas_kanade_motion(im1,im2,window_size,arr)
[qw,b]=size(arr);
arr_new=double(zeros(qw,b));
for i=1:qw
    arr_new(i,1)=arr(i,1);
    arr_new(i,2)=arr(i,2);
end
h=fspecial('gaussian',5,0.5);
im1=conv2(im1,h,'same');
im2=conv2(im2,h,'same');
[gx1,gy1]=gradient(im1);
gt=im1-im2;
[h,w]=size(im1);
u=double(zeros(h,w));
v=double(zeros(h,w));
count=1;
changed=1;
for i=1:window_size:h
    for j=1:window_size:w
        [pres,o1,cou]=value_detector(i,j,window_size,arr);
        if(pres==1)
        changed=changed+cou-1;
        A=double(zeros(window_size,2));
        b=double(zeros(window_size,1));
        counter=1;
        for k=i:min(i+window_size-1,h)
            for l=j:min(j+window_size-1,w)
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
        for we=1:cou-1
        o=o1(we,1);
        arr_new(o,1)=arr(o,1)+round(2*temp(1,1));
        arr_new(o,2)=arr(o,2)+round(2*temp(2,1));
        end
        end
    end
  
u(isnan(u))=0;
v(isnan(v))=0;
changed
end

