%Done
function [yTrain, xTrain, yTest, xTest] = split_data (filePath, nFeatures)

%% This function is used to split the data to train and test data
data = importdata(filePath);
myData = data(:, 1:nFeatures+1);


dataOutput = myData(:,1);
dataInput = myData(:, 2:nFeatures+1);

 
%% Train Data
% Class 1
class1 = find(dataOutput(:,1) == 1);
class1Train = fix(length(class1) * 80/100);
% Class 2
class2 = find(dataOutput(:,1) == 2);
class2Train = fix(length(class2) * 80/100);
% Class 3
class3 = find(dataOutput(:,1) == 3);
class3Train = fix(length(class3) * 80/100);
% Y Trian
yTrain = myData(1:class1Train,1);
yTrain = [yTrain; myData(length(class1) + 1 : length(class1) + 1 + class2Train,1)];
yTrain = [yTrain; myData(length(class1) + length(class2) +1 : length(class1) + length(class2) + class3Train + 1,1)];
% X Train
xTrain = myData(1:class1Train,2:nFeatures+1);
xTrain = [xTrain; myData(length(class1) + 1 : length(class1) + 1 + class2Train,2:nFeatures+1)];
xTrain = [xTrain; myData(length(class1) + length(class2) +1 : length(class1) + length(class2) + class3Train + 1,2:nFeatures+1)];

%% Test Data
% Y Test
yTest = myData(class1Train: length(class1),1);
yTest = [yTest; myData(length(class1) + class2Train + 1 : length(class1) + length(class2) ,1)];
yTest = [yTest; myData(length(class1) + length(class2) + class3Train + 1 : length(class1) + length(class2) + length(class3) ,1)];
% X Test
xTest = myData(class1Train: length(class1),2:nFeatures+1);
xTest = [xTest; myData(length(class1) + class2Train + 1 : length(class1) + length(class2) ,2:nFeatures+1)];
xTest = [xTest; myData(length(class1) + length(class2) + class3Train + 1 : length(class1) + length(class2) + length(class3) ,2:nFeatures+1)];
end