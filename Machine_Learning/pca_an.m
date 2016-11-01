clear all
close all
clc;

%% Standard PCA
load iris_dataset;
irisInputs = irisInputs';

[loadings scores variance] = pca(irisInputs);

loadings

pc1 = scores(:,1)
pc2 = scores(:,2)
pc3 = scores(:,3)
pc4 = scores(:,4)

cumsum(variance) / sum(variance)

%% Features excraction

irisTargets = [ones(50,1); -ones(100,1)];
model_all = fitcsvm(irisInputs, irisTargets);
model_1 = fitcsvm([pc1 pc2], irisTargets);
model_2 = fitcsvm([pc3 pc4], irisTargets);

sum(predict(model_all, irisInputs) == irisTargets)
sum(predict(model_1, [pc1 pc2]) == irisTargets)
sum(predict(model_2, [pc3 pc4]) == irisTargets)

%% Visualization

figure();
gscatter(pc1,pc2,irisTargets,'bg','..')
figure();
gscatter(pc3,pc4,irisTargets,'bg','..')

%% Compression

m = 3;

x_zip = scores(:,1:m);

needed_loadings = loadings(:,1:m);

mean_values = mean(irisInputs);

x_rec = x_zip * needed_loadings' + repmat(mean_values,150,1);

mean((irisInputs - x_rec).^2)

figure();
xlim([4.3 7.9]);
ylim([2 4.4]);
for ii = 1:150
    hold on;
    plot([irisInputs(ii,1) x_rec(ii,1)],[irisInputs(ii,2) x_rec(ii,2)],'k');
end





