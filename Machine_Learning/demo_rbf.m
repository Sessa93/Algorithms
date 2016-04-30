%% Clean up stuff
clear all
close all

%% Data and noise
N=2000;
%N = 500;
sigma = 0.3;

%% network creation
SIGMA_MIN  = 10;
SIGMA_STEP = 10;
SIGMA_MAX  = 100;
MIN_NUM_HIDDEN = 3;
MAX_NUM_HIDDEN = 8;

%% data generation
for i=1:N
    %data(i) = sqrt((i/N)*(1-(i/N)))*sin((2.1*pi)/((i/N)+0.05));
    data(i) = sin((i/N)*2*pi);
end
plot(data);
pause(3);

%% generate and add normal noise ...
for i=1:N
    noise = sigma*normrnd(0,1);
    data_n(i) = data(i) + noise;
end
%plot(data_n-data,'.');
%pause;
plot(data_n,'+');
%pause;

%dataset creation
p=[1:N];

% no preprocessing
pn = p;
tn = data_n;

% preprocessing
%[pmp,minp,maxp,tn,mint,maxt] = premnmx(pn,tn);

% cross-validation
pn_train = [pn(1:3:N) pn(2:3:N)];
tn_train = [tn(1:3:N) tn(2:3:N)];
pn_valid = pn(3:3:N);
tn_valid = tn(3:3:N);

perfmatrix=[];
i = 1;
for h=MIN_NUM_HIDDEN:MAX_NUM_HIDDEN
    h
    net_old = newrb(pn_train,tn_train,0.0,SIGMA_MIN,h);
    y = sim(net_old,pn_train);
    e = tn_train-y;
    old_perf = mse(e);

    y = sim(net_old,pn_valid);
    e = tn_valid-y;
    old_valid = mse(e);

    netlog{h}={net_old old_perf old_valid SIGMA_MIN};

    j = 1;
%    perfmatrix(i,j) = old_perf;
    perfmatrix(i,j) = old_valid;
    j = j+1;

    for spread=SIGMA_MIN+SIGMA_STEP:SIGMA_STEP:SIGMA_MAX
        % traingd traingda trainbfg trainlm (logsig,tansig)
        net = newrb(pn_train,tn_train,0.0,spread,h);
        y = sim(net,pn_train);
        e = tn_train-y;
        perf = mse(e);

        y = sim(net,pn_valid);
        e = tn_valid-y;
        valid = mse(e);

%        perfmatrix(i,j)=perf;
        perfmatrix(i,j)=valid;
        j=j+1;

%        if (perf < old_perf)
        if (valid < old_valid)
            net_old=net;
            old_valid=valid;
            old_perf = perf;
            netlog{h}={net_old old_perf old_valid spread};
        end;

        % testing
        close(gcf);
        output = sim(net,pn);

        % postprocessing
        %output = postmnmx(output,mint,maxt);

        plot(data_n,'+');hold on;
        plot(output,'r'); hold off;
        title_str = sprintf('Num. Basis: %d  Spread: %f',h,spread)
        title(title_str);
        pause(3);
    end
	i=i+1;
end

for h=MIN_NUM_HIDDEN:MAX_NUM_HIDDEN
    performance(h) =  netlog{h}{3};
end

plot(performance);
%pause


%%
surf(perfmatrix); xlabel('sigma'); ylabel('hidden neurons')
pause

[minval, minindex]=min(performance)
output = sim(netlog{minindex}{1},pn);

% postprocessing
%output = postmnmx(output,mint,maxt);

plot(data_n,'+');hold on;
plot(output,'r'); hold off;
title_str = sprintf('Num. Basis: %d\tSpread: %f',minindex,netlog{minindex}{4})
title(title_str);
