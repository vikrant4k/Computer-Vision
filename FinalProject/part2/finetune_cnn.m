function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run('vl_setupnn.m');
%run(fullfile(fileparts(mfilename('fullpath')), ...
%  '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;


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
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment

data = [] ;
labels = [] ;
sets = [] ;
counter = [] ;


test_files_path = '../Caltech4/ImageSets/test.txt';
train_files_path = '../Caltech4/ImageSets/train.txt';
disp('now preparing the dataset...')

train_adrs = strsplit(fileread(train_files_path),'\n');

for i = 1:length(train_adrs)
    sets = [sets; 1];
    if contains(train_adrs{i},'airplanes')
        labels = [labels; 1];
    elseif contains(train_adrs{i},'cars')
        labels = [labels; 2];
    elseif contains(train_adrs{i},'faces')
        labels = [labels; 3];
    elseif contains(train_adrs{i},'motorbikes')
        labels = [labels; 4];
    end
end  

test_adrs = strsplit(fileread(test_files_path),'\n');

% shuffle:
%test_info = test_info(randperm(numel(test_info)));

for i = 1:length(test_adrs)
    sets = [sets; 2];
    if contains(test_adrs{i},'airplanes')
        labels = [labels; 1];
    elseif contains(test_adrs{i},'cars')
        labels = [labels; 2];
    elseif contains(test_adrs{i},'faces')
        labels = [labels; 3];
    elseif contains(test_adrs{i},'motorbikes')
        labels = [labels; 4];
    end
end  

data = [32,32,3,length(sets)];


%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
