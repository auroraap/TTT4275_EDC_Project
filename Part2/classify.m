%% Extract data
clear; dataExtract;

%% Classify test set

% Define constants
numTests = size(testSet,1);

% Initialize label arrays for the four tests
predLabel_1 = NaN(numTests,1);
predLabel_2 = NaN(numTests,1);
predLabel_3 = NaN(numTests,1);
predLabel_4 = NaN(numTests,1);

% Classify with one feature excluded at a time
for testItem=1:numTests
    predLabel_1(testItem) = knn(5, testSet(testItem,2:end), trainingSet(:,2:end));
end

for testItem=1:numTests
    predLabel_2(testItem) = knn(5, [testSet(testItem,1), testSet(testItem,3:end)], [trainingSet(:,1),trainingSet(:,3:end)]);
end

for testItem=1:numTests
    predLabel_3(testItem) = knn(5, [testSet(testItem,1:2), testSet(testItem,4:end)], [trainingSet(:,1:2),trainingSet(:,4:end)]);
end

for testItem=1:numTests
    predLabel_4(testItem) = knn(5, [testSet(testItem,1:3), testSet(testItem,end)], [trainingSet(:,1:3),trainingSet(:,end)]);
end

%% Plot confusion charts
close all;
fig1 = figure;
cm = confusionchart(testLabels_30s,predLabel_1);
cm.Title = 'Spectral rolloff mean excluded';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part2_confusion_1.eps');

fig2 = figure;
cm = confusionchart(testLabels_30s,predLabel_2);
cm.Title = 'MFCC 1 excluded';
cm.RowSummary = 'row-normalized';
hgexport(fig2, 'part2_confusion_2.eps');

fig3 = figure;
cm = confusionchart(testLabels_30s,predLabel_3);
cm.Title = 'Spectral centroid mean excluded';
cm.RowSummary = 'row-normalized';
hgexport(fig3, 'part2_confusion_3.eps');

fig4 = figure;
cm = confusionchart(testLabels_30s,predLabel_4);
cm.Title = 'Tempo excluded';
cm.RowSummary = 'row-normalized';
hgexport(fig4, 'part2_confusion_4.eps');