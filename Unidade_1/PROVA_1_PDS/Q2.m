NSamples = 15;
Samples = 0:(NSamples-1);

x = (1/3).^Samples;
%criando o vetor de frequencias de w
w = -pi:0.01:pi;
ejw = exp(-1i*w);
X = 0;
k = 0;
for n = 0:(NSamples-1)
    k = k + 1;
    X = X + x(k)*ejw.^n;
end
% calculando a transformada z
Xz_fcn = @(z,a) (z)./(z-a);
z1 = exp(1i*w);
Xz_ejw = Xz_fcn(z1,1/3);

%plotagems

fig = figure('Position',[10 10 1200 600],'color','w');

% Plot x[n]
ax = subplot(3,1,1);
lin1 = stem(Samples,x,'filled');
ax.Visible = 'off';
title('$x[n] = (1/3)^nu[n]$','Interpreter','latex','Visible','on');

str = {'-\pi','-\pi/2','0','-\pi/2','-\pi'};
% Plot results for DTFT
ax = subplot(3,1,2);
lin2 = plot(w,abs(X),'-r','LineW',1);
set(ax,'XTick',-pi:(pi/2):pi,'XTickLabel',str);
% ax.TickLabelInterpreter = 'latex';
tl = title('$|X(e^{jw})|$','Interpreter','Latex');
grid minor
% ylim([0 12])
xlim([-pi,pi])
xlabel('w (rad)','Interpreter','latex')

% Plot results form Z transform
ax = subplot(3,1,3);
lin2 = plot(w,abs(Xz_ejw),'-r','LineW',1);
% ax.TickLabelInterpreter = 'latex';
tl = title('$|X(z)|,z = e^{jw}$','Interpreter','Latex');
grid minor
% ylim([0 12])
xlim([-pi,pi])
xlabel('w (rad)','Interpreter','latex')

