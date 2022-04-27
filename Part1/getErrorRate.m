function errorRate = getErrorRate(predictedLabels,trueLabels)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUT:                                                  %%%
%%%   predictedLabels: array of labels predicted by         %%%
%%%                    classifier                           %%%
%%%   trueLabels: array of the target labels of the         %%%
%%%               classification                            %%%
%%% OUTPUT:                                                 %%%
%%%   errorRate: Percentage wrongly classified              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Find number of correctly classified observations
    numCorrectClass = size(find(predictedLabels == trueLabels(:,end)),1);
    numTests = size(predictedLabels,1);

    % Calculate error rate
    errorRate = 100 * (numTests - numCorrectClass) / numTests;
    
end

