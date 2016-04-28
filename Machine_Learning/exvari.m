%% Clear the workspace
clear all
close all
clc

sigma = @(x) 1./(1 + exp(-x)); % Sigmoid function

%% Load the dataset
load iris_dataset.mat
x = irisInputs(1,:)';
xc = zscore(irisInputs([1 2],:)');
tr = irisInputs(3,:)';
tc = irisTargets(1,:)';

%% Normalization
x = zscore(x);
tr = zscore(tr);

N = size(x,1);
D = 2;

%% Linear regression

fitOpt = fittype({'1', 'x'},'independent','x','dependent','t','coefficients',{'w0','w1'});
[fitres, gof] = fit(tr,x,fitOpt);
%Plotting
s = min(x):0.01:max(x);
figure(1);
plot(tr',x','x');
hold on
plot(s, fitres.w0 + s*fitres.w1)

B = ones(N,1);
B = [B x];

[l_coeff,l_fit] = lasso(B,tr);
r_coeff = ridge(tr,B,0.1);


%% Perceptron Automatic
net = perceptron;
net = train(net,xc',tc');

%Plotting
figure(2);
gscatter(xc(:,1),xc(:,2),tc);
hold on
s = -2:0.01:2.5;
plot(s, -(s * net.IW{1}(1) + net.b{1} ) / net.IW{1}(2),'k');
hold on

%% Perceptron Manual

perm = randperm(N);
diff = inf;
wp = ones(3,1);
alpha = 0.1;
tcp = tc;
tcp(tcp == 0) = -1;

while diff > 0.0001
    wold = wp;
    for ii=1:N
        if sign([1 xc(perm(ii),:)]*wp) ~= tcp(perm(ii))
            wp = wp + alpha*[1 xc(perm(ii),:)]'*tcp(perm(ii));
        end
    end
    diff = abs(mean(wp-wold));
end

s = -2:0.01:2.5;
plot(s, -(s * wp(2) + wp(1)) / wp(3),'r');
hold on

%% Logistic Regression Automatic
tcr=tc+1;
[B,~,~] = mnrfit(xc,tcr);
P = mnrval(B,xc);
axis manual
[~,pred] = max(P,[],2);
figure();
gscatter(xc(:,1),xc(:,2),pred);
hold on;
axis manual

%% Logistic Regression Manual

diff = inf;
wl = zeros(3,1);
perm = randperm(N);
alpha = 0.1;

while diff > 0.001
    wold = wl;
    for ii=1:N
        wl = wl - (alpha*(sigma(wl'*[1 xc(perm(ii),:)]') - tc(perm(ii)))*[1 xc(perm(ii),:)]');
    end
    diff = abs(mean(wl-wold));
end
gscatter(xc(:,1),xc(:,2),pred);
hold on
s = -2:0.01:2.5;
plot(s, -(s * wl(2) + wl(1)) / wl(3),'r');

%% Naive bayes classifier

naive_b = fitcnb(xc,tc);

t_pred = predict(naive_b,xc);
confusion(tc,t_pred)

figure();
[a,b] = meshgrid(-3:0.1:3,-3:0.1:4);
preds = predict(naive_b,[a(:) b(:)]);
axis tight;
gscatter(xc(:,1),xc(:,2),tc);
hold on;
gscatter(a(:),b(:),preds);
hold on;

% Point generation
n_gen = 100;
dim = 2;

gen_d = zeros(n_gen,dim);
gen_t = zeros(n_gen,1);

prior = cumsum(naive_b.Prior);
param = naive_b.DistributionParameters;

for ii=1:n_gen
    % pick a random class
    gen_t(ii) = find(prior > rand(),1);
    for jj=1:dim
        mu = param{gen_t(ii), jj}(1);
        sigma = param{gen_t(ii),jj}(2);
        gen_d(ii,jj) = normrnd(mu,sigma);
    end
end
gscatter(gen_d(:,1), gen_d(:,2),gen_t);








