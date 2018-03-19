function imdb = getCaltechIMDB()

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
        label = [label; 1];
    elseif contains(train_adrs{i},'cars')
        label = [label; 2];
    elseif contains(train_adrs{i},'faces')
        label = [label; 3];
    elseif contains(train_adrs{i},'motorbikes')
        label = [label; 4];
    end
end  

test_adrs = strsplit(fileread(test_files_path),'\n');

% shuffle:
%test_info = test_info(randperm(numel(test_info)));

for i = 1:length(test_adrs)
    sets = [sets; 2];
    if contains(test_adrs{i},'airplanes')
        label = [label; 1];
    elseif contains(test_adrs{i},'cars')
        label = [label; 2];
    elseif contains(test_adrs{i},'faces')
        label = [label; 3];
    elseif contains(test_adrs{i},'motorbikes')
        label = [label; 4];
    end
end  

data = [32,32,3,lenght(set)];

imdb.images.data = data;
imdb.images.labels = label;
imdb.images.set = set;
imdb.meta = []

end