clear;
% Define the labels
pop = 0; metal = 1; disco = 2; classical = 5;

labels = ["pop", "metal", "disco", "blues", "reggae", "classical", "rock", "hip hop", "country", "jazz"];
spectral_rollof_mean = 9; mfcc_1_mean = 40; spectral_centroid_mean = 5; tempo = 39;

numFeatures = 4;
features = [spectral_rollof_mean, mfcc_1_mean, spectral_centroid_mean, tempo];

[fullTrainingSet, fullTestSet] = dataExtraction('GenreClassData_30s.txt');

trainingSet = NaN(size(fullTrainingSet,1), numFeatures+1);

for i = 1:numFeatures
    trainingSet(:,i) = fullTrainingSet(:,features(i));
end
trainingSet(:,end) = fullTrainingSet(:,end);
sizeTrainingSet = size(trainingSet,1);

%% Separate training set by genre

% Initialize genre data sets, and indices for iteration
popSet          = NaN(79,numFeatures); popIndex = 1;
metalSet        = NaN(80,numFeatures); metalIndex = 1;
discoSet        = NaN(79,numFeatures); discoIndex = 1;
classicalSet    = NaN(79,numFeatures); classicalIndex = 1;

% Separate training set by genre
for dataPoint=1:sizeTrainingSet
    if trainingSet(dataPoint,end) == pop
        popSet(popIndex,:) = trainingSet(dataPoint, 1:numFeatures);
        popIndex = popIndex + 1;

    elseif trainingSet(dataPoint,end) == metal
        metalSet(metalIndex,:) = trainingSet(dataPoint, 1:numFeatures);
        metalIndex = metalIndex + 1;

    elseif trainingSet(dataPoint,end) == disco
        discoSet(discoIndex,:) = trainingSet(dataPoint, 1:numFeatures);
        discoIndex = discoIndex + 1;

    elseif trainingSet(dataPoint,end) == classical
        classicalSet(classicalIndex,:) = trainingSet(dataPoint, 1:numFeatures);
        classicalIndex = classicalIndex + 1;
    end
end

%% Plot histograms for the 4 features
close all;

fig1 = figure;

subplot(221);
histogram(popSet(:,1),10); hold on; grid on;
histogram(metalSet(:,1),10);
histogram(discoSet(:,1),10);
histogram(classicalSet(:,1),10);
title('Spectral rolloff mean');
legend('Pop', 'Metal', 'Disco', 'Classical');

subplot(222);
histogram(popSet(:,2),10); hold on; grid on;
histogram(metalSet(:,2),10);
histogram(discoSet(:,2),10);
histogram(classicalSet(:,2),10);
title('MFCC 1 mean');

subplot(223);
histogram(popSet(:,3),10); hold on; grid on;
histogram(metalSet(:,3),10);
histogram(discoSet(:,3),10);
histogram(classicalSet(:,3),10);
title('Spectral centroid mean');

subplot(224);
histogram(popSet(:,4),10); hold on; grid on;
histogram(metalSet(:,4),10);
histogram(discoSet(:,4),10);
histogram(classicalSet(:,4),10);
title('Tempo');

set(fig1,'position',[100,100,800,500])
hgexport(fig1, 'histograms_byFt.eps');

%% Plot histograms for all 4 genres
fig2 = figure;

subplot(221);
histogram(popSet(:,1),10); hold on; grid on;
histogram(popSet(:,2),5);
histogram(popSet(:,3),10);
histogram(popSet(:,4),2);
title('Pop');
legend('Spectral rolloff mean','MFCC 1 mean','Spectral centroid mean', 'Tempo');

subplot(222);
histogram(metalSet(:,1),10); hold on; grid on;
histogram(metalSet(:,2),5);
histogram(metalSet(:,3),10);
histogram(metalSet(:,4),2);
title('Metal');

subplot(223);
histogram(discoSet(:,1),10); hold on; grid on;
histogram(discoSet(:,2),5);
histogram(discoSet(:,3),10);
histogram(discoSet(:,4),2);
title('Disco');

subplot(224);
histogram(classicalSet(:,1),10); hold on; grid on;
histogram(classicalSet(:,2),5);
histogram(classicalSet(:,3),10);
histogram(classicalSet(:,4),2);
title('Classical');

set(fig2,'position',[300,300,800,500])
hgexport(fig2, 'histograms_byGen.eps');