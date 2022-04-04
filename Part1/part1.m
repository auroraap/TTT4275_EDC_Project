%% Extract data
clear; part1_dataExtract;

%% Classify test set
n_tests = size(testSet,1);
predLabel = NaN(n_tests,1);

for testItem=1:n_tests
    predLabel(testItem) = knn(5, testSet(testItem,:), trainingSet, 4);
end

%% Plot confusion chart
confusionchart(testLabels_30s,predLabel);