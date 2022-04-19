clear; dataExtract;

% Define the labels
pop = 0; metal = 1; disco = 2; classical = 5;

% Define constants
numFeatures = 4;
sizeTrainingSet = size(trainingSet,1);

% Initialize genre data sets
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

ft1 = figure;

subplot(411); histogram(popSet(:,1),10); title('Pop');
subplot(412); histogram(metalSet(:,1),10); title('Metal');
subplot(413); histogram(discoSet(:,1),10); title('Disco');
subplot(414); histogram(classicalSet(:,1),10); title('Classical');
sgtitle('Spectral rolloff mean');
hgexport(ft1, 'ft1_hist.eps');

ft2 = figure;

subplot(411); histogram(popSet(:,2),10); title('Pop');
subplot(412); histogram(metalSet(:,2),10); title('Metal');
subplot(413); histogram(discoSet(:,2),10); title('Disco');
subplot(414); histogram(classicalSet(:,2),10); title('Classical');
sgtitle('MDCC 1 mean');
hgexport(ft2, 'ft2_hist.eps');

ft3 = figure;

subplot(411); histogram(popSet(:,3),10); title('Pop');
subplot(412); histogram(metalSet(:,3),10); title('Metal');
subplot(413); histogram(discoSet(:,3),10); title('Disco');
subplot(414); histogram(classicalSet(:,3),10); title('Classical');
sgtitle('Spectral centroid mean');
hgexport(ft3, 'ft3_hist.eps');

ft4 = figure;

subplot(411); histogram(popSet(:,4),10); title('Pop');
subplot(412); histogram(metalSet(:,4),10); title('Metal');
subplot(413); histogram(discoSet(:,4),10); title('Disco');
subplot(414); histogram(classicalSet(:,4),10); title('Classical');
sgtitle('Tempo');
hgexport(ft4, 'ft4_hist.eps');