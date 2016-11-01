clc
clear all
close all

sigma = @(x) 1./(1 + exp(-x));
%% Load
load iris_dataset.mat
x = zscore(irisInputs([1 2],:)');
t = irisTargets(1,:)';
alpha = 0.1;
N = size(x,1);
perm = randperm(N);

%% Automatic Logistic Regression
%t = t+1;
%[B, dev, stats] = mnrfit(x,t);

%pihat = mnrval(B,x);
%[~, t_pred] = max(pihat,[],2);
%confusionmat(t,t_pred)

%figure();
%gscatter(x(:,1),x(:,2),t);
%hold on;
%axis manual;
%s = -2:0.01:2.5;
%plot(s, -(s * B(2) + B(1) ) / B(3),'r');

%% Manual - Batch Gradient Descent
w = ones(1,3);
pw = w;
err = inf;
w_old = [inf inf inf];
while sum((w_old - w).^2) > 0.00000001
    %Calculate the gradient
    g = 0;
    for ii=1:N
        y = sigma(w*[1 x(perm(ii),:)]');
        g = g + (y - t(perm(ii)))*[1 x(perm(ii),:)];
    end
    w_old = w;
    w = w - (alpha/N)*g;
    
    %err = 0;
    %for ii=1:N
        %y = sigma(w*[1 x(perm(ii),:)]');
        %err = err + t(perm(ii))*log(y) + (1-t(perm(ii)))*log(1-y);
    %end
    %err = -err;
end
 
figure();
gscatter(x(:,1),x(:,2),t);
hold on;
axis manual;
s = -2:0.01:2.5;
h(2) = plot(s, -(s * w(2) + w(1) ) / w(3),'r');

