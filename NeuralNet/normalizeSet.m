function normDataSet = normalizeSet(dataSet)

    sizeDataSet = size(dataSet,2);
    normalizedSet = NaN(size(dataSet,1), size(dataSet,2)-1);

    for i = 1:sizeDataSet-1
        normalizedSet(:,i) = normalize(dataSet(:,i));
    end

    normDataSet = [normalizedSet, dataSet(:,end)];
end

