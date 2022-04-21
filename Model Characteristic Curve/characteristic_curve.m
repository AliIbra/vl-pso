clear title xlabel ylabel

load('.\Results\overall_accuracy.mat')
load('.\Results\accuracy_average.mat')

n = [4, 5, 6, 7, 8, 9, 10, 11];

x = [];
y = [];

n_len = length(n);
for i=1:n_len
    x = [x, n(i)];
    y = [y, overall_avg(i)];
end

subplot(2,1,1);
plot(x,y, 'color', 'red')
xlabel('Number of Features')
ylabel('Accuracy')
title('Figure: The average accuracy with each number of features')

x = [];
y = [];

n_len = length(n);
for i=1:n_len
    for j =1 :10
        x = [x, n(i)];
        y = [y, overall_acc(i,j)];
    end
    
end

subplot(2,1,2);
plot(x,y,'o','color', 'red')
xlabel('Number of Features')
ylabel('Accuracy')
title('Figure: The all accuracy with each number of features')