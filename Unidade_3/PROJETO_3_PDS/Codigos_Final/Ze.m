% Abrindo o sinal de audio
[y, fs] = audioread('Zê.wav');
M = length(y);
t = (0:M-1)/fs;
subplot(211), plot(t, y),
xlabel('t (s)');
ylabel('Amp');
title('Z.wav');
ind = find(t>1.74 & t<1.85);
subplot(212),
plot(t(ind), y(ind)),
xlabel('t (s)');
ylabel('Amp');
title('Amostra do sinal Z.wav');


%% FFT e LPC
%Shift percentage is 40% to cancel the background effect
%and Convert the signal to row vector
s=y(.4*length(y):end)'; % to remove background noise
Number_of_frames=512; %Number of frames
window_length=round(length(s)/Number_of_frames);%size of the frame
Frame_No=zeros(Number_of_frames);%The frame number
Frame_No(1)=1;
for i=1:Number_of_frames-1
Frame_No(i+1)=Frame_No(i)+window_length;%Construct an array for the
end
j=input('Enter the frame number: ');
N=Frame_No(j);
x=s(N:N+window_length-1);
  Rmatlab=xcorr(x);
display(Rmatlab);
 c=[Rmatlab(1:11)];
 h=[Rmatlab(1:11)];
 RLEFT=toeplitz(c,h);
display(RLEFT);
a_lpc=lpc(Rmatlab,11);
sigma1=(a_lpc(2:11).*Rmatlab(2:11)');
sigma=sum(sigma1);
[H,W]=freqz(1,sigma);
Fs = 8000; f = (0:511) / 1024 * Fs;
xfft=fft([x' zeros(1,1024-160)]);xfft = xfft(1:512);
xfft1= 1/320*(abs(xfft) ).^ 2;
figure,
plot(f,30*log10(abs(xfft1)));
equation=Rmatlab(1)+sigma;
G=sqrt(equation/160);
Glpc=abs(freqz(G,a_lpc,512)).^2;Glpclog=30*log10(Glpc);
hold on; plot(f,Glpclog,'r','LineWidth',3);
legend('FFT','LPC')