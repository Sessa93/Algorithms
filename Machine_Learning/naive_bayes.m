clc
clear all
close all

%% Load the dataset
load iris_dataset.mat
x = zscore(irisInputs([1 2],:)');
t = irisTargets(1,:)';
N = size(x,1);

%% Fitting - Naive Bayes Generative approach

model = fitcnb(x,t);

%Confusion Matrix
pred_t = predict(model,x);
confusion(t,pred_t)

%Plotting
figure();
[a, b] = meshgrid(-3:0.1:3,-3:0.1:4);
pred = predict(model,[a(:),b(:)]);
axis tight;
gscatter(a(:),b(:),pred);
hold on
gscatter(x(:,1),x(:,2),t,'rb','xo');
hold on

%% Point Generation

n_gen = 100;
n_dim = size(x,2);
prior = cumsum(model.Prior);
param = model.DistributionParameters;

gen_t = zeros(n_gen,1);
gen_d = zeros(n_gen,n_dim);

for ii=1:n_gen
    gen_t(ii) = find(prior > rand(),1);
    for jj=1:n_dim
        mu = param{gen_t(ii),jj}(1);
        sigma = param{gen_t(ii),jj}(2);
        gen_d(ii,jj) = normrnd(mu,sigma);
    end
end
gscatter(gen_d(:,1),gen_d(:,2),gen_t);




