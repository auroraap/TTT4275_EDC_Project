clear; dataExtract;

trainingSet = training_30;
testSet = test_30;

sizeTrainingSet = size(trainingSet,1);
numGenres = size(trainingSet,2);
numFeatures = size(trainingSet(1:end-1),1);

[idx, centroids] = kmeans(trainingSet(1:end-1,:), 10);