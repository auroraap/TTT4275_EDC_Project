clear;
%% Extract data
[trainingSet_30, testSet_30] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, testSet_10] = dataExtraction('GenreClassData_10s.txt');
[trainingSet_5, testSet_5] = dataExtraction('GenreClassData_5s.txt');

trainingSet = [trainingSet_30; trainingSet_10]; % trainingSet_5];
testSet     = [testSet_30; testSet_10]; % testSet_5];

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

%% Iterate a few times to get a fair representation of error rate
numIterations = 100; errorRates = zeros(numIterations, 1);
for it = 1:numIterations
    %% Clustering genrewise
    numClusters = 15;
    clusterSet = NaN(numClusters*numGenres, numFeatures+1);
    
    for genre = 1:numGenres
        row    = (genre-1)*numClusters + 1;
        label  = (genre-1)*ones(numClusters,1);
    
        [~, clusters] = kmeans(sortedSet(:,:,genre), numClusters);
        clusterSet( row : row+numClusters-1 , :) = [clusters, label];
    end
    
    %% Classify with knn, store labels as string arrays
    predLabels = NaN(numTests,1); predLabelStr = string(zeros(numTests,1));
    trueLabels = testSet(:,end); trueLabelStr = string(zeros(numTests,1));
    
    for testItem=1:numTests
        predLabels(testItem)   = knn(1, testSetNorm(testItem,1:end), clusterSet(:,1:end));
        predLabelStr(testItem) = labels(predLabels(testItem)+1);
        trueLabelStr(testItem) = labels(testSetNorm(testItem, end)+1);
    end
    
    %% Get error rate
    errorRate = getErrorRate(predLabels, trueLabels);
    errorRates(it) = errorRate;
end

%% Get Error rates
meanErrorRate = mean(errorRates);
minErrorRate = min(errorRates);
maxErrorRate = max(errorRates);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'Classwise clustering for all features';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part4_confusion_allFtClustering.eps');