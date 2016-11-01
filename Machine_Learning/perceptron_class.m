clear all
close all
clc

%% Load the dataset
load iris_dataset.mat;
x = zscore(irisInputs([1 2],:)');
t = irisTargets(1,:)';
gplotmatrix(x,[],t);

%% Perceptron algorithm
% Confusion Matrix: Real Class = Target Class, Output = predicted
% -----------
% | TP | FP |
% -----------
% | FN | TN |
% -----------

net = perceptron;
net = train(net,x',t');

gscatter(x(:,1),x(:,2),t);
hold on;
s = -2:0.01:2.5;
plot(s, -(s * net.IW{1}(1) + net.b{1} ) / net.IW{1}(2),'k');
axis manual
