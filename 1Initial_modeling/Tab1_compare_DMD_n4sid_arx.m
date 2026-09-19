clear all
close all
clc

addpath('..\Data')

load('t1_buf_013.mat') % training data

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

load('sysIDdatatraj013.mat')

data_train = iddata(yq',[uq wq],1/fs);

load("test_buf_013.mat") % test data: portion of traj_013 not used for training
yq = y;
uq = u';
wq = [];

data_test = iddata(yq',[uq wq],1/fs);


%% Testing the performance of an n4sid model

sys_n4sid = n4sid(data_train,30,'Ts',1/fs);

% figure, compare(sys_n4sid,data_test)
% figure, resid(sys_n4sid,data_test,100)

%% Testing the performance of an arx model

sys_arx = arx(data_train,[40 40 1]);

% figure, compare(sys_arx,data_test)
% figure, resid(sys_arx,data_test,100)


%%
figure, resid(sysID,sys_n4sid, sys_arx,data_test,50)

figure, compare(sysID,sys_n4sid,sys_arx,data_test)

%%

aa = sysID.A; aa(abs(aa) < 1e-7)=0;
aan = sys_n4sid.A; aan(abs(aan) < 1e-7)=0;

figure, 
subplot(1,2,1), spy(aa)
subplot(1,2,2), spy(aan)


%%

load('t1_buf_013.mat')

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

[mag,phase,~] = bode(sys_n4sid, (2*pi)*fb);

maggg_n4sid = squeeze(mag);
phasegg_n4sid = squeeze(phase);

ef_n4sid = abs(abs(frfu)-maggg_n4sid);

[mag,phase,~] = bode(sys_arx, (2*pi)*fb);

maggg_arx = squeeze(mag);
phasegg_arx = squeeze(phase);

ef_arx = abs(abs(frfu)-maggg_arx);


%%
figure, 
subplot(2,1,1), hold on,
plot(fu, mag2db(abs(frfu)),'LineWidth',1.5)
plot(wout/(2*pi), mag2db(maggg),'LineWidth',1.5,'LineStyle','-.')
plot(wout/(2*pi), mag2db(maggg_n4sid),'LineWidth',1.5,'LineStyle','-.')
plot(wout/(2*pi), mag2db(maggg_arx),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([0 1000]) 
legend('From Data','DMD','n4sid','arx')
title('FRF Y/U')

subplot(2,1,2), hold on, 
plot(fu, angle(frfu),'LineWidth',1.5)
plot(wout/(2*pi), wrapToPi(phasegg*pi/180),'LineWidth',1.5,'LineStyle','-.')
plot(wout/(2*pi), wrapToPi(phasegg_n4sid*pi/180),'LineWidth',1.5,'LineStyle','-.')
plot(wout/(2*pi), wrapToPi(phasegg_arx*pi/180),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Phase (rad)'), xlim([0 1000]) 

figure, hold on
plot(wout/(2*pi), mag2db(ef))
plot(wout/(2*pi), mag2db(ef_n4sid))
plot(wout/(2*pi), mag2db(ef_arx))
grid on, xlabel('Frequency (Hz)'), ylabel('Error'), xlim([0 1000])
legend('DMD','n4sid','arx')

%%

fi = find(wout/(2*pi) >= 60, 1);

eff = sum(abs(ef(fi:end)));
eff_n4sid = sum(abs(ef_n4sid(fi:end)));
eff_arx = sum(abs(ef_arx(fi:end)));