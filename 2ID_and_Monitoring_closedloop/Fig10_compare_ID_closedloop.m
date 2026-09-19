clear all
% close all
clc

addpath('..\Data')
addpath('..\Data\sysID')

load('t1_buf_019.mat') % Closed-loop data using the initial controller based on the healthy model

fs = 2000;
yq = y;
uq = u';
wq = [];

y = yq;
u = [uq wq]';

Nx = length(y);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfuCL,fuCL] = modalfrf(u',y',fs,hamming(nsc),nov,'Sensor','dis');

load('t1_buf_013.mat') % Open-loop data

fs = 2000;
yq = y;
uq = u';
wq = [];

y = yq;
u = [uq wq]';

Nx = length(y);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfuOL,fuOL] = modalfrf(u',y',fs,hamming(nsc),nov,'Sensor','dis');


load('sysID05magsA.mat') % DMD model based on closed-loop identification
fb = fuCL;
[mag,phase,wout] = bode(sysID, (2*pi)*fb);

maggg = squeeze(mag);
phasegg = squeeze(phase);

%%
figure, 
subplot(2,1,1), plot(fuOL(1:2:end), mag2db(abs(frfuOL(1:2:end))),'LineWidth',1)
hold on, plot(fuCL(1:2:end), mag2db(abs(frfuCL(1:2:end))))
plot(wout(1:2:end)/(2*pi), mag2db(maggg(1:2:end)))
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]) 
legend('From OL Data','From CL Data','Estimated by DMD')
title('FRF Y/U 5A')

subplot(2,1,2), plot(fuOL(1:2:end), angle(frfuOL(1:2:end)),'LineWidth',1)
hold on, plot(fuCL(1:2:end), angle(frfuCL(1:2:end)))
plot(wout(1:2:end)/(2*pi), wrapToPi(phasegg(1:2:end)*pi/180))
grid on, xlabel('Frequency (Hz)'), ylabel('Phase (rad)'), xlim([60 1000]) 