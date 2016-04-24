%% Clean up stuff
clear all
close all

%% Data and noise
%N = 500;
N=2000;
sigma = 0.3;


%% network creation
NUM_NETS = 10; 
MIN_NUM_HIDDEN = 1;
MAX_NUM_HIDDEN = 8; 

%% data generation
for i=1:N
    %data(i) = sqrt((i/N)*(1-(i/N)))*sin((2.1*pi)/((i/N)+0.05));
    data(i) = sin((i/N)*2*pi);
end
plot(data);

pause(1);

%% generate and add normal noise ...
for i=1:N
    noise = sigma*normrnd(0,1);
    data_n(i) = data(i) + noise;
end

%plot(data_n-data,'.'); 
%pause;
plot(data_n,'+');
pause(1);


%% dataset creation 
p=[1:N];
   
% no preprocessing
pn = p;
tn = data_n;

% preprocessing
[pn,minp,maxp,tn,mint,maxt] = premnmx(pn,tn);

% early stopping
pn_train = [pn(1:4:N) pn(2:4:N)];
tn_train = [tn(1:4:N) tn(2:4:N)];
valid.P = pn(3:4:N);
valid.T = tn(3:4:N);
test.P = pn(4:4:N) ;
test.T = tn(4:4:N);

%% start training
for h=MIN_NUM_HIDDEN:MAX_NUM_HIDDEN
    h
    % traingd traingda trainrp traincgf traincgp traincgb trainsc
    % trainbfg trainoss trainlm
 
    % traingd traingda trainbfg trainlm (logsig,tansig) 
    net = newff(minmax(pn_train),[h 1],{'logsig' 'purelin'},'trainlm'); 
    net.trainParam.show = NaN;%50; %10; %NaN; 50; %NaN
    net.trainParam.goal = 0.001;
    net.trainParam.epochs = 3500;

    % change error function
    net.performFcn = 'mse';
    
    % training
    net = init(net);
    [net_old,tr_old,Y,E,Pf,Af]=train(net,pn_train,tn_train,[],[],valid,test);
    netlog{h}={net_old tr_old};
    
    %use vperf
    for i=1:NUM_NETS-1
        net = init(net);
        [net,tr,Y,E,Pf,Af] = train(net,pn_train,tn_train,[],[],valid,test);
        if (tr.vperf(end) < tr_old.vperf(end))
            net_old=net;
            tr_old = tr;
            netlog{h}={net_old tr_old};
        end;
    end;

    % testing
    close(gcf);
    output = sim(net,pn);
    
    % postprocessing
    output = postmnmx(output,mint,maxt);

    plot(data_n,'+');hold on; 
    plot(output,'r'); hold off;
    pause(3)
 %   uiwait(msgbox(sprintf('Result with %d neurons!',h),'modal'));
 %   close(gcf);
 %   [m,b,r] = postreg(output,data_n);
 %   uiwait(msgbox(sprintf('Regression with %d neurons!',h),'modal'));
 %   close(gcf);
end

pause

%%

for h=MIN_NUM_HIDDEN:MAX_NUM_HIDDEN
    performance(h) =  netlog{h}{2}.perf(end);
end
for h=MIN_NUM_HIDDEN:MAX_NUM_HIDDEN
    vperformance(h) =  netlog{h}{2}.vperf(end);
end 



plot(performance,'b'); hold on ; 
plot(vperformance,'r');

pause
%%


[minval, minindex]=min(vperformance)
%[minval, minindex]=min(performance);

output = sim(netlog{minindex}{1},pn);
%output = sim(net,pn);

% postprocessing
output = (output,mint,maxt);

plot(data_n,'+');hold on; 
plot(output,'r'); hold off;
