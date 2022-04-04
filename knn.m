function nearestNeighbors = knn(k,observation,trainingSet)
% observation and training set contains: [ID, properties, label]
% note that this function is meant for a single observation

diffArray = NaN(size(trainingSet,1),2);

for dataPoint=1:size(trainingSet,1)
    diff = 0;
    id = observation(1);
    for property=2:size(trainingSet,2)-1
        diff = diff + (observation(dataPoint,property) - trainingSet(dataPoint,property));
    end
    diffArray(dataPoint,:) = [id, diff];
end

diffArray = sort(diffArray,1);

nearestNeighbors = diffArray(1:k,1);

end

