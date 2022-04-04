function nearestNeighbors = knn(k,observation,trainingSet,numProperties)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% k: the number of neighbors used to classify the observation    %%%
%%% observation: [ID, properties, label]                           %%%
%%% trainingSet: [ID, properties, label] for each datapoint        %%%
%%% numProperties: number of properties used to classify the       %%%
%%%                observation                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distArray = NaN(size(trainingSet,1),2);     % initialize array of distances

% Find difference between observation and each datapoint for each property
for property=2:numProperties+1
    diff = observation(property) - trainingSet(:,property);
end

% Find the distance between observation and each datapoint
for datapoint=1:size(trainingSet,1)
    id = trainingSet(datapoint,1);
    dist = norm(diff(datapoint,:));
    distArray(datapoint,:) = [id, dist];
end

% Sort and return the ID of the k nearest datapoints
distArray = sort(distArray,1);
nearestNeighbors = distArray(1:k,1);

end
