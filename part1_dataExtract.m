%% Constants
pop = 1; metal = 2; disco = 3; blues = 4; reggae = 5;
classical = 6; rock = 7; hiphop = 8; country = 9; jazz = 10;
num_cols = 67;

%% Get data from 'GenreClassData_30s.txt'
% Read data names from data files
fid = fopen('GenreClassData_30s.txt');
format = repmat('%s ',1, num_cols);
names = textscan(fid,format,1,'Delimiter','\t');

% Read numerical data from file
data_30s = readmatrix('GenreClassData_30s.txt');

% Find indices of wanted properties
spectral_rollof_mean_index = find(strcmp([names{:}], 'spectral_rolloff_mean'));
mfcc_1_mean_index = find(strcmp([names{:}], 'mfcc_1_mean'));
spectral_centroid_mean_index = find(strcmp([names{:}], 'spectral_centroid_mean'));
tempo_index = find(strcmp([names{:}], 'tempo'));

% Find index of switch between training set and test set
for i=2:size(data_30s,1)
    if (data_30s(i-1,1) > data_30s(i,1))
        trainingFinal = i-1;
        testFirst = i;
        break;
    end
end

% Define training set, test set and music genre labels, with only the 4
% wanted properties
trainingSet_30s     = [data_30s(1:trainingFinal,spectral_rollof_mean_index), data_30s(1:trainingFinal,mfcc_1_mean_index),  data_30s(1:trainingFinal,spectral_centroid_mean_index), data_30s(1:trainingFinal,tempo_index)];
testSet_30s         = [data_30s(testFirst:end,spectral_rollof_mean_index), data_30s(testFirst:end,mfcc_1_mean_index), data_30s(testFirst:end,spectral_centroid_mean_index), data_30s(testFirst:end,tempo_index)];
trainingLabels_30s  = data_30s(1:trainingFinal,end-2);
trueLabels_30s      = data_30s(testFirst:end,end-2)';

%% Close all files
err = fclose('all');
if (err==0)
    disp('All files successfully closed');
else
    disp('Failed closing all files');
end