% Abrindo o sinal respiration
MatFile = matfile('respiration.mat');
x = MatFile.respiration;
fs = 1000; % sample rate in Hz
ts = 1/fs; % sample period in sec
NSamples = length(x);

t = (0:NSamples-1)/fs;
fig = figure('Position',[10 10 900 300],'color','w');
lin1 = plot(t,x);
xlabel('t (s)')
ylabel('Amp')
xlim([0 10]) 

%LETRA A
xSmooth = x;
M = 20;
for iSample = M:NSamples
    IndWindow = (iSample-M+1):iSample;
    xSmooth(iSample) = mean(x(IndWindow));
end

%LETRA B

h = ones(1,M)/M;
xSmooth1 = conv(x,h,'same');

%LETRA C

fig = figure('Position',[10 10 900 600],'color','w');
subplot(2,1,1)
lin1 = plot(t,xSmooth);
xlabel('t (s)')
ylabel('Amp')
title('Sinal suavizada Met_1')
xlim([0 10])
subplot(2,1,2)
lin1 = plot(t,xSmooth1);
xlabel('t (s)')
ylabel('Amp')
title('Sinal suavizada Met_2')
xlim([0 10])
