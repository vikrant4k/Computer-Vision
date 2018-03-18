eval = cell(4,2);%cell(4,2)
arr = ['a','b','c','d','e','f'];
x = [1,2,3,4,5,6,7,8,9];
for i= 1:5%length(test_info)
    prob_list = [];   
    eval{i,1}={arr(1)}
    for j = 2:4
        eval{i,1} = [eval{i,1}; arr(i)];
    end
end