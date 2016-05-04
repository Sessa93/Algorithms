clear all;
close all;
clc;

%% Load the dataset
load iris_dataset.mat
N = size(irisInputs,2);
t = irisTargets';

perm = randperm(N);
t = t(perm,:);
n_f = 4; %Max nums of features

%% FW stepwise features selection
%Discrimination: evaluate the accuracy on a logistic regression model

f_perm = randperm(n_f);
F = [];

% 10-Fold cross validation
folds_i = crossvalind('KFold',N,10);
for ii=1:n_f
    val_e_p = [];
    F = [F f_perm(ii)];
    x = zscore(irisInputs(F,:)');
    x = x(perm,:);
    for jj=1:10
       val_x = x(folds_i == jj,:);
       val_t = t(folds_i == jj,:);
       val_t = val_t(:,1) + 2*val_t(:,2) + 3*val_t(:,3);
       
       fold_x = x(folds_i ~= jj,:);
       fold_t = t(folds_i ~= jj,:);
       
       [B,~,~] = mnrfit(fold_x,fold_t);
       P = mnrval(B,val_x);
       [~,pred_v] = max(P,[],2); 
       
       %Measure the error
       val_e_p(jj) = (N/10) - sum(val_t == pred_v);
    end
    val_e_fw(ii) = mean(val_e_p);

    g=sprintf('%d ', F);
    fprintf('Using: %s, Error: %.8f\n', g, val_e_fw(ii))
end

%% Stepwise backward features selection


f_perm = randperm(n_f);
F = [1 2 3 4];

% 10-Fold cross validation
folds_i = crossvalind('KFold',N,10);
for ii=1:n_f
    val_e_p = [];
    
    x = zscore(irisInputs(F,:)');
    x = x(perm,:);
    for jj=1:10
       val_x = x(folds_i == jj,:);
       val_t = t(folds_i == jj,:);
       val_t = val_t(:,1) + 2*val_t(:,2) + 3*val_t(:,3);
       
       fold_x = x(folds_i ~= jj,:);
       fold_t = t(folds_i ~= jj,:);
       
       [B,~,~] = mnrfit(fold_x,fold_t);
       P = mnrval(B,val_x);
       [~,pred_v] = max(P,[],2); 
       
       %Measure the error
       val_e_p(jj) = (N/10) - sum(val_t == pred_v);
    end
    val_e_bckw(ii) = mean(val_e_p);
    
    g=sprintf('%d ', F);
    fprintf('Using: %s, Error: %.8f\n', g, val_e_bckw(ii))
    
    F = F(F ~= f_perm(ii));
end
