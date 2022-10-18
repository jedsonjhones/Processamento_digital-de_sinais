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

nfft = 2^11;
x1 = x(1:nfft);
%% LETRA A
tic
YY1 = DFT_1loop(x1);
eTime(1) = toc;
YY1 = abs(YY1)/nfft;
YY1 = 2*YY1(1:nfft/2+1);
f = linspace(0,fs/2,nfft/2+1);
%% LETRA B
tic;
Y1 = fft_rec(x1);%fft_rec01(S_1024pts);
eTime(2) = toc;
Y1 = abs(Y1)/nfft;
Y1 = 2*Y1(1:nfft/2+1);
%% LETRA C
subplot(2,1,1)
plot(f,20*log10(YY1))
xlabel('f (Hz)')
ylabel('|X[k]|')
str = sprintf('tempo de cálculo: %.3f s',eTime(1))
title({'Espectro obtido mediante TFD 1 loop',str})
xlim([0 100])

subplot(2,1,2)
plot(f,20*log10(Y1))
xlabel('f (Hz)')
ylabel('|X[k]|')
str = sprintf('tempo de cálculo: %.3f s',eTime(2))
title({'Espectro obtido mediante FFT recursiva',str})
xlim([0 100])