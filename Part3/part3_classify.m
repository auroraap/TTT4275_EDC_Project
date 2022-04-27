clear;

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
% Predetermined features
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5;

%% Extract data
[trainingSet, testSet] = dataExtraction('GenreClassData_30s.txt');
numTests = size(testSet,1); numFeatures = size(trainingSet,2);

% Initialize storing of each test result
testResults = zeros(numFeatures,1);
trainingLabels = trainingSet(:,end);

%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Determine the best feature
scoresArray = scores(trainingSetNorm);
[~, selectedFeature] = max(scoresArray);

%% Classify with the best feature
% Define label arrays
predLabels = NaN(numTests,1);
predLabelStr = string(zeros(numTests,1));
trueLabels = testSet(:,end);
trueLabelStr = string(zeros(numTests,1));

trainingSetModified = [trainingSetNorm(:,spectral_rollof_mean), trainingSetNorm(:,mfcc_1_mean), trainingSetNorm(:,spectral_centroid_mean), trainingSetNorm(:,selectedFeature), trainingLabels];
testSetModified     = [testSetNorm(:,spectral_rollof_mean), testSetNorm(:,mfcc_1_mean), testSetNorm(:,spectral_centroid_mean), testSetNorm(:,selectedFeature), trueLabels];

for testItem=1:numTests
    predLabels(testItem)   = knn(5, testSetModified(testItem,1:end), trainingSetModified(:,1:end));
    predLabelStr(testItem) = labels(predLabels(testItem)+1);
    trueLabelStr(testItem) = labels(testSetNorm(testItem, end)+1);
end

%% Get error rate
errorRate = getErrorRate(predLabels, trueLabels);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'Spectral centroid var included';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part3_confusion.eps');