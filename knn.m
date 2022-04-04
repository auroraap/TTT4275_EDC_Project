function predLabel = knn(k,observation,trainingSet,numProperties)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% k: the number of neighbors used to classify the observation    %%%
%%% observation: [ID, properties, label]                           %%%
%%% trainingSet: [ID, properties, label] for each datapoint        %%%
%%% numProperties: number of properties used to classify the       %%%
%%%                observation                                     %%%
%%% label: the label that the observation is classified as         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize array of distances and differances
distArray = NaN(size(trainingSet,1),2);
diff      = NaN(size(trainingSet,1),numProperties);

% Find difference between observation and each datapoint for each property
for dataPoint=1:size(trainingSet,1)
    for property=1:numProperties
        diff(dataPoint,property) = observation(property+1) - trainingSet(dataPoint,property+1);
    end
    % Find the distance between observation and each datapoint
    id = trainingSet(dataPoint,1);
    dist = norm(diff(dataPoint,:));
    label = trainingSet(dataPoint,end);
    distArray(dataPoint,:) = [id, dist, label];
end

% Sort and return the ID of the k nearest datapoints
distArray = sort(distArray,2);
nearestNeighbors = distArray(1:k,1);

% Get most frequent label among k nearest neighbors
predLabel = mode(nearestNeighbors, 3);

end
