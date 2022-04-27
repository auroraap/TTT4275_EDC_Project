function errorRate = getErrorRate(predictedLabels,trueLabels)
    
    numCorrectClass = size(find(predictedLabels == trueLabels(:,end)),1);
    numTests = size(predictedLabels,1);
    errorRate = 100 * (numTests - numCorrectClass) / numTests;
    
end

