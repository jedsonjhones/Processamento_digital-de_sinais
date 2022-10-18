% Abrindo sinal respiration.mat
MatFile = matfile('respiration.mat');
x = MatFile.respiration;
fs = 1000; % sample rate in Hz
ts = 1/fs; % sample period in sec
NSamples = length(x);
% Criando um vetor de tempo
t = (0:NSamples-1)/fs;
%% Plotando o sinal de respiration.mat
fig = figure('Position',[10 10 900 300],'color','w');
ax = subplot(2,1,1);
lin1 = plot(t,x);
xlabel('t (s)')
ylabel('Amp')
title('Sinal Respiration.mat');
% Frequencia de corte
%{
 A frequência de corte fc escolhida foi de 10 hz. A escolha da frequência de
 corte foi feita depois de implementado os filtros. Inicialmente foi escolhida
 uma frequência de corte de 60 hz, mas como podemos ver nas imagens do PDF,
 ainda existiam ruídos no sinal obtido.
Então foi escolhida uma frequência de corte de 10 hz, onde assim o sinal ficou
 sem ruídos, que é como podemos perceber a partir da mesma partir do sinal,
 na figura abaixo.
%}

fc = 10; % Cut-off frequency in Hz
%% Obtendo os coeficiente do filtro FIR, fazendo sua implementação e plotando,
wc = fc/(fs/2); % Cut-off frequency normalized, fs/2 -> 1 
N = 51; % filter order
[b,a] = fir1(N,wc);
% Implementação do filtro FIR, e plotagem do sinal
x1b = filter(b,a,x);
ax1 = subplot(2,1,2);
plot(t,x1b);
xlabel('t (s)');
ylabel('Amp');
title('x_{1b}');
title('Com a implementação do filtro FIR');
ylim([-10 -4])

%% Calculando o espectro para o sinal respiration.mat e plotando
nfft = NSamples;
Y1 = fft(x);
Y1 = abs(Y1)/nfft;
Y1 = 2*Y1(1:nfft/2+1);
f = linspace(0,fs/2,length(Y1));
% Plotando o espectro do respiration.mat
fig = figure('Position',[10 10 900 300],'color','w');
ax2 = subplot(2,1,1);
plot(f,Y1)
title(['Espectro original, respiration'])
xlim([0 65])
ylim([0 0.8])

%% Calculando o espectro, filtro FIR e plotando
nfft = NSamples;
Y2 = fft(x1b);
Y2 = abs(Y2)/nfft;
Y2 = 2*Y2(1:nfft/2+1);
f = linspace(0,fs/2,length(Y2));
% Plotando o espectro do sinal com a filtragem FIR
ax3 = subplot(2,1,2);
plot(f,Y2)
title(['Espectro filtro FIR'])
xlim([0 65])
ylim([0 0.8])