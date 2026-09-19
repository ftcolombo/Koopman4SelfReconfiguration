clear all
close all
clc

% Training data

addpath('..\Data')

load('t1_buf_013.mat')

fs = 2000;

yq = y;
uq = u';
wq = [];

ts = 1/fs;
Nt = size(uq,1);

tq = 0:ts:(Nt-1)/fs;

Ntraj = size(uq,2);

ny = size(yq,1)/Ntraj;
nu = size(uq,2)/Ntraj;
nw = size(wq,2)/Ntraj;


%% Testing the ability of the DMD model to reconstruct the training data

load('sysIDdatatraj013.mat')

yDMD = (lsim(sysID, [uq wq]', tq, zeros(nzeta,1)))';

fit = goodnessOfFit(yDMD',yq', 'NRMSE');

fitcompare = (1-fit)*100;

figure, 
subplot(2,1,1), plot(tq,yq)
hold on, plot(tq, yDMD,'LineWidth',0.2,'LineStyle','-.')
grid on, xlabel('Time (s)'), ylabel('Output responses (V)'), title(['(a) Comparison (' num2str(fitcompare,4) '% fit)'])

subplot(2,1,2), plot(tq,yq)
hold on, plot(tq, yDMD,'LineWidth',1.2,'LineStyle','-.')
grid on, xlabel('Time (s)'), ylabel('Output responses (V)'), title('(b) Zoom')
legend('Experimental y(t)','Simulation y_{hat}(t)','Location','northeast')
xlim([5 5.1]), ylim([-0.04 0.04])


%% Draw Fig. 5.(b)

Nx = length(y);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfu,fu] = modalfrf(u',y',fs,hamming(nsc),nov,'Sensor','dis');

fb = fu;
[mag,phase,wout] = bode(sysID, (2*pi)*fb);

maggg = squeeze(mag);
phasegg = squeeze(phase);

ef = abs(abs(frfu)-maggg);

figure, 
subplot(2,1,1), hold on, 
plot(fu, mag2db(abs(frfu)),'LineWidth',1.5)
plot(wout/(2*pi), mag2db(maggg),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([0 1000]) 
legend('From Data','Estimated by DMD','Location','best')
title('FRF Y/U')

subplot(2,1,2), plot(fu, angle(frfu),'LineWidth',1.5)
hold on, plot(wout/(2*pi), wrapToPi(phasegg*pi/180),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Phase (rad)'), xlim([0 1000]) 

%% Draw Fig. 6

ery = yq - yDMD;

lagsmax = 500;
[xc_ref,lags] = xcorr(ery,yDMD,lagsmax,'normalized');

figure, hold on 
stem(lags,xc_ref)
plot(lagsmax*[-1 1],0.15*[1 1],'k','LineStyle','--')
plot(lagsmax*[-1 1],0.15*[-1 -1],'k','LineStyle','--')
grid on, xlabel('Lags'), ylabel('Cross-Correlation between e(t) and y_{hat}(t) ')
xlim([-10 50]), ylim([-0.2 0.2])
