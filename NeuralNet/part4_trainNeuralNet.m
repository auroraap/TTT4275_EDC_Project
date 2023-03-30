clear; addpath("../utilities");
%% Extract data
[trainingSet_30, ~] = dataExtraction('GenreClassData_30s.txt');
[trainingSet_10, ~] = dataExtraction('GenreClassData_10s.txt');

trainingSetInit = [trainingSet_30; trainingSet_10];

numTrain = size(trainingSetInit,1); 
numGenres = 10;

%% Normalize data
trainingSet = normalizeSet(trainingSetInit);

%% Determine the best features
% Get the numFt best features: the features with the biggest differences in
% mean between genres
numFeatures = 63;

if numFeatures < size(trainingSet,2)-1
    scoresArray = scores(trainingSet);
    [~, selectedFeatures] = maxk(scoresArray, numFeatures);
    
    trainingSetModified = NaN(numTrain,numFeatures+1);
    
    for i = 1:numFeatures
        feature = selectedFeatures(i);
        
        trainingSetModified(:,i) = trainingSet(:,feature);
        
    end
    trainingSetModified(:,end) = trainingSet(:,end);
    trainingSet = trainingSetModified;
end

%% Define network and train
net = feedforwardnet(52, 'trainscg');

trainFt   = trainingSet(:, 1:end-1)';

trainLabels = trainingSet(:,end);
yTrain = zeros(numTrain, numGenres);
for i=1:numTrain
    genreIdx = trainLabels(i) + 1;
    yTrain(i, genreIdx) = 1;
end

net = train(net, trainFt, yTrain');

%% Save neural network
    % Uncomment if a new network is needed, or rename network to 
    % avoid overwriting.
% musicGenreNetwork_test = net;
% save musicGenreNetwork_test