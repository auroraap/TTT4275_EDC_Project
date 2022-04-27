function label = knn(k,observation,trainingSet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS:                                                          %%%
%%%   k: the number of neighbors used to classify the observation    %%%
%%%   observation: [[features], label]                               %%%
%%%   trainingSet: [[features], label] for each datapoint            %%%
%%% OUTPUT:                                                          %%%
%%%   label: the label that the observation is classified as         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sizeTrainingSet = size(trainingSet,1);

% Initialize array of distances and labels
distMatrix = NaN(sizeTrainingSet,2);

% Find difference between observation and each datapoint for each property
for dataPoint=1:sizeTrainingSet
    % Find the distance between observation and each datapoint
    distance = dist(trainingSet(dataPoint,1:end-1), observation(1:end-1)');
    label = trainingSet(dataPoint,end);
    distMatrix(dataPoint,:) = [distance, label];
end

distMatrix = sortrows(distMatrix, 1); % Sort by distance
neighbors = distMatrix(1:k,:);        % Select the k first

bins = zeros(10,1);
for i = 1:k
    bins(neighbors(i,2) + 1) = bins(neighbors(i,2) + 1) + 1;
end
% disp('Bins:')
% disp(bins)
% [maxValue, ~] = max(bins);
% maxIndex = find(bins == maxValue);
% disp('maxIndex:');
% disp(maxIndex);
% disp('Neighbors');
% disp(neighbors);
% 
% if (size(maxIndex,1) > 1)
%     neighborDistArray = zeros(size(maxIndex));
%     for neighbor = 1:k
%         if find(maxIndex == neighbors(neighbor,2)+1)
%             ind = find(maxIndex == neighbors(neighbor,2)+1);
%             neighborDistArray(ind(1)) = neighborDistArray(ind(1)) + neighbors(neighbor,1);
%         end
%     end
%     
%     [~, retIndex] = min(neighborDistArray);
%     label = maxIndex(retIndex) - 1;
%     disp('Label in if:')
%     disp(label);
% 
% else
%     label = neighbors(1,2);
%     disp('Label in else:')
%     disp(label);
% end

maxval = max(bins);
maxGenres = find(bins == maxval);

    %%% OPTION 1
    if size(maxGenres,1) > 1
        for i=1:k
            if any(maxGenres == neighbors(i,2)) % any(A(:) == 5)
                label = neighbors(i,2);
                break
            end
        end
    else
        label = maxGenres-1;
    end

end