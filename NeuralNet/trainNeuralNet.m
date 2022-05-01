clear;
%% Extract data
[trainingSet_30, testSet_30] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, testSet_10] = dataExtraction('GenreClassData_10s.txt');
[trainingSet_5, testSet_5] = dataExtraction('GenreClassData_5s.txt');

trainingSetInit = [trainingSet_30; trainingSet_10];% trainingSet_5];
testSetInit     = [testSet_30];% testSet_10]; % testSet_5];

numTrain = size(trainingSetInit,1); numTests = size(testSetInit,1); numGenres = 10;

%% Normalize data
trainingSet = normalizeSet(trainingSetInit);
testSet     = normalizeSet(testSetInit);

%% Determine the best features
% Get the numFt best features: the features with the biggest differences in
% mean between genres
numFeatures = 63;
scoresArray = scores(trainingSet);
[~, selectedFeatures] = maxk(scoresArray, numFeatures);


trainingSetModified = NaN(numTrain,numFeatures+1);
testSetModified = NaN(numTests,numFeatures+1);

for i = 1:numFeatures
    feature = selectedFeatures(i);
    
    trainingSetModified(:,i) = trainingSet(:,feature);
    testSetModified(:,i) = testSet(:,feature);
    
end
trainingSetModified(:,end) = trainingSet(:,end);
testSetModified(:,end) = testSet(:,end);

trainingSet = trainingSetModified;
testSet = testSetModified;

%% Define network and train
net = feedforwardnet(52, 'trainscg');

trainFt   = trainingSet(:, 1:end-1)';
testFt    = testSet(:, 1:end-1)';

trainLabels = trainingSet(:,end);
yTrain = zeros(numTrain, numGenres);
for i=1:numTrain
    genreIdx = trainLabels(i) + 1;
    yTrain(i, genreIdx) = 1;
end

testLabels = testSet(:,end);

net = train(net, trainFt, yTrain');

%% Save neural network
    % Uncomment if a new network is needed, or rename network to 
    % avoid overwriting.
% musicGenreNetwork = net;
% save musicGenreNetwork