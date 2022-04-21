% Done
function [x_train, y_train, x_test, y_test, train_distance] = choosen_subdata (filePath, particleFeatures, nFeatures)

%% This Function Is Used To Extract The Traing And Test Data Regarding The Selected Features
data = importdata(filePath);
feature_data = data(:, 2:end);
label_data = data(:, 1);

%% nTrainSamples = fix(length(myData) * 80/100);
%%trainData = myData(1:nTrainSamples, :);
%%testData = myData(nTrainSamples + 1: end, :);

%% Train Data
% Class 1
class_1 = find(label_data(:,1) == 1);
class_1_train = fix(length(class_1) * 80/100);
% Class 2
class_2 = find(label_data(:,1) == 2);
class_2_train = fix(length(class_2) * 80/100);
% Class 3
class_3 = find(label_data(:,1) == 3);
class_3_train = fix(length(class_3) * 80/100);
% Y Trian
y_train = label_data(1:class_1_train,1);
y_train = [y_train; label_data(length(class_1) + 1 : length(class_1) + 1 + class_2_train,1)];
y_train = [y_train; label_data(length(class_1) + length(class_2) +1 : length(class_1) + length(class_2) + class_3_train + 1,1)];
% X Train
x_train_all = feature_data(1:class_1_train,1:end);
x_train_all = [x_train_all; feature_data(length(class_1) + 1 : length(class_1) + 1 + class_2_train,1:end)];
x_train_all = [x_train_all; feature_data(length(class_1) + length(class_2) +1 : length(class_1) + length(class_2) + class_3_train + 1,1:end)];

% Y Test
y_test = label_data(length(class_1_train)+1 : length(class_1),1);
y_test = [y_test; label_data(length(class_1) + class_2_train + 1 : length(class_1) + length(class_2),1)];
y_test = [y_test; label_data(length(class_1) + length(class_2) + class_3_train + 1 : length(class_1) + length(class_2) + length(class_3),1)];
% X Test
x_test_all = feature_data(length(class_1_train)+1 : length(class_1),1:end);
x_test_all = [x_test_all; feature_data(length(class_1) + class_2_train + 1 : length(class_1) + length(class_2),1:end)];
x_test_all = [x_test_all; feature_data(length(class_1) + length(class_2) + class_3_train + 1 : length(class_1) + length(class_2) + length(class_3),1:end)];

x_train = [];
x_test = [];
feat_len = length(particleFeatures);

for j=1: feat_len
    f = particleFeatures(j);
    x_train = [x_train x_train_all(:,f)];
    x_test = [x_test x_test_all(:,f)];
end
train_distance = [y_train x_train];