function label = knn(k,observation,trainingSet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS                                                           %%%
%%%   k: the number of neighbors used to classify the observation    %%%
%%%   observation: [[properties], label]                             %%%
%%%   trainingSet: [[properties], label] for each datapoint          %%%
%%%   numProperties: number of properties used to classify the       %%%
%%%                observation                                       %%%
%%% OUTPUT                                                           %%%
%%%   label: the label that the observation is classified as         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sizeTrainingSet = size(trainingSet,1);
    
    % initialize array of distances and differances
    distMatrix = NaN(sizeTrainingSet,2);
    
    % Find difference between observation and each datapoint for each property
    for dataPoint=1:sizeTrainingSet
        % Find the distance between observation and each datapoint
        distance = dist(observation(1:end-1), trainingSet(dataPoint,1:end-1)');
        label = trainingSet(dataPoint,end);
        distMatrix(dataPoint,:) = [distance, label];
    end
    
    % Sort by distance and select the k smallest
    distMatrix = sortrows(distMatrix);
    neighbors = distMatrix(1:k,:);
    
    % Count number of neighbors in each class
    bins = zeros(10,1);
    for neighbor=1:k
        bins(neighbors(neighbor,2)+1) = bins(neighbors(neighbor,2)+1) + 1;
    end
    
    % Find the genres that make up the majority vote
    maxval = max(bins);
    maxGenres = find(bins == maxval);

    % Select nearest majority class among multiple majority classes
    if size(maxGenres,1) > 1
        for i=1:k
            if any(maxGenres == neighbors(i,2))
                label = neighbors(i,2);
                break
            end
        end
    % or choose the single majority class
    else 
        label = maxGenres-1;
    end

end