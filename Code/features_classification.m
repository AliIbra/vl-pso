% Done
function accuracyAll = features_classification(features_train, y_train, features_test, y_test)

%% SVM Model Accuracy Based On Each Feature Indivsualy
% Input:
% feature_train: The Features For Training
% y_train: The Class For The Training Data
% feature_test: The Features For Testing
% y_test: The Class For The Test Data
% Output:
% accuracyAll: An List Contain Each Feature's Accuracy and Index

nFeatures = length(features_train(1,:));
accuracyAll = [];
for i=1: nFeatures
    PMDL = fitcecoc(features_train(:, i), y_train);
    y_out = predict(PMDL, features_test(:, i));
    accuracy = accuracy_calculate(y_test, y_out);
    accuracyAll = [accuracyAll; accuracy i ];    
end
end