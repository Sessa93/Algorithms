%Prepare the workspace
clc
clear all
close all
load 'iris_dataset'
%% Parameters
N = size(irisInputs(3,:)',1)
M = 11;

sigma = 1e-10;
tau = 1e-5;
sigmab = 0.1;

w0 = repmat([0],M+1,1);
S0 = eye(M+1)*tau;

%% Data Normalization
x = irisInputs(3,:)';
t = irisInputs(4,:)';

x = zscore(x);
t = zscore(t);
figure()

plot(x,t,'+')

hold on

%% Design matrix generation
P = [];
for i=1:N
    R = [1];
    for j=1:M
       R = [R x(i)^j];
    end
    P = [P; R];
end

%% Posterior distribution calculation

SNI = inv(S0) + ((transpose(P)*P)./sigma);
SN = inv(SNI);
wn = SN*((inv(S0)*w0) + ((transpose(P)*t)./sigma));

%% Plotting
xx = linspace(min(x),max(x),200);
S = [];
for ii=1:200
    y = [0; 0];
    for jj=0:M
        y(1) = y(1) + wn(jj+1)*xx(ii)^jj;
        y(2) = 0;
    end
    S = [S y];
end
plot(xx,S(1,:),'r')


