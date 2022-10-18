clearvars
close all
clc

% Abrindo o sinal de audio
FileName = 'UnknownSound.wav';
[x,fs] = audioread(FileName);

NSamples = length(x);
t = (0:NSamples-1)/fs;

% Plot do sinal e o spectrograma do sinal original
fig = figure('Position',[100 100 900 600],'color','w');

% Plot do sinal
ax1 = subplot(3,1,1);
plot(t,x);
tl = title('a) Time signal','Interpreter','latex');
set(ax1,'TickLabelInterpreter','latex','FontSize',13);

% Plot spectrogramA
% pkg load signal; % % We need to uncommnet this in octave
nfft = 1024; % number fft points for spectrogram (STFT)
WLength = round(.05*fs); % Number of samples for each window segment used in STFT 
PercentOverlap = 0.8; % 80 percent overlap

ax2 = subplot(3,1,[2 3]);
[Pxx,tPxx,f] = My_STFT(x,fs,WLength,PercentOverlap);
Pxx_dB = 10*log10(Pxx);
surf(tPxx,f/1e3,Pxx_dB,'edgecolor','none');
axis tight, view(0,90)

tl = title('b) Signal spectrogram','Interpreter','latex');
xlabel('t(s)','Interpreter','latex');
ylabel('f(kHz)','Interpreter','latex');
set(ax2,'TickLabelInterpreter','latex','FontSize',13);

colorbar off
% print('-dpng','-r300', 'RawSignal.png');

%% Obtendo os coeficientes do filtro FII
%% ((4) a)

fc = 1000; % fc = 1 kHz
wc = fc/(25000/2);
M = 31;
b = fir1(M,wc);

[H,fH] = freqz(b,1,1024,fs);


% Plot do sinal de tempo e do spectrograma do sinal original
y = filter(b,1,x);
fig = figure('Position',[100 100 900 600],'color','w');

% Plot do sinal de tempo
ax1 = subplot(3,1,1);
plot(t,y);
tl = title('a) Time signal','Interpreter','latex');
set(ax1,'TickLabelInterpreter','latex','FontSize',13);

% Plot do spectograma

nfft = 1024; % number fft points for spectrogram (STFT)
WLength = round(.05*fs); % Number of samples for each window segment used in STFT 
PercentOverlap = 0.8; % 80 percent overlap

ax2 = subplot(3,1,[2 3]);
[Pxx,tPxx,f] = My_STFT(y,fs,WLength,PercentOverlap);
Pxx_dB = 10*log10(Pxx);
surf(tPxx,f/1e3,Pxx_dB,'edgecolor','none');
axis tight, view(0,90)

tl = title('b) Signal spectrogram','Interpreter','latex');
xlabel('t(s)','Interpreter','latex');
ylabel('f(kHz)','Interpreter','latex');
set(ax2,'TickLabelInterpreter','latex','FontSize',13); 


%% ((4) b e c) mudança na taxa de amostragem
r = 2;
fs1 = 25000/r;
t_dwn = t(1:r:end);
y_dwn = decimate(x,r,M,'fir'); % uses an FIR filter of order n.

% Plot time signal & spectrogram of original signal
fig = figure('Position',[100 100 900 600],'color','w');

% Plot time signal
ax1 = subplot(3,1,1);
plot(t_dwn,y_dwn);
tl = title('a) Time signal','Interpreter','latex');
set(ax1,'TickLabelInterpreter','latex','FontSize',13);

% Plot spectrogram
% pkg load signal; % % We need to uncommnet this in octave
nfft = 1024; % number fft points for spectrogram (STFT)
WLength = round(.05*fs); % Number of samples for each window segment used in STFT 
PercentOverlap = 0.8; % 80 percent overlap

ax2 = subplot(3,1,[2 3]);
[Pxx,tPxx,f] = My_STFT(y_dwn,fs1,WLength,PercentOverlap);
Pxx_dB = 10*log10(Pxx);
surf(tPxx,f/1e3,Pxx_dB,'edgecolor','none');
axis tight, view(0,90)

tl = title('b) Signal spectrogram','Interpreter','latex');
xlabel('t(s)','Interpreter','latex');
ylabel('f(kHz)','Interpreter','latex');
set(ax2,'TickLabelInterpreter','latex','FontSize',13); 