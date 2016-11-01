%% Prepare the workspace
clear all;
close all;
clc;

%% Markov process definition
n_states = 3;
gamma = 0.95;

%Transition Probability Matrix
P = [0.9 0.1 0; 0.3 0.7 0; 0.4 0.6 0; 0 0.3 0.7; 0.2 0 0.8];
%Reward Matrix
R = [0.9*0 + 0.1*20; 0.3*-2 + 0.7*-27; 0.6*20; (0.3*-5)+(0.7*-100); 0.8*50];

%% Policy Iteration
policy = [0 1 0 0 0; 0 0 0 1 0; 0 0 0 0 1];
admissible_actions = [1 1 0 0 0; 0 0 1 1 0; 0 0 0 0 1];

V = zeros(n_states,1);
V_old = ones(n_states,1);

while any(V ~= V_old)
    pp = policy*P;
    pr = policy*R;
    V_old = V;
    V = inv(eye(n_states) - gamma*pp)*pr;
    
    %Calculating the action-value function(Q)
    
    rev = R + gamma*P*V;
    Q = repmat(rev',n_states,1).*admissible_actions;
    Q(Q == 0) = - inf;
    policy = repmat(max(Q,[],2),1,5) == Q;
end
policy
V

%% Value Iteration

V = zeros(n_states,1);
V_old = ones(n_states,1);
err = 0.01;

while any(abs(V-V_old)) > err
    V_old = V;
    rev = R + gamma*P*V;
    Q = repmat(rev',n_states,1).*admissible_actions;
    Q(Q==0) = -inf;
    V = max(Q,[],2);
end
V


