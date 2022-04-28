clear;
%% Extract data
[trainingSet_30, testSet_30] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, testSet_10] = dataExtraction('GenreClassData_10s.txt');
[trainingSet_5, testSet_5] = dataExtraction('GenreClassData_5s.txt');

trainingSet = [trainingSet_30; trainingSet_10];
testSet = [testSet_30; testSet_10];

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
numTests = size(testSet,1); sizeTrainingSet = size(trainingSet,1);
numFeatures = size(trainingSet,2)-1; numGenres = size(labels,2);

%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Determine the best features
% Get the numFt best features: the features with the biggest differences in
% mean between genres
numFeatures = 15;
scoresArray = scores(trainingSetNorm);
[~, selectedFeatures] = maxk(scoresArray, numFeatures);


trainingSetModified = NaN(sizeTrainingSet,numFeatures+1);
testSetModified = NaN(numTests,numFeatures+1);

for i = 1:numFeatures
    feature = selectedFeatures(i);
    
    trainingSetModified(:,i) = trainingSetNorm(:,feature);
    testSetModified(:,i) = testSetNorm(:,feature);
    
end
trainingSetModified(:,end) = trainingSetNorm(:,end);
testSetModified(:,end) = testSetNorm(:,end);

%% Separate data by genre
numTracks = size(trainingSet,1);
sortedSet = NaN(floor(numTracks/numGenres), numFeatures, numGenres);
indices = ones(numGenres, 1);

for track = 1:sizeTrainingSet
    labelIndex = trainingSetModified(track, end)+1;
    sortIndex = indices(labelIndex);
    
    sortedSet(sortIndex, :, labelIndex) = trainingSetModified(track, 1:numFeatures);
    indices(labelIndex) = indices(labelIndex) +1;
end



numIt = 100; errorRates = zeros(numIt, 1);
for it = 1:numIt

    %% Clustering genrewise

    numClusters = 10;
    clusterSet = NaN(numClusters*numGenres, numFeatures+1);
    for genre = 1:numGenres
        row = (genre-1)*numClusters+1;
        label = (genre-1)*ones(numClusters,1);

        [~, clusters] = kmeans(sortedSet(:,:,genre), numClusters);
        clusterSet(row:row+numClusters-1, :) = [clusters, label];
    end

    %% Classify with knn, store labels and string arrays

    % Define label arrays
    predLabels = NaN(numTests,1); predLabelStr = string(zeros(numTests,1));
    trueLabels = testSet(:,end); trueLabelStr = string(zeros(numTests,1));
    numNeighbors = 1;

    for testItem=1:numTests
        predLabels(testItem)   = knn(numNeighbors, testSetModified(testItem,1:end), clusterSet(:,1:end));
        predLabelStr(testItem) = labels(predLabels(testItem)+1);
        trueLabelStr(testItem) = labels(testSetModified(testItem, end)+1);
    end

    %% Get error rate
    errorRate = getErrorRate(predLabels, trueLabels);
    errorRates(it) = errorRate;
end

maxErrorRate = max(errorRates);
minErrorRate = min(errorRates);
meanErrorRate = mean(errorRates);

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(trueLabelStr,predLabelStr);
cm.Title = 'Clustering on all features, NN';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part4_confusion.eps');






