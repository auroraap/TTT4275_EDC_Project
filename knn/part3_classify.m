clear; addpath("../utilities");
%% Extract data
[trainingSet, testSet] = dataExtraction('GenreClassData_30s.txt');
trainingLabels = trainingSet(:,end);

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5; tempo = 39;

numTests = size(testSet,1); numFeatures = size(trainingSet,2);

%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Determine the best feature
scoresArray = scores(trainingSetNorm);
[~, selectedFeature] = max(scoresArray);

%% Classify with the best feature
% Define label arrays
predLabels = NaN(numTests,1); predLabelStr = string(zeros(numTests,1));
trueLabels = testSet(:,end); trueLabelStr = string(zeros(numTests,1));

% Construct new training and test sets
trainingSetModified = [trainingSetNorm(:,spectral_rollof_mean), trainingSetNorm(:,mfcc_1_mean), trainingSetNorm(:,spectral_centroid_mean), trainingSetNorm(:,selectedFeature), trainingLabels];
testSetModified     = [testSetNorm(:,spectral_rollof_mean), testSetNorm(:,mfcc_1_mean), testSetNorm(:,spectral_centroid_mean), testSetNorm(:,selectedFeature), trueLabels];

% Classify with knn, store labels as string arrays
for testItem=1:numTests
    % Classify with knn
    predLabels(testItem)   = knn(5, testSetModified(testItem,1:end), trainingSetModified(:,1:end));
    
    % Store predicted labels as numbers and strings
    predLabelStr(testItem) = labels(predLabels(testItem)+1);
    trueLabelStr(testItem) = labels(trueLabels(testItem)+1);
end

%% Get error rate
errorRate = getErrorRate(predLabels, trueLabels);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'Spectral centroid var included';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'figs/part3_confusion.eps');