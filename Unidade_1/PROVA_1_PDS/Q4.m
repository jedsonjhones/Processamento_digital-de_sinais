% Read respiration signal
MatFile = matfile('respiration.mat');

x = MatFile.respiration;
fs = 1000; % sample rate in Hz
ts = 1/fs; % sample period in sec

NSamples = length(x);

% Create time vector
t = (0:NSamples-1)/fs;

fig = figure('Position',[10 10 900 300],'color','w');
lin1 = plot(t,x);
xlabel('t (s)')
ylabel('Amp')
xlim([0 10]) % shows from 0 - 10 sec
% ylim([-0.1 1.1])

%% LETRA A
TSim = 10; % tempo de simulação
N = TSim*fs;
x1 = x(1:N);
t1 = t(1:N);
[PeakVal,LocPeak] =findpeaks(x1,'MinPeakDistance',0.5*fs);

subplot(2,1,1)
lin1 = plot(t1,x1);
xlabel('t (s)')
ylabel('Amp')

LinPeak = line(t(LocPeak),PeakVal,'Marker','.','MarkerSize',12,...,
               'LineStyle','none','Color','r');

NPeaks = length(PeakVal);
FreqEstimated =  NPeaks/TSim; % In Hz
title(sprintf('Estimated respiration frequency: %.1f Hz',FreqEstimated));     

%% LETRA B
[Val, loc] = findpeaks(10*log10(Y1),'NPeaks',1,'SortStr','descend');

subplot(2,1,2)
LinFPeak = line(f(loc),Val,'Marker','.','MarkerSize',12,...,
               'LineStyle','none','Color','r');
title(sprintf('Fundamental frequency estimated from spectrum: %.1f Hz',f(loc)));