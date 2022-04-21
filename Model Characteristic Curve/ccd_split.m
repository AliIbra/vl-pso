function acc = ccd_split (features ,nFeatures,file_path)

data = importdata(file_path);

my_data = data;

%% Split data into 40% training and 60% testing

class_a = find(my_data(:,1) == 1);
class_a_train = fix(length(class_a) * 60/100);
disp(class_a_train);

class_b = find(my_data(:,1) == 2);
class_b_train = fix(length(class_b) * 60/100);
disp(class_b_train);

class_c = find(my_data(:,1) == 3);
class_c_train = fix(length(class_c) * 60/100);
disp(class_c_train);

train_sub_data = my_data(1:class_a_train,1:end);
train_sub_data = [train_sub_data; my_data(length(class_a) + 1 : length(class_a) + class_b_train, 1: end)];
train_sub_data = [train_sub_data; my_data(length(class_a) + length(class_b) + 1: length(class_a) + length(class_b) + class_c_train, 1:end)];
x_train_data_subset = train_sub_data(:, 2:end);
y_train = train_sub_data(:, 1);
disp(length(x_train_data_subset));
disp(length(y_train));

test_sub_data = my_data(class_a_train + 1: length(class_a),1:end);
test_sub_data = [test_sub_data; my_data(length(class_a) + class_b_train + 1 : length(class_a) + length(class_b), 1: end)];
test_sub_data = [test_sub_data;my_data(length(class_a) + length(class_b) + class_c_train + 1 : length(class_a) + length(class_b) + length(class_c) ,1:end)];
x_test_data_subset = test_sub_data(:,2:end);
y_test = test_sub_data(:, 1);

disp(length(y_test));
disp(length(x_test_data_subset))

x_train=[];
x_test=[];

for it=1:nFeatures
    f = features(it);
    x_train = [x_train x_train_data_subset(:,f)];
    x_test = [x_test x_test_data_subset(:,f)];
end

PMDL = fitcecoc(x_train(:,:), y_train);
y_out = predict(PMDL, x_test(:, :));
acc = calculate_accuracy(y_test, y_out, 3);

end
