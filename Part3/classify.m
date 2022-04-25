%% Extract data
clear; dataExtract;

%% Define constants
numTests = size(testSet,1); numFeatures = size(featureSet,2);
predeterminedFeatures = [spectral_rollof_mean_col, mfcc_1_mean_col, spectral_centroid_mean_col];

% Initialize storing of each test result
testResults = zeros(numFeatures,1);

%% Determine the best feature
for testFeature=1:numFeatures
        % Initialize predicted labels array
        predLabels = NaN(numTests,1);
        % Define this iteration's training and test sets
        train = [data_30s(1:trainingFinal,spectral_rollof_mean_col), data_30s(1:trainingFinal,mfcc_1_mean_col), data_30s(1:trainingFinal,spectral_centroid_mean_col), data_30s(1:trainingFinal,testFeature+1), trainingLabels_30s];
        test = [data_30s(testFirst:end,spectral_rollof_mean_col), data_30s(testFirst:end,mfcc_1_mean_col), data_30s(testFirst:end,spectral_centroid_mean_col), data_30s(testFirst:end,testFeature+1), testLabels_30s];
        
        % Classify using knn
        for testItem=1:numTests
            predLabels(testItem) = knn(5, test(testItem,2:end), train(:,2:end));
        end

        % Find the amount of correctly classified samples, and store
        result = predLabels - testLabels_30s;
        testResults(testFeature) = sum(result(:) == 0);
end

% Select the test which produced the most correct classifications
[maxVal, selectedFeature] = max(testResults);

%% Classify with the best feature

predLabels = NaN(numTests,1);
trainingSetModified = [data_30s(1:trainingFinal,spectral_rollof_mean_col), data_30s(1:trainingFinal,mfcc_1_mean_col), data_30s(1:trainingFinal,spectral_centroid_mean_col), data_30s(1:trainingFinal,selectedFeature+1), trainingLabels_30s];
testSetModified = [data_30s(testFirst:end,spectral_rollof_mean_col), data_30s(testFirst:end,mfcc_1_mean_col), data_30s(testFirst:end,spectral_centroid_mean_col), data_30s(testFirst:end,selectedFeature+1), testLabels_30s];

for testItem=1:numTests
    predLabels(testItem) = knn(5, testSetModified(testItem,2:end), trainingSetModified(:,2:end));
end

%% Plot confusion chart
close all;
fig1 = figure;
cm = confusionchart(testLabels_30s,predLabels);
cm.Title = 'Spectral centroid var included';
cm.RowSummary = 'row-normalized';
hgexport(fig1, 'part3_confusion.eps');