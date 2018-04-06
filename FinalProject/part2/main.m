%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-80.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));


%%
train_svm(nets, data);
%% 
nets.pre_trained.layers{end}.type = 'softmax';
nets.fine_tuned.layers{end}.type = 'softmax';



%set = svm_data(data, nets.fine_tuned);
set = svm_data(data, nets.pre_trained);
mapped_data = tsne(set.features,[]);
%[mapped_data, mapping] = compute_mapping(features.finetune.features, 'tSNE');
gscatter(mapped_data(:,1), mapped_data(:,2), set.labels)



