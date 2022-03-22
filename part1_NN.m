%% Description
% (a) Design a k-NN classifier (with k = 5) for all ten genres using only the following four features:
%       - spectral rolloff mean
%       - mfcc 1 mean
%       - spec- tral centroid mean
%       - tempo
% (b) Evaluate the performance of the classifier by finding
%       - the confusion matrix and
%       - the error rate for the test set
% (c) Discuss some of the misclassified tracks.
%     Do you as a human agree with the classifier for some of the incorrect classifications?

clear

%% Extract data
part1_dataExtract

%% Code
Mdl = fitcknn(trainingSet_30s, trainingLabels_30s, 'NumNeighbors', 5);

prediction = NaN(1,size(testSet_30s,1));
for i=1:size(testSet_30s,1)
    prediction(i) = predict(Mdl, testSet_30s(i,:));
end
disp('Classification done');

figure
confusionchart(trueLabels_30s,prediction);