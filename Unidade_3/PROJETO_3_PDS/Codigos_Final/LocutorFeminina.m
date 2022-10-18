% Abrindo o sinal de audio
[y, fs] = audioread('cachorroF.wav');
M = length(y);
t = (0:M-1)/fs;
subplot(211), plot(t, y),
xlabel('t (s)');
ylabel('Amp');
title('Cachorro.wav');
ind = find(t>0.65 & t<0.85);
subplot(212),
plot(t(ind), y(ind)),