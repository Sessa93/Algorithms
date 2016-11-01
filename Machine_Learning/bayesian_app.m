%% Bayesian approach
% In the frequentist approach we use the arithmetic mean

% In the bayesian approach we need an prior distribution of the
% parameter(mu), than the mean value of the posterior ditribution is the
% extimation of the mean
% Be * B = B(a+xi, b + 1 - xi) Update the priorclear
clc
close all


pd_norm = makedist('binomial','N',1,'p',0.3); %real distribution
n_iter = 500;

%% Estimation process
%rand_bern = zeros(n_iter,1);

% Frequentist approach
freq_mean = 0;

% Bayesian prior
bayes_succ = 3;
bayes_fail = 7;
pd_mean = makedist('beta','a',bayes_succ,'b',bayes_fail);

figure();
for ii = 1:n_iter
    % Sampling
    rand_bern(ii) = pd_norm.random();

    % Frequentist update
    freq_mean = mean(rand_bern);

    % Bayesian update
    bayes_succ = bayes_succ + rand_bern(ii);
    bayes_fail = bayes_fail + 1-rand_bern(ii);
    pd_mean.a = bayes_succ;
    pd_mean.b = bayes_fail;
    
    % Plot
    subplot(2,1,1);
    plot(freq_mean,1,'r*');
    xlim([0,1]);
    title(['Frequentist mean ' num2str(freq_mean) ', iteration ' num2str(ii)]);

    subplot(2,1,2);
    x = 0:0.01:1;
    y = pd_mean.pdf(x);
    plot(x,y)
    title(['Bayes distribution mean ' num2str(pd_mean.mean) ', iteration ' num2str(ii)]);
    drawnow;
    waitforbuttonpress;
end



