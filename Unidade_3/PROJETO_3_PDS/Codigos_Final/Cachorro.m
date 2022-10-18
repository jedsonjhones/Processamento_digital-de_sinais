% Abrindo o sinal de audio
[y, fs] = audioread('cachorroM.wav');
M = length(y);
t = (0:M-1)/fs;
subplot(211), plot(t, y),
xlabel('t (s)');
ylabel('Amp');
title('cachorro.wav');
ind = find(t>2.2 & t<2.4);
subplot(212),
plot(t(ind), y(ind)),
