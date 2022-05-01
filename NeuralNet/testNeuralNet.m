clear;

%% Extract data
[trainingSet_30, testSet_30] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, testSet_10] = dataExtraction('GenreClassData_10s.txt');
[trainingSet_5, testSet_5] = dataExtraction('GenreClassData_5s.txt');

trainingSet = [trainingSet_30; trainingSet_10];
testSet     = normalizeSet(testSet_30);

numTests = size(testSet,1); numGenres = 10;
testLabels = testSet(:,end);

%% Determine the best features
% Get the numFt best features: the features with the biggest differences in
% mean between genres
numFeatures = 63;
scoresArray = scores(trainingSet);
[~, selectedFeatures] = maxk(scoresArray, numFeatures);

testSetModified = NaN(numTests,numFeatures+1);

for i = 1:numFeatures
    feature = selectedFeatures(i);
    testSetModified(:,i) = testSet(:,feature);
    
end
testSetModified(:,end) = testSet(:,end);
testSet = testSetModified;

%% Test network
labels    = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
labelsStr = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
testFt = testSet(:,1:end-1)';

load musicGenreNetwork;

predictionScores = musicGenreNetwork(testFt);
[~,predLabels]   = max(predictionScores);

%% Convert labels to numerical data
for i = 1:size(predLabels,2)
    predLabels(i) = predLabels(i) - 1;
end

%% Error rate
errorRate = getErrorRate(predLabels', testLabels);

%% Plot confusion chart
predLabelsStr = string(zeros(numTests,1));
trueLabelsStr = string(zeros(numTests,1));
for sample = 1:numTests
    predLabelsStr(sample) = labelsStr(predLabels(sample)+1);
    trueLabelsStr(sample) = labelsStr(testLabels(sample)+1);
end

close all;
fig1 = figure;
cm = confusionchart(trueLabelsStr, predLabelsStr);
cm.Title = 'Neural network';
cm.RowSummary = 'row-normalized';
%hgexport(fig1, 'part4_nn_trainscg_52layers.eps');