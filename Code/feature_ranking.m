%Done
function [rankedFeatures] = feature_ranking(filePath, nFeatures) 
%% This function is used to calculate the rank of each feature

[yTrain, xTrain, yTest, xTest] = split_data(filePath, nFeatures);
% SVM Classifier & Feature Ranking
SVM_acc = features_classification(xTrain, yTrain,xTest, yTest);
rankedFeatures = sortrows(SVM_acc, -1);

%plot(rankedFeatures(:,2),rankedFeatures(:,1),'o');

end

