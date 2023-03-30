clear; addpath("../utilities");
%% Extract data
[fullTrainingSet, fullTestSet] = dataExtraction('GenreClassData_30s.txt');

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5; tempo = 39;

features = [spectral_rollof_mean, mfcc_1_mean, spectral_centroid_mean, tempo];
numFeatures = size(features,2);

%% Build data sets with the selected features
trainingSet = NaN(size(fullTrainingSet,1), numFeatures+1);
testSet = NaN(size(fullTestSet,1), numFeatures+1);

for i = 1:numFeatures
    trainingSet(:,i) = fullTrainingSet(:,features(i));
    testSet(:,i) = fullTestSet(:,features(i));
end
trainingSet(:,end) = fullTrainingSet(:,end);
testSet(:,end) = fullTestSet(:,end);


%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Classify test set
% Define constants and initialize matrices
numTests        = size(testSet,1);
predLabel       = NaN(numTests,1); predLabelStr = string(zeros(numTests,1));
trueLabel       = testSet(:,end); trueLabelStr  = string(zeros(numTests,1));

for testItem=1:numTests
    % Classify observation
    predLabel(testItem)     = knn(5, testSetNorm(testItem,:), trainingSetNorm);
    
    % Store label as number and string
    predLabelStr(testItem)  = labels(predLabel(testItem)+1);
    trueLabelStr(testItem)  = labels(testSetNorm(testItem, end)+1);
end

%% Find error rate
errorRate = getErrorRate(predLabel, trueLabel);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'figs/part1_confusion.eps');