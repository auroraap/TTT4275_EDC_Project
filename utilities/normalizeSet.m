function normDataSet = normalizeSet(dataSet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUT:                                                  %%%
%%%   dataSet: [[features], label] for each datapoint       %%%
%%% OUTPUT:                                                 %%%
%%%   normDataSet: the dataSet z-score normalized,          %%%
%%%                and formatted the same as the input      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Define constants
    sizeDataSet = size(dataSet,2);
    
    % Initialize output
    normalizedSet = NaN(size(dataSet,1), size(dataSet,2)-1);
    
    % Normalize column by column
    for i = 1:sizeDataSet-1
        normalizedSet(:,i) = normalize(dataSet(:,i));
    end

    % Return normalized set with labels
    normDataSet = [normalizedSet, dataSet(:,end)];
end

