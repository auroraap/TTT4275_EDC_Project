function label = knn(k,observation,trainingSet,numProperties)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% k: the number of neighbors used to classify the observation      %%%
%%% observation: [[properties], label]                           %%%
%%% trainingSet: [[properties], label] for each datapoint        %%%
%%% numProperties: number of properties used to classify the         %%%
%%%                observation                                       %%%
%%% label: the label that the observation is classified as           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizeTrainingSet = size(trainingSet,1);

% initialize array of distances and differances
distMatrix = NaN(sizeTrainingSet,2);
diff      = NaN(1,numProperties);

% Find difference between observation and each datapoint for each property
for dataPoint=1:sizeTrainingSet
    for property=1:numProperties
        diff(property) = observation(property) - trainingSet(dataPoint,property);
    end
    % Find the distance between observation and each datapoint
    dist = norm(diff);
    label = trainingSet(dataPoint,end);
    distMatrix(dataPoint,:) = [dist, label];
end

distMatrix = sortrows(distMatrix);
neighbors = distMatrix(1:k,:);

label = mode(neighbors(:,2),[k, 1]);

end