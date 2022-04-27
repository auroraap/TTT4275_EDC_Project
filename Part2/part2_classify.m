clear;
%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5;

features = [spectral_rollof_mean, mfcc_1_mean, spectral_centroid_mean];
numFeatures = size(features,2);

%% Extract data
[fullTrainingSet, fullTestSet] = dataExtraction('GenreClassData_30s.txt');

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

% Define constants
numTests = size(testSetNorm,1);

% Initialize label arrays for the four tests
predLabel = NaN(numTests,1);
predLabelStr = string(zeros(numTests,1));
trueLabel       = testSet(:,end);
trueLabelStr = string(zeros(numTests,1));

% Classify with one feature excluded at a time
for testItem=1:numTests
    predLabel(testItem) = knn(5, [testSetNorm(testItem,1:3), testSetNorm(testItem,end)], [trainingSetNorm(:,1:3),trainingSetNorm(:,end)]);
    predLabelStr(testItem) = labels(predLabel(testItem)+1);
    trueLabelStr(testItem) = labels(testSetNorm(testItem, end)+1);
end

%% Error rate
errorRate = getErrorRate(predLabel, trueLabel);

%% Plot confusion charts
close all;

fig4 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'Tempo excluded';
cm.RowSummary = 'row-normalized';
hgexport(fig4, 'part2_confusion.eps');