function[pres,o1,count]=value_detector(i,j,window_size,arr)
pres=0;
o1=zeros(20,1);
count=1;
sp=round(window_size/2);
[l,~]=size(arr);

for k=1:l
       diff_x=(arr(k,1)-i);
       diff_y=(arr(k,2)-j);
       if(0<=diff_x && diff_x<=window_size && 0<=diff_y && diff_y<=window_size)
           pres=1;
           o1(count,1)=k;
           count=count+1;
      end
end
end