%Prepare the workspace
clc
clear all
close all
load iris_dataset;
%% Parameters
N = size(irisInputs(3,:)',1)
M = 3; % y = w0 + w1*x
l = 1e-5;

%% Data Normalization
x = irisInputs(3,:)';
t = irisInputs(4,:)';
%gplotmatrix(irisInputs')

x = zscore(x);
t = zscore(t);
figure()

plot(x,t,'+')

hold on

%% Regression calculation

%P is the design matrix of the regression
%We use polinomial basis function
P = [];
for i=1:N
    R = [1];
    for j=1:M-1
       R = [R x(i).^j];
    end
    P = [P; R];
end

%Calculate the final regression parameters
PI = inv(P'*P);
PIN = inv((l*eye(M))+(transpose(P)*P));
w = PI * transpose(P) * t;
w_rss = PIN * transpose(P)*t;

%% Indices calculation

y = P*w;
RSS = sum((t-y).^2)
DFE = N - M
t_bar = (1/N)*sum(t);
RSQ = 1 - RSS/sum((t_bar - t).^2)
RSQA = (RSQ*N)/DFE
RMSE = sqrt(RSS/N)

% P-Value
% T-Statistics
v = diag(PI);
sigma = sum((t_bar - t).^2)./(N - M -1);
T = w./(sqrt(v)*sqrt(sigma));
pvalues = 2*(1-tcdf(DFE-1,abs(T)))


%% Plotting the result
xx = linspace(min(x),max(x),300);
S = [];
for ii=1:300
    y = [0; 0];
    for jj=0:M-1
        y(1) = y(1) + w(jj+1)*xx(ii)^jj;
        y(2) = y(2) + w_rss(jj+1)*xx(ii)^jj;
    end
    S = [S y];
end
plot(xx,S(1,:),'r')
hold on
plot(xx,S(2,:),'b')



