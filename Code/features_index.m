% Done
function featuresIndex = features_index(features, rankedFeatures)

%% This Function Is Used For Extracting The Real Index For The Features In Data Files
featuresIndex = [];
for i=1: length(features)
    for j=1:size(rankedFeatures,1)
        if features(i) == j
            featuresIndex = [featuresIndex, rankedFeatures(j, 2)];
        end
    end
end
end