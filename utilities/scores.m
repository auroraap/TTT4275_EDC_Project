function scoresArray = scores(trainingSet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUT:                                                  %%%
%%%   trainingSet: [[features], label] for each datapoint   %%%
%%% OUTPUT:                                                 %%%
%%%   scoresArray: an array of scores for each feature      %%%
%%%                indicating which features have the       %%%
%%%                biggest distance between the genre means %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    numFeatures = size(trainingSet, 2) - 1; numGenres   = 10;
    
    % Initialize matrices
    meanMatrix = NaN(numFeatures, numGenres);
    scoresArray = NaN(numFeatures, 1);
    
    % Repeat for each feature
    for ft = 1:numFeatures
        % Calculate the mean of the entire feature for each respective
        % genre
        for gen = 1:numGenres
            indexArray = find(trainingSet(:,end) == gen-1);
            meanMatrix(ft, gen) = mean(trainingSet(indexArray(1):indexArray(end), ft));
        end

        scoresArray(ft) = 0;

        % Calculate sum of distances between all feature means
        for i = 1:numGenres
            for j = 1:numGenres
                scoresArray(ft) = scoresArray(ft) + abs(meanMatrix(ft, i) - meanMatrix(ft, j));
            end
        end

    end

end

