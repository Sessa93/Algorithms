% Implementation of the adaptive boosting algorithm for linear regression

%% Prepare the workspace
clear all;
close all;
clc;

%% Create the dataset
n_tot = 40;
eps = 2;
func = @(x) ((0.5 - x) .* (5 - x) .* (x - 3));
x = 5 * randn(n_tot,1);

%% AdaBoost
n_rep = 10;
w = repmat(1/n_tot,n_tot,1);
p = w;

for ii=1:n_rep
   % Normalize the weigths
   for jj=1:n_tot
       p(jj) = w(jj)/sum(w);
   end
   
   % Weighted sampling + learning
   x_new = randsample(x,n_tot,'true',p);
   t_new = func(x_new) + eps*randn(n_tot,1);
   fit_opt = fittype({'1','x_new'},'independent','x_new','dependent','t_new','coefficients',{'w0','w1'});
   lin_mod(ii) = fit(x_new,t_new,fit_opt);
   plot(lin_mod(ii),x_new,t_new);
   
   % Calculate epsilon
   
end