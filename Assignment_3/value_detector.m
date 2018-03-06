function[pres]=value_detector(i,j,window_size,arr)
pres=0;
[l,~]=size(arr);
for k=1:l
    if((arr(k,1)>=i && arr(k,1)<=(i+window_size)) && (arr(k,2)>=j && arr(k,2)<=(j+window_size)))
        pres=1;
        return;
    end
end
end