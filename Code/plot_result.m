%% To plot the figure you need to give the results needed file name,figure_name

% You can also un-comment the distance measure plot and update 
%  the needed plot's position

%%

load('..\Results\Sol_3.mat');
x = [];
y = [];

nIter = 200;
for i = 1 : nIter
    x = [x, BestSol(i).nFeatures];
    y =[y, BestSol(i).Accuracy];
end
plot(x,y, 'o', 'color', 'blue','linewidth', 6);
xlim([0 12])
ylim([0.9 1])
xlabel('Number of Features')
ylabel('Accuracy')
title('Figure 2-1: Accuracy for Each Number of Features')




% x= [];
% y=[];
% for i = 1 : 
%     x = [x, BestSol(i).nFeatures];
%     y =[y;BestSol(i).Distance];
% end
% subplot(2,2,3);
% plot(x,y,'o', 'color', 'red');
% xlabel('Number of Features')
% ylabel('Distance')
% title('Figure 2-4: Distance')


% x=[];
% y=[];
% for i = 1 : nIter
%     x = [x, BestSol(i).nFeatures];
%     y =[y;BestSol(i).Accuracy];
% end
% subplot(2,2,[1 2]);
% plot(x,y, 'o', 'color', 'red');
% xlabel('Number of Features')
% ylabel('Accuracy')
% title('Figure 2-3: Accuracy')


save('../Results/Figures/sol-Figure.bmp')
