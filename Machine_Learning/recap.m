%% WS Initialization
clear all;
close all;
clc;

%% Dataset creation
load iris_dataset
x = zscore(irisInputs([1 2],:)');
t = irisTargets(1,:)';

%% Plotting
%gscatter(x(:,1),x(:,2),t)

%% Shuffling 
ind = randperm(size(t,1));

sx = x(ind,:);
st = t(ind);

%% Perceptron

tp = st;
tp(tp == 0) = -1;


delta = 0.0001; %% Stopping delta

w = zeros(3,1);
w_old = ones(3,1);

while abs(mean(w - w_old)) > delta 
    w_old = w;
    for ii=1:size(t,1) 
        if sign([1 sx(ii,:)]*w) ~= tp(ii)
           w = w + tp(ii)*[1 sx(ii,:)]';
        end
    end
end

%Plotting the perceptron line
figure();
gscatter(x(:,1),x(:,2),t);
hold on
axis manual;
s = -2:0.01:2.5;
plot(s, -(s * w(2) + w(1) ) / w(3),'r');
hold on

%% Logistic Regression

sigma = @(x) 1/(1+exp(-x)); 

delta = 0.001; %% Stopping delta

w = zeros(3,1);
w_old = ones(3,1);

alpha = 0.1;

while abs(mean(w - w_old)) > delta 
    w_old = w;
    for ii=1:size(t,1) 
        w = w - alpha * (sigma([1 sx(ii,:)]*w) - st(ii))*[1 sx(ii,:)]';
    end
end

%Plotting
s = -2:0.01:2.5;
plot(s, -(s * w(2) + w(1) ) / w(3),'b');

%% Naive Bayes

nb = fitcnb(sx, st);

%Plotting
figure()
gscatter(sx(:,1), sx(:,2),st)
hold on;
[a,b] = meshgrid(-3:0.1:3,-3:0.1:4);
t_p = predict(nb,[a(:), b(:)]);
axis tight;
gscatter(a(:),b(:),t_p);
hold on;

%% Support Vector Machine
svt = st;
svt(svt == 0) = -1;

svm = fitcsvm(sx,st,'KernelFunction','linear');

w = svm.Beta;
b = svm.Bias;

%Plotting
figure()
gscatter(sx(:,1), sx(:,2),st,'br')
hold on
x = min(sx(:,1)):0.1:max(sx(:,1));
y = -w(1) / w(2) * x - b / w(2);
plot(x,y);
hold on

%Margins
y = -w(1) / w(2) * x + (1 - b) / w(2);
plot(x,y,'--');
hold on
y = -w(1) / w(2) * x + (-1 - b) / w(2);
plot(x,y,'--');
xlabel('x_1');
ylabel('x_2');
axis tight

hold on

%Plotting the support vector
support_vec = svm.SupportVectors;
plot(support_vec(:,1),support_vec(:,2),'gx');





