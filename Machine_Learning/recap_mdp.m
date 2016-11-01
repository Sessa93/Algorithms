%% Recap MDB procedures - Value Iteration - Policy Iteration
clear all;
close all;
clc;

%% MDP Creation
R = [0; ...
     0.3*2 + 0.7*2; ...
     0; ...
     0.5*2 + 0.5*-3; ...
     0];
 
P = [1 0; ...
     0.3 0.7; ...
     0 1; ...
     0.5 0.5; ...
     1 0];
 
actions = [1 1 0 0 0; 0 0 1 1 1;];

gamma = 0.95;
  
%% Policy Iteration
V = zeros(2,1);
V_old = ones(2,1);

policy = [0 1 0 0 0; 0 0 0 0.5 0.5];

while any(V_old ~= V)
    V_old = V;
    
    pp = policy*P;
    pr = policy*R;
    
    V = inv(eye(2) - gamma*pp)*pr;
    rev = R + gamma*P*V;
    Q = repmat(rev',2,1).*actions;
    Q(Q == 0) = -inf;
    policy = repmat(max(Q,[],2),1,5) == Q;
end

V

%% Value Iteration
V = zeros(2,1);
V_old = ones(2,1);

while any(V ~= V_old)
   V_old = V;
   
   rev = R + gamma*P*V;
   Q = repmat(rev',2,1).*actions;
   Q(Q == 0) = -inf;
   V = max(Q,[],2);
end

V
 