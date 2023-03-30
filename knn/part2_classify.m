clear; addpath("../utilities");
%% Extract data
[fullTrainingSet, fullTestSet] = dataExtraction('GenreClassData_30s.txt');

%% Define constants
labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
chartTitles = ["No features removed", "One feature removed", "Two features removed", "Three features removed"];
fileExportNames = ["none_removed", "one_removed.eps", "two_removed.eps", "three_removed.eps"];

spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5; tempo = 39;

features = [spectral_rollof_mean, spectral_centroid_mean, mfcc_1_mean, tempo];

numFeatures = size(features,2); numTests = size(fullTestSet,1);

%% Normalize data
fullTrainingSetNorm = normalizeSet(fullTrainingSet);
fullTestSetNorm     = normalizeSet(fullTestSet);

%% Classify once for each set of features
close all;
errorRates = zeros(size(features,1),1);

for i = 1:4
    %% Build training set and test set with selected features
    itFeatures = features(1:end-(i-1));
    numItFeatures = size(itFeatures,2);

    trainingSet = NaN(size(fullTrainingSetNorm,1), numItFeatures+1);
    testSet = NaN(size(fullTestSetNorm,1), numItFeatures+1);

    for j = 1:numItFeatures
        trainingSet(:,j) = fullTrainingSetNorm(:,itFeatures(j));
        testSet(:,j) = fullTestSetNorm(:,itFeatures(j));
    end
    trainingSet(:,end) = fullTrainingSetNorm(:,end);
    testSet(:,end) = fullTestSetNorm(:,end);
    
    %% Classify test set
    
    % Initialize label arrays for the four tests
    predLabel       = NaN(numTests,1);
    predLabelStr    = string(zeros(numTests,1));
    trueLabel       = testSet(:,end);
    trueLabelStr    = string(zeros(numTests,1));
    
    for testItem=1:numTests
        % Classify with knn
        predLabel(testItem) = knn(5, testSet(testItem,:), trainingSet);

        % Store predicted labels as numbers and strings
        predLabelStr(testItem) = labels(predLabel(testItem)+1);
        trueLabelStr(testItem) = labels(testSet(testItem, end)+1);
    end

    %% Error rate
    errorRates(i) = getErrorRate(predLabel, trueLabel);

    %% Plot confusion charts
    fig = figure;
    cm = confusionchart(trueLabelStr,predLabelStr);
    cm.Title = chartTitles(i);
    cm.RowSummary = 'row-normalized';
    hgexport(fig, append("figs/part2_", fileExportNames(i)));
end