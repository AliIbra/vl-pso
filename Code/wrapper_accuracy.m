% Done
function balanced_accuracy = wrapper_accuracy (y_test ,y_out ,nClasses)

%% Wrapper Function To Calculate The Accuracy Of The Classification Preformance On The Test Data
% balancrd_accuracy: is the TRUE POSITUIVE RATIO TPR.

%% Function Specification
% This function is calculating the TPR of each class indivisualy and then
% calculate the overall accurcy for all classes
acc_all=0;
sum_accuracy = 0;

for c=1:nClasses
    acc = 0;
    class_len = 0;
    for i = 1 : length(y_test)
        if ( y_test(i , 1) == c )
            class_len = class_len + 1; 
            if (y_out(i , 1) == y_test(i , 1))
                acc = acc + 1;
            end
        end
    end
acc_all = acc / class_len ;
sum_accuracy = sum_accuracy + acc_all;
end

balanced_accuracy = (1 / nClasses) * sum_accuracy;
 
end