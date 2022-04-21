% Done
function distance = filter_distance(x_train)

%% Filter Function To Calculate The Distance Between Each Two Instance OF The Training Data
% dB distance: is the distance between instances of the same classes 
% dW distance: is the distance between instances of different classes

%% Function Specification
% This function try to minimize the distance between the instances of the
% same class and maximize the distance betwen instances of different
% classes


nInstancesTrain = size(x_train, 1);
nFeatures = size(x_train, 2);

inDist = [];
outDist = [];

for i=1: nInstancesTrain
    sum_dB = 0;
    sum_dW = 0;
    for j=1: nInstancesTrain
        if i ~= j
            if x_train(i,1) == x_train(j,1)
                dB_all = [];
                for d=2:nFeatures
                    dB = abs(x_train(i,d) - x_train(j,d));
                    dB_all = [dB_all, dB];
                end
                max_dB = max(dB_all);
                sum_dB = sum_dB + max_dB;
            elseif x_train(i,1) ~= x_train(j,1)
                dW_all = [];
                for d=2:nFeatures
                    dW = abs(x_train(i,d) - x_train(j,d));
                    dW_all = [dW_all, dW];
                end
                mix_dW = min(dW_all);
                sum_dW = sum_dW + mix_dW;
            end
        end
    end
end


Db = (1 / nInstancesTrain) * sum_dB;
Dw = (1 / nInstancesTrain) * sum_dW;
if nFeatures > 1
    distance = 1 / ( 1 + exp( -5*( Db - Dw )));
else
    distance = 0;
end
end