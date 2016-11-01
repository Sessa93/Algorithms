clear all;
close all;
clc;

%% Load the dataset
load iris_dataset.mat;
x = zscore(irisInputs([1 2],:)');
t = irisTargets(1,:)';
gplotmatrix(x,[],t);
N = size(x,1)

%% Perceptron Algorithm
diff = inf;
w = rand(1,3);
perm = randperm(N); %shuffle the data
t(t == 0) = -1

alpha = 0.1
while diff > 0.0001
    wold = w;
    for ii=1:N
        if sign(w*[1 x(perm(ii),:)]') ~= t(perm(ii))
              w = w + alpha*[1 x(perm(ii),:)]*t(perm(ii));
        end
    end
    diff = abs(mean(w-wold));
end

figure();
gscatter(x(:,1),x(:,2),t);
hold on;
axis manual;
s = -2:0.01:2.5;
h(2) = plot(s, -(s * w(2) + w(1) ) / w(3),'r');
