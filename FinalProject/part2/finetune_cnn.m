function [net, info, expdir] = finetune_cnn(varargin)

%% Define options

run( 'vl_setupnn.m') ;
opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [1];

opts.nesterovUpdate = true ;

%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
%imdb.images.labels=reshape(imdb.images.labels,1,2060);
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};
% pre-allocation of data
image_number = 2065;
image_dimension = 32;
data = zeros(image_dimension,image_dimension,3,image_number);
labels = zeros(1,image_number);
sets = zeros(1,image_number);

%% TODO: Implement your loop here, to create the data structure described in the assignment


counter=0;

test_files_path = '../Caltech4/ImageSets/test.txt';
train_files_path = '../Caltech4/ImageSets/train.txt';
files_base_path='../Caltech4/ImageData/'
disp('now preparing the dataset...')

train_adrs = strsplit(fileread(train_files_path),'\n');

for i = 1:length(train_adrs)
    im=im2single(imread(strcat(files_base_path,train_adrs{i},'.jpg')));
    resize_im=imresize(im,[32 32]);
    if(size(resize_im,3)==3)
        counter=counter+1;
        sets(1,counter) = 1;
        data(:,:,:,counter)=resize_im;
        if contains(train_adrs{i},"airplanes")
            labels(1,counter)=1;
        elseif contains(train_adrs{i},"cars")
            labels(1,counter)=2;
        elseif contains(train_adrs{i},"faces")
            labels(1,counter)=3;
        elseif contains(train_adrs{i},"motorbikes")
            labels(1,counter)=4;
        end
    end
end  

test_adrs = strsplit(fileread(test_files_path),'\n');
%test_adrs = strsplit(fileread(train_files_path),'\n');
% shuffle:
%test_info = test_info(randperm(numel(test_info)));

for i = 1:length(test_adrs)
    im=im2single(imread(strcat(files_base_path,test_adrs{i},'.jpg')));
    resize_im=imresize(im,[32 32]);
    if(size(resize_im,3)==3)
        counter=counter+1;
        sets(1,counter) = 2;
        data(:,:,:,counter)=resize_im;
        if contains(test_adrs{i},"airplanes")
            labels(1,counter)=1;
        elseif contains(test_adrs{i},"cars")
            labels(1,counter)=2;
        elseif contains(test_adrs{i},"faces")
            labels(1,counter)=3;
        elseif contains(test_adrs{i},"motorbikes")
            labels(1,counter)=4;
        end
    end
end


%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data =im2single(data) ;
imdb.images.labels = labels;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);
size(imdb.images.data)

end
