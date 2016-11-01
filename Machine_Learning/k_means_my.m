%% Prepare the workspace
clear all;
close all;
clc;

%% Load the dataset

load iris_dataset;
x = irisInputs([1 3],:)';
%plot(x(:,1),x(:,2),'o')
%hold on

%Number of clusters
K = 2;
N = size(x,1);

%% Std K-Means

%Initialization
centers = [];
for kk=1:K
    r = randi(N,1); 
    centers = [centers; x(r,:)];
end

cluster = zeros(N,1);
old_cluster = ones(N,1);

%1 -> Cluster 1
%2 -> Cluster 2
%n -> Cluster n

while any(cluster ~= old_cluster)
    old_cluster = cluster;
    
    %Expectation: Assign each point to a cluster
    for nn=1:N
        for kk=1:K
            dist(kk) = sum((x(nn,:) - centers(kk,:)).^2);
        end
        [~,cluster(nn)] = min(dist);
    end
    
    %Maximization: Recompute the centroids
    for kk=1:K
        centers(kk,:) = mean(x(cluster == kk,:));
    end
end

%Plotting
figure()
gscatter(x(:,2),x(:,1),cluster)
hold on
plot(centers(:,2),centers(:,1),'d')
title('Standard K-Means')

%% K-Means++

%Initialization
centers = [];
weights = [];

r = randi(N,1); 
centers = x(r,:);

for kk=1:K-1
    for nn=1:N
        for ii=1:size(centers,1)
            dist(ii) = sum((x(nn,:) - centers(ii,:)).^2);
        end
        weights(nn) = min(dist);
    end
    s = sum(weights);
    weights = weights./s;
    
    %Sample the new centroid
    r = randsample([1:N], 1, true, weights);
    centers = [centers; x(r,:)];
end

cluster = zeros(N,1);
old_cluster = ones(N,1);

while any(cluster ~= old_cluster)
    old_cluster = cluster;
    
    %Expectation: Assign each point to a cluster
    for nn=1:N
        for kk=1:K
            dist(kk) = sum((x(nn,:) - centers(kk,:)).^2);
        end
        [~,cluster(nn)] = min(dist);
    end
    
    %Maximization: Recompute the centroids
    for kk=1:K
        centers(kk,:) = mean(x(cluster == kk,:));
    end
end

%Plotting
figure()
gscatter(x(:,2),x(:,1),cluster)
hold on
plot(centers(:,2),centers(:,1),'d')
title('K-Means++')
