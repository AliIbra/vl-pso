clear all;

%%
file_path = 'C:\Users\Mr. Ali\Desktop\Rachis\Ear Recogmition\VLPSO\Data\wine.data';
nMin = 4;
nMax = 12;
nCases = 10;
dim = (nMin : nMax);
nDim = length(dim) - 1;
overall_acc =[];
overall_avg = [];
for d=1: nDim
    dim_features = dimension_feature(dim(d), nMax, nCases);
    case_acc = [];
    acc_sum = 0;
    for i=1:nCases
        features = dim_features(i,:);
        nFeatures = length(features);
        acc = ccd_split(features, nFeatures, file_path);
        acc_sum = acc_sum + acc;
        case_acc = [case_acc acc];
    end
    avg_acc = acc_sum / nCases;
    overall_acc = [overall_acc; case_acc];
    overall_avg = [overall_avg avg_acc];
end

save('.\Results\overall_accuracy.mat', 'overall_acc');
save('.\Results\accuracy_average.mat', 'overall_avg');


