function [outlier]=test_outliers(normals)
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
outlier=sum(sum(SE > threshold));
end