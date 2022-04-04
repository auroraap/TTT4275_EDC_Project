function nearestNeighbors = knn(k,observation,trainingSet,numProperties)
% observation and training set contains: [ID, properties, label]

diffArray = NaN(size(trainingSet,1),2);
distanceArray = NaN(numProperties);

for dataPoint=1:size(trainingSet,1)
    id = observation(1);
    for i=1:numProperties
        property = i+1;
        distanceArray(i) = observation(dataPoint,property) - trainingSet(dataPoint,property);
    end
    diffArray(dataPoint,:) = [id, norm(distanceArray)];
end

diffArray = sort(diffArray,1);

nearestNeighbors = diffArray(1:k,1);

end

