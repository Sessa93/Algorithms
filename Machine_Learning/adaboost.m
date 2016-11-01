% Implementation of the adaptive boosting algorithm for linear regression

%% Prepare the workspace
clear all;
close all;
clc;

%% Create the dataset
n_tot = 40;
eps = 0;
func = @(x) 1 + x.^2;

x = 5 * randn(n_tot,1);
t = func(x) + eps*randn(n_tot,1);
plot(x,t,'x');
hold on;

% Definitions for weighted least squares
f = @(x,a,b) a + b*x;
wobj = @(p,x,y,w) sum(w .* (f(x,p(1),p(2)) - y) .^ 2);

%% AdaBoost
n_rep = 10;
w = repmat(1/n_tot,n_tot,1);
p = w;
mods = zeros(n_rep,2);
for ii=1:n_rep
   % Normalize the weigths
   for jj=1:n_tot
       p(jj) = w(jj)/sum(w);
   end
   
   %Simple weighted linear regression(linear feature)
   w_init = [0, 0];  % Initial guess for a and b
   min_p = fminsearch( @(min_p) wobj(min_p,x,t,p), w_init);
   a = min_p(1);
   b = min_p(2);
   mods(ii,1) = a;
   mods(ii,2) = b;
   
   %Plotting
   s = linspace(min(x),max(x),n_tot);
   plot(s,a + b*s);
   
   %Error calculation
   e = wobj([a,b],x,t,p);
   
   beta = e / (1-e);
   mods(ii,3) = beta;
   
   %Updating the weigth
   pred = a + b*x;
   for jj=1:n_tot
       w(jj) = w(jj)*beta^(1 - abs(t(jj) - pred(jj))); 
   end
end

%% Final prediction
for ii=1:n_tot
   pred_t(ii) = sum(log(1/mods(:,3))' .* abs(repmat(t(ii),n_rep,1) - (mods(:,1) + x(ii)*mods(:,2))));
end
plot(x,pred_t,'o');