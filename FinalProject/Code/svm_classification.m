function [model] = svm_classification(train_label, train_data, kernel_type)
    %-t kernel_type : set type of kernel function (default 2)
    %	0 -- linear: u'*v
    %	1 -- polynomial: (gamma*u'*v + coef0)^degree
    %	2 -- radial basis function: exp(-gamma*|u-v|^2)
    %	3 -- sigmoid: tanh(gamma*u'*v + coef0)

    if kernel_type == 'linear'
        model = svmtrain(train_label, train_data, ['-t 0 ' '-b 1 ']);
    elseif kernel_type == 'polynomial'
        model = svmtrain(train_label, train_data, ['-t 1 ' '-b 1 ']);
    elseif kernel_type == 'RBF'
        model = svmtrain(train_label, train_data, ['-t 2 ' '-b 1 ']);
    elseif kernel_type == 'sigmoid'
        model = svmtrain(train_label, train_data, ['-t 3 ' '-b 1 ']);
    end
end

