function [trainingSet,testSet] = dataExtraction(filename)
    data = readmatrix(filename);
    
    for i=2:size(data,1)
        if (data(i-1,1) > data(i,1))
            trainingFinal = i-1;
            testFirst = i;
            break;
        end
    end

    trainingFeatures = data(1:trainingFinal,2:end-3);
    testFeatures = data(testFirst:end,2:end-3);

    trainingLabels = data(1:trainingFinal,end-2);
    testLabels = data(testFirst:end,end-2);

    trainingSet         = [trainingFeatures, trainingLabels];
    testSet             = [testFeatures, testLabels];
end

