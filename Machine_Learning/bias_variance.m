clear all;
close all;
clc;

%% Create the dataset
n_points = 10000;
eps = 0.7;
func = @(x)(1 +1 /2 * x +1/10 *x.^2); %The true model! 

x = 5 * rand(n_points,1);
t = func(x);
t_noisy = func(x) + eps * randn(n_points,1);

%% Fit the models
phi = [x x.^2];

% L1 is a liner model
% L2 is a quadratic model 

lin_model = fitlm(x,t_noisy); 
qua_model = fitlm(phi,t_noisy);

real_par = [1 1/2 1/10]; %In case of quad model
best_par = [7/12 1 0]; %In case of lin model

lin_c = [lin_model.Coefficients.Estimate' 0];
qua_c = qua_model.Coefficients.Estimate;

%% Plotting
figure();

plot3(real_par(1), real_par(2), real_par(3), 'bx');

hold on;
grid on;
plot3(best_par(1), best_par(2), best_par(3), 'ro');
plot3(lin_c(1), lin_c(2), lin_c(3), 'r+');
plot3(qua_c(1), qua_c(2), qua_c(3),'b+');

title('Parameter Space');
xlabel('w0');
ylabel('w1');
zlabel('w2');

%% Trying different models
n_rep = 100;

for ii= 1:n_rep
   % Sample generation
   x = 5 * rand(n_points,1);
   t = func(x);
   t_noisy = func(x) + eps * randn(n_points,1);
   phi = [x x.^2];
   
   lin_model = fitlm(x,t_noisy);
   qua_model = fitlm(phi,t_noisy);
   
   lin_coeff(ii,:) = [lin_model.Coefficients.Estimate' 0];
   qua_coeff(ii,:) = qua_model.Coefficients.Estimate;
end

figure();
plot3(real_par(1), real_par(2), real_par(3),'bo');
hold on;
grid on;

plot3(best_par(1), best_par(2), best_par(3), 'ro');
plot3(lin_coeff(:,1), lin_coeff(:,2), lin_coeff(:,3), 'r.');
plot3(qua_coeff(:,1), qua_coeff(:,2), qua_coeff(:,3),'b.');

title('Parameter Space');
xlabel('w0');
ylabel('w1');
zlabel('w2');

%% Estimating Bias-Variance

x_new = 5 * rand();
t_new = func(x_new) + eps * randn(1,1);

x_enh_new = [1 x_new 0];
phi_new = [1 x_new x_new.^2];

% Prediction for the new point
for ii=1:n_rep
   y_pred_lin(ii) = lin_coeff(ii,:) * x_enh_new';
   y_pred_qua(ii) = qua_coeff(ii,:) * phi_new';
end

error_lin = mean((t_new - y_pred_lin).^2);
bias_lin = mean(func(x_new) - y_pred_lin)^2;
variance_lin = var(y_pred_lin);
var_t_lin = error_lin - variance_lin - bias_lin;

error_qua = mean((t_new - y_pred_qua).^2);
bias_qua = mean(func(x_new) - y_pred_qua)^2;
variance_qua = var(y_pred_qua);
var_t_qua = error_qua - variance_qua - bias_qua;

disp('---Single Point----');
disp('Linear Model');
disp(['Linear error: ' num2str(error_lin)]);
disp(['Linear bias: ' num2str(bias_lin)]);
disp(['Linear variance: ' num2str(variance_lin)]);
disp(['Linear sigma: ' num2str(var_t_lin)]);
disp('Quadratic Model');
disp(['Quadratic error: ' num2str(error_qua)]);
disp(['Quadratic bias: ' num2str(bias_qua)]);
disp(['Quadratic variance: ' num2str(variance_qua)]);
disp(['Quadratic sigma: ' num2str(var_t_qua)]);

%% More Accurate estimation...
n_samples = 101;

x_new = linspace(0,5,n_samples)';
t_new = func(x_new) + eps*randn(n_samples,1);
x_enh_new = [ones(n_samples,1) x_new zeros(n_samples,1)];
phi_new = [ones(n_samples,1) x_new x_new.^2];


% Prediction for the new point
for ii=1:n_rep
   y_pred_lin_all(ii,:) = lin_coeff(ii,:) * x_enh_new';
   y_pred_qua_all(ii,:) = qua_coeff(ii,:) * phi_new';
end

error_lin = sum(mean(repmat(t_new',n_rep,1) - y_pred_lin_all).^2)/n_samples;
bias_lin = sum(mean(repmat(func(x_new'), n_rep,1) - y_pred_lin_all).^2) / n_samples;
variance_lin = sum(var(y_pred_lin_all))/n_samples;
var_t_lin = sum(error_lin - variance_lin - bias_lin)/n_samples;

error_qua = sum(mean(repmat(t_new',n_rep,1) - y_pred_qua_all).^2)/n_samples;
bias_qua = sum(mean(repmat(func(x_new'), n_rep,1) - y_pred_qua_all).^2) / n_samples;
variance_qua = sum(var(y_pred_qua_all))/n_samples;
var_t_qua = sum(error_lin - variance_lin - bias_lin)/n_samples;

disp('---Multiple Point----');
disp('Linear Model');
disp(['Linear error: ' num2str(error_lin)]);
disp(['Linear bias: ' num2str(bias_lin)]);
disp(['Linear variance: ' num2str(variance_lin)]);
disp(['Linear sigma: ' num2str(var_t_lin)]);
disp('Quadratic Model');
disp(['Quadratic error: ' num2str(error_qua)]);
disp(['Quadratic bias: ' num2str(bias_qua)]);
disp(['Quadratic variance: ' num2str(variance_qua)]);
disp(['Quadratic sigma: ' num2str(var_t_qua)]);








