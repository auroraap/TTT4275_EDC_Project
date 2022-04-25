function label = knn(k,observation,trainingSet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% k: the number of neighbors used to classify the observation      %%%
%%% observation: [[properties], label]                               %%%
%%% trainingSet: [[properties], label] for each datapoint            %%%
%%% numProperties: number of properties used to classify the         %%%
%%%                observation                                       %%%
%%% label: the label that the observation is classified as           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizeTrainingSet = size(trainingSet,1);
opt = 1;
% initialize array of distances and differances
distMatrix = NaN(sizeTrainingSet,2);

% Find difference between observation and each datapoint for each property
for dataPoint=1:sizeTrainingSet
    % Find the distance between observation and each datapoint
    distance = dist(observation(1:end-1), trainingSet(dataPoint,1:end-1)');
    label = trainingSet(dataPoint,end);
    distMatrix(dataPoint,:) = [distance, label];
end

distMatrix = sortrows(distMatrix);
neighbors = distMatrix(1:k,:);

bins = zeros(10,1);
for neighbor=1:k
    bins(neighbors(neighbor,2)+1) = bins(neighbors(neighbor,2)+1) + 1;
end

maxval = max(bins);
maxGenres = find(bins == maxval);

if opt==1
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
elseif opt == 2
%%%%% OPTION 2
    label = mode(neighbors(:,2),[k, 1]);
end
%%%%% OPTION 3
% if size(maxGenres,1) == 1
%     label = maxGenres-1;
% elseif size(maxGenres,1) == 2
%     sum = zeros(2);
%     for neighbor=1:size(neighbors,1)
%         for genre=1:size(maxGenres,1)
%         if neighbors(neighbor,2) == maxGenres(genre)
%             sum(genre) = sum(genre) + neighbors(neighbor,1);
%         end
% %         elseif neighbors(neighbor,2) == maxGenres(2)
% %             sum(2) = sum(2) + neighbors(neighbor,1);
% %         end
%         end
%     end
%     [~, index] = min(sum);
%     disp(maxGenres)
%     disp(index(1));
%     label = maxGenres(index(1))-1;
% 
% elseif size(maxGenres,1) == 5
%     label = neighbors(1,2);
% end

disp('New iteration');
disp(label);


end