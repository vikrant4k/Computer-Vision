clear all;
close all; 
clc;
%% libs:
run('/home/mas/softwares/VLFEATROOT/toolbox/vl_setup.m')
addpath('../liblinear-2.20/matlab')
addpath('../libsvm-3.22/matlab')

%% pre-defined vars:
train_folders = {'airplanes_train.txt','cars_train.txt','faces_train.txt','motorbikes_train.txt'};
test_files_path = '../Caltech4/ImageSets/test.txt';
%test_folders = {'airplanes_test.txt','cars_test.txt','faces_test.txt','motorbikes_test.txt'};

sift_type = 'sift';%'dsift'
color_space = 'RGB';%'rgb', 'opponent'
kernel_type = 'linear';%,'polynomial','RBF','sigmoid'}


k = 200;
train_len = 20;
valid_len = 20;

%% Seperate train data and validation set:

whole_train = cell(length(train_folders),1);
whole_label = cell(length(train_folders),1);

data_train = cell(length(train_folders),2);% data_adrs = cell(4,1), label = cell(4,2)
data_valid = cell(length(train_folders),2);
disp('now preparing the dataset...')
for i = 1:length(train_folders)
    file_inhoud = strsplit(fileread(strcat('../Caltech4/Annotation/',train_folders{i})),'\n');
    whole_train{i,1} = file_inhoud(1:length(file_inhoud)-1);
    whole_train{i,1} = whole_train{i}(randperm(numel(whole_train{i})));
    whole_label{i,1} = cell(length(whole_train{i,1}),1);
    for j = 1:length(whole_train{i,1})
        splitted = strsplit(whole_train{i,1}{j},' ');
        whole_train{i,1}{j} = splitted{1};
        whole_label{i,1}{j,1} = splitted{2};
    end
  
    data_train{i,1} = whole_train{i,1}(1:train_len);
    data_valid{i,1} = whole_train{i,1}(train_len + 1: train_len + valid_len);
    
    data_train{i,2} = whole_label{i,1}(1:train_len);
    data_valid{i,2} = whole_label{i,1}(train_len + 1: train_len + valid_len);
end

% flatten adrs info
dictionary_train = data_train{i,1};
for i=2:4
    dictionary_train = [dictionary_train; data_train{i,1}];
end


%% create dict:
disp("now creating dictionary...")
centers = create_dictionary(dictionary_train, k, sift_type,color_space);

%% training & validation:
models = cell(length(train_folders),1);
for c= 1:length(train_folders)
    disp('now extracting histogram...')
    histograms = extract_histograms(centers, data_train{c, 1});
    disp('now trainig model...')
    vector_lab = cell2mat(data_train{c, 2});
    models{c, 1} = svm_classification(double(vector_lab),  sparse(double(histograms)), kernel_type);    
    disp('now validating...')
    validate(centers, models{c, 1}, data_valid{c, 1}, cell2mat(data_valid{c,2}))
end

length(models)

%% preparing test set:


test_files_path = '../Caltech4/ImageSets/test.txt';
disp('now preparing the testset...')
%for i = 1:length(test_folders)
file_inhoud = strsplit(fileread(test_files_path),'\n');
test_info = file_inhoud(1:length(file_inhoud));

% shuffle:
test_info = test_info(randperm(numel(test_info)));
test_label = [];
for i = 1:length(test_info)
    if contains(test_info{i},'airplanes')
        test_label = [test_label; 1];
    elseif contains(test_info{i},'cars')
        test_label = [test_label; 2];
    elseif contains(test_info{i},'faces')
        test_label = [test_label; 3];
    elseif contains(test_info{i},'airplanes')
        test_label = [test_label; 4];
    end
end  


eval = cell(length(models),2);%cell(4,2)
for i=1:4
    eval{i,1}=[]
    eval{i,2}=[]
end
for i= 1:5%length(test_info)
    image_histogram = double(sparse(extract_histograms(centers, test_info(i))));
    disp(test_info(i))
    for j = 1:length(models)
        [pred_label, ~, prob] = svmpredict(double(1),  image_histogram, models{j,1}, '-b 1 ');
        pred_label
        prob
        disp('--------------------')
        % prob(2) is showing the probabilty of belonging to the class of i
        eval{j, 2} = [eval{j,2} prob(2)];    
        eval{j, 1} = [eval{j,1} test_info(i)];
    end
    
    disp('+++++++++++++++++++++++++')
    %validate(centers, model, images_path, labels)
end
eval{1,1}
eval{1,2}
for i=1:4
    [eval{i,1}, eval{i,2}] = my_sort(eval{i,1}, eval{i, 2});
    %eval{i,1} = x(1);
    %eval{i,2} = x(2);
end


%% Evaluation



