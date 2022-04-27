%% Extract data
clear;
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5; tempo = 39;

numFeatures = 4;
features = [spectral_rollof_mean, mfcc_1_mean, spectral_centroid_mean, tempo];

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
numTests        = size(testSet,1);
predLabel       = NaN(numTests,1);
predLabelStr    = string(zeros(numTests,1));
trueLabel       = testSet(:,end);
trueLabelStr    = string(zeros(numTests,1));

for testItem=1:numTests
    predLabel(testItem)     = knn(5, testSetNorm(testItem,:), trainingSetNorm);
    
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
hgexport(fig1, 'part1_confusion.eps');