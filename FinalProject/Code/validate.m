function validate(centers, model, images_path, labels)
    histograms = double(sparse(extract_histograms(centers, images_path)));
    %[pred_label, acc, X] = predict(double(labels), histograms, model);
    [pred_label, acc, prob] = svmpredict(double(labels),  histograms, model);
    %predict(testing_label_vector, testing_instance_matrix, model [, 'liblinear_options', 'col'])
    
    
    disp(acc)
end