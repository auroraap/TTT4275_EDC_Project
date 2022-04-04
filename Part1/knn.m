function label = knn(k,observation,trainingSet,numProperties)
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
    dist = norm(diff(dataPoint,:));
    label = trainingSet(dataPoint,end);
    distArray(dataPoint,:) = [dist, label];
end

distArray = sortrows(distArray);
neighbors = distArray(1:k,:);

label = mode(neighbors(:,2),[k, 1]);

end