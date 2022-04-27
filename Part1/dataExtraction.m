function [trainingSet,testSet] = dataExtraction(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS:                                                         %%%
%%%   filename: The file containing data for classification         %%%
%%%             The training set must come first                    %%%
%%%             The test set must come second                       %%%
%%% OUTPUT:                                                         %%%
%%%   trainingSet: The training set on format [[features], label]   %%%
%%%   testSet:     The test set on format [[features], label]       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Read numerical data from file
    data = readmatrix(filename);
    
    % Find switch from training set to test set by looking for switch in
    % IDs
    for i=2:size(data,1)
        if (data(i-1,1) > data(i,1))
            trainingFinal = i-1;
            testFirst = i;
            break;
        end
    end

    % Put together trainingSet and testSet
    trainingFeatures = data(1:trainingFinal,2:end-3);
    testFeatures = data(testFirst:end,2:end-3);

    trainingLabels = data(1:trainingFinal,end-2);
    testLabels = data(testFirst:end,end-2);

    trainingSet         = [trainingFeatures, trainingLabels];
    testSet             = [testFeatures, testLabels];
end

