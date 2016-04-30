clear all;
close all;
clc;

%% Load the dataset 
load iris_dataset.mat
x = zscore(irisInputs([2 4],:)');
t = irisTargets(1,:)' + 2*irisTargets(2,:)' + 3*irisTargets(3,:)';

n_samples = size(x,1);
n_samples_train = n_samples*0.8;
n_samples_test = n_samples*0.2; % 20% of the dataset is used for training

% Shuffle the data 
perm = randperm(n_samples);
t_s = t(perm);
x_s = x(perm,:);

t_train = t_s(1:n_samples_train);
x_train = x_s(1:n_samples_train,:); 

t_test = t_s(n_samples_train+1:n_samples_train+n_samples_test);
x_test = x_s(n_samples_train+1:n_samples_train+n_samples_test,:);

k_max = 50;
%gscatter(x_s(:,1),x_s(:,2),t_s);
%hold on

%% Performance Test
for kk=1:k_max
    test_model = fitcknn(x_train,t_train,'NumNeighbors',kk);
    pred_t = predict(test_model,x_test);
    test_error(kk) = n_samples_test - sum(pred_t == t_test); 
end

%% Training Accuracy

for kk=1:k_max
    model = fitcknn(x_train,t_train,'NumNeighbors',kk);
    pred_t = predict(model,x_train);
    val_e_t(kk) = n_samples_train - sum(t_train == pred_t);
end

[~,best_k_t] = min(val_e_t);

subplot(2,2,1)
plot([1:k_max],[val_e_t; test_error],'-x')
title(['Training Accuracy - Best K: ' num2str(best_k_t)])
grid on
xlabel('K');
ylabel('# Missclassified points');
legend('Train Error','Test Error');

%% Validation Accuracy
n_samples_val = n_samples_train*0.25;
n_samples_val_train = n_samples_train*0.75;

x_train_val = x_train(1:n_samples_val_train,:);
t_train_val = t_train(1:n_samples_val_train);

x_val = x_train(n_samples_val_train+1:n_samples_val_train+n_samples_val,:);
t_val = t_train(n_samples_val_train+1:n_samples_val_train+n_samples_val);

for kk=1:k_max
    model = fitcknn(x_train_val,t_train_val,'NumNeighbors',kk);
    pred = predict(model,x_val);
    val_e(kk) = n_samples_val - sum(pred == t_val);
end
[~,best_k_v] = min(val_e);

subplot(2,2,2)
plot([1:k_max],[val_e; test_error],'-x')
title(['Validation Accuracy - Best K: ' num2str(best_k_v)])
grid on
xlabel('K');
ylabel('# Missclassified points');
legend('Validation Error','Test Error');

%% k-fold cross-validation
kx = 10;

folds_i = crossvalind('KFold',n_samples_train,kx);
for kk=1:k_max
    val_e_p = [];
    for ii=1:kx
       val_x = x_train(folds_i == ii,:);
       val_t = t_train(folds_i == ii);
       fold_x = x_train(folds_i ~= ii,:);
       fold_t = t_train(folds_i ~= ii);
       
       model = fitcknn(fold_x, fold_t, 'NumNeighbors',kk);
       
       pred_v  = predict(model, val_x);
       %Measure the error
       val_e_p(ii) = (n_samples_train/kx) - sum(val_t == pred_v);
    end
    val_e(kk) = mean(val_e_p);
end
[~,best_k_x] = min(val_e);

subplot(2,2,3)
plot([1:kk],[val_e; test_error],'x-')
title(['Cross Validation Error - Best K: ' num2str(best_k_x)]);
grid on;
xlabel('K');
ylabel('# Missclassified points');
legend('Validation Error','Test Error');

%% Final training for cross-validation and plotting

%Train with the chosen k
final_model = fitcknn(x_train,t_train,'NumNeighbors',best_k_x);

%Plots the results
subplot(2,2,4)
[a, b] = meshgrid(-3:0.1:3,-3:0.1:4);
axis tight
pred_f = predict(final_model,[a(:),b(:)]);
gscatter(x_train(:,1),x_train(:,2),t_train);
hold on
gscatter(a(:),b(:),pred_f);
title([num2str(kx) '-Fold Cross Validated ' num2str(best_k_x) '-NN classifier']);


