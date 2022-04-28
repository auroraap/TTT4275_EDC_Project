clear;
%% Extract data
[trainingSet, testSet] = dataExtraction('GenreClassData_30s.txt');

%% Define constants
numTests = size(testSet,1); sizeTrainingSet = size(trainingSet,2);
numFeatures = size(trainingSet,2)-1; numGenres = size(labels,1);
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];

%% Normalize data
trainingSetNorm = normalizeSet(trainingSet);
testSetNorm     = normalizeSet(testSet);

%% Separate data by genre
trainingSetNorm_byGen   = NaN(numGenres, numFeatures, ceil(sizeTrainingSet/numGenres));
idxCount                = zeros(numGenres,1);
for dataPoint = 1:sizeTrainingSet
    labelIdx = trainingSetNorm(end) + 1;
    trainingSetNorm_byGen(labelIdx, :, idxCount(labelIdx));
    idxCount(labelIdx) = idxCount(labelIdx) + 1;
end

%% Determine the best features
% Get the numFt best features: the features with the biggest differences in
% mean between genres
numFt = 10;
scoresArray = scores(trainingSetNorm);
[~, selectedFeatures] = maxk(scoresArray, numFt);

%% Clustering genrewise?
for genre = 1:numGenres
    [~, clusters] = 
end

