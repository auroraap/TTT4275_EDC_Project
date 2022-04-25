%% Extract data
clear; dataExtract;

%% Classify test set
n_tests = size(testSet,1);
predLabel = NaN(n_tests,1);

for testItem=1:n_tests
    predLabel(testItem) = knn(5, testSet(testItem,:), trainingSet);
end

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(testLabels_30s,predLabel);
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part1_confusion.eps');