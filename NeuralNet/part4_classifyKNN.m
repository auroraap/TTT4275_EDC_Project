clear; addpath("../utilities");

%% Extract data
[trainingSet_30, testSet_30] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, ~] = dataExtraction('GenreClassData_10s.txt');

trainingSet = [trainingSet_30; trainingSet_10];
testSet     = [testSet_30];

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
numTests = size(testSet,1); sizeTrainingSet = size(trainingSet,1);
numFeatures = size(trainingSet,2)-1; numGenres = size(labels,2);

%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Separate data by genre
sortedSet = NaN(79, numFeatures, numGenres);
indices = ones(numGenres, 1);

for dataPoint = 1:sizeTrainingSet
    labelIndex = trainingSetNorm(dataPoint, end) + 1;
    sortIndex  = indices(labelIndex);

    sortedSet(sortIndex, :, labelIndex) = trainingSetNorm(dataPoint, 1:numFeatures);
    indices(labelIndex) = indices(labelIndex) + 1;
end

%% Classify with kNN for all features
predLabels = NaN(numTests,1); predLabelStr = string(zeros(numTests,1));
trueLabels = testSet(:,end); trueLabelStr = string(zeros(numTests,1));
numNeighbors = 11;

for testItem=1:numTests
    % Classify observation with knn
    predLabels(testItem)   = knn(numNeighbors, testSetNorm(testItem,1:end), trainingSetNorm(:,1:end));
    
    % Store predicted label as number and string
    predLabelStr(testItem) = labels(predLabels(testItem)+1);
    trueLabelStr(testItem) = labels(testSetNorm(testItem, end)+1);
end


%% Get Error rates
errorRate = getErrorRate(predLabels, trueLabels);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'kNN with all features';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'figs/part4_confusion_kNN.eps');