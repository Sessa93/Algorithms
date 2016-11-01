%% Multi Armed Bandit
clear all;
close all;
clc;

%% Bandit preparation
R = [0.2 0.3 0.7 0.5];
n_arms = size(R,2);

for ii=1:n_arms
   D(ii) = makedist('Binomial','p',R(ii));
end

T = 1000;

%% UCB1

N = ones(1,n_arms);
arms = zeros(1,T);
rew = zeros(1,T);
cumr = zeros(1,n_arms);

U = zeros(1,n_arms);
B = zeros(1,n_arms);
R_hat = zeros(1,n_arms);

for tt=1:T
   % Initialization RR
   if tt <= n_arms
      arms(tt) = tt;
   else
      [~,arms(tt)] = max(U);
      rew(tt) = D(arms(tt)).random();
      cumr(arms(tt)) = cumr(arms(tt)) + rew(tt);
      N(arms(tt)) = N(arms(tt)) + 1;
      R_hat = cumr./N;
      B = sqrt(2*log(tt)./N);
      U = R + B;
   end
end

%% Thompson Sampling

N = ones(1,n_arms);
arms = zeros(1,T);
rew = zeros(1,T);
cumr = zeros(1,n_arms);

priors = repmat(makedist('Beta','a',1,'b',1),1,n_arms);

for tt=1:T
   for aa=1:n_arms
        samples(aa) = priors(aa).random();
   end
   [~,arm] = max(samples);
   rew(tt) = D(arm).random();
   cumr(arm) = cumr(arm) + rew(tt);
   N(arm) = N(arm) + 1;
   
   priors(arm).a = priors(arm).a + rew(tt);
   priors(arm).b = priors(arm).b + (1-rew(tt));
end

% Plotting
x = 1:.1:5;
for aa=1:n_arms
    pdfs(aa) = pdf(priors(aa),x);
end
plot(x,pdfs(3),'LineWidth',2)