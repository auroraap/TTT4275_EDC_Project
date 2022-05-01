function scoresArray = scores(trainingSet)
    numFeatures = size(trainingSet, 2) - 1;
    numGenres   = 10;
    
    meanMatrix = NaN(numFeatures, numGenres);
    scoresArray = NaN(numFeatures, 1);
    
    for ft = 1:numFeatures
        for gen = 1:numGenres
            indexArray = find(trainingSet(:,end) == gen-1);
            meanMatrix(ft, gen) = mean(trainingSet(indexArray(1):indexArray(end), ft));
        end

        scoresArray(ft) = 0;

        for i = 1:numGenres
            for j = 1:numGenres
                scoresArray(ft) = scoresArray(ft) + abs(meanMatrix(ft, i) - meanMatrix(ft, j));
            end
        end

    end

end

