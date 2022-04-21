function dim_features = dimension_feature (nFeatures, nMax, nCases)

dim_features = [];
nRows = 0;
maxIter = nCases - 1;
while nRows < maxIter
    features = [];
    while (length(features) < nFeatures)
        randID = randi([1 nMax]);
        if ~ismember(randID, features)
            features = [features randID];
        end
    end
    sorted_features = sort(features);
    nRows = size(dim_features, 1);
    for row=1: nRows
        if sorted_features == dim_features(row)
            features = [];
            continue
        end
    end
    dim_features= [dim_features; sorted_features];
end
end