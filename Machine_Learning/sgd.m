clc
clear all
close all

% Function to minimize
N = 50;
f = @(x) -5*x + 3;
x = linspace(-2,2,N);
y = f(x);

% Add some noise
y = y + (5*(rand(1,N)-0.5));

%Plotting
plot(x,y,'r*')
hold on

% Parameters Initialization
w = zeros(2,1);
max_it = 1000; % Maximum number of iterations
tol = 1e-6;

% Function to minimize(ie. error function)
E = @(w) (1/N)*sum((y' - [w(1)*x + ones(1,N)*w(2)]').^2);

% Partial derivatives of E
gradEw1 = @(w) (-2/N)*sum((y' - [w(1)*x + ones(1,N)*w(2)]').*(x'));
gradEw2 = @(w) (-2/N)*sum((y' - [w(1)*x + ones(1,N)*w(2)]'));

n_it = 0;
alpha = 0.2;
w_old = inf
while n_it <= max_it && norm(w - w_old) > tol
    w_old = w;
    % These three instruction shuffles the data
    p = randperm(N);
    y = y(p);
    x = x(p);
    
    for ii=1:N
        w = w - alpha*[gradEw1(w); gradEw2(w)]
    end
    n_it = n_it + 1;
end

plot(x,[w(1).*x + w(2)]','b-')
plot(x,f(x),'g-')



