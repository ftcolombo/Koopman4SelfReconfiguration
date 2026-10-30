clear all
close all
clc

fs = 2000;

fcut = 2;

%% Disturbance profiles

% To select between different profiles, uncomment the respective subsection

rng(1262)

t = 0:1/fs:10;

% % Profile A

u = (wgn(length(t),1,0)/3)';

figure, plot(t,u)
grid on, xlabel('Time (s)'), ylabel('Amplitude')

L = numel(t);
fn = fs/2;
NFFT = 2^nextpow2(L);
FTvs = fft(u,NFFT)/L;
fv = linspace(0,1,NFFT/2+1)*fn;
lv = 1:numel(fv);

figure, plot(fv, mag2db(abs(FTvs(lv))*2))
grid on, xlabel('Frequency (Hz)'), ylabel('Amplitude (dB)')

data.time = [];
data.signals.values = u';
data.signals.dimensions = size(u,1);



% % % Profile C
% 
% wn = 650*(2*pi);
% eta = 0.05;
% 
% H = tf(wn^2,[1 2*eta*wn wn^2]);
% Hd = c2d(H,1/fs);
% 
% figure, bode(Hd)
% 
% u2 = (lsim(Hd,u,t))';
% u2 = u2/std(u2)/3;
% 
% figure, plot(t,u2)
% grid on, xlabel('Time (s)'), ylabel('Amplitude')
% 
% L = numel(t);
% fn = fs/2;
% NFFT = 2^nextpow2(L);
% FTvs = fft(u2,NFFT)/L;
% fv = linspace(0,1,NFFT/2+1)*fn;
% lv = 1:numel(fv);
% 
% figure, plot(fv, mag2db(abs(FTvs(lv))*2))
% grid on, xlabel('Frequency (Hz)'), ylabel('Amplitude (dB)')
% 
% data.time = [];
% data.signals.values = u2';
% data.signals.dimensions = size(u2,1);



% % % Profile D
% 
% wn = 500*(2*pi);
% eta = 0.8;
% 
% H = tf(wn^2,[1 2*eta*wn wn^2]);
% Hd = c2d(H,1/fs);
% 
% figure, bode(Hd)
% 
% u2 = (lsim(Hd,u,t))';
% u2 = u2/std(u2)/3;
% 
% figure, plot(t,u2)
% grid on, xlabel('Time (s)'), ylabel('Amplitude')
% 
% L = numel(t);
% fn = fs/2;
% NFFT = 2^nextpow2(L);
% FTvs = fft(u2,NFFT)/L;
% fv = linspace(0,1,NFFT/2+1)*fn;
% lv = 1:numel(fv);
% 
% figure, plot(fv, mag2db(abs(FTvs(lv))*2))
% grid on, xlabel('Frequency (Hz)'), ylabel('Amplitude (dB)')
% 
% data.time = [];
% data.signals.values = u2';
% data.signals.dimensions = size(u2,1);

%% Control setup

% Load identified model
load('sysIDdatatraj013.mat')

x0 = zeros(nzeta,1);

% Design high-pass filter
forder = 4;
fmaxf = 900;
[Af,Bf,Cf,Df] = butter(forder,fmaxf/(fs/2),"high");

sos = ss2sos(Af,Bf,Cf,Df);
figure,freqz(sos,[],fs)

% Design LQR control
nx = size(sysID.A,1);
nu = size(sysID.B,2);
ny = size(sysID.C,1);

nxf = size(Af,1);
nuf = size(Bf,2);
nyf = size(Cf,1);

Akdmd = [sysID.A zeros(nx,nxf); zeros(nxf,nx) Af];
Bkdmd = [sysID.B; Bf];
Ckdmd = [sysID.C zeros(ny,nxf); zeros(nyf,nx) Cf];
Dkdmd = [sysID.D Df];

rho_y = 2e3;
rho_uhf = 10;
Qkdmd = Ckdmd'*diag([rho_y, rho_uhf])*Ckdmd;

KdDMD = dlqr(Akdmd, Bkdmd, Qkdmd, 1);

%% Design excitation signal for identification

Ur = zeros(size(t));

fmin = 60;
fmax = 1000;

fres = fs/length(t);
exclines = 1:ceil(fmax/fres);
exclines(exclines < floor(fmin/fres)) = [];

rng(66271)

Ur(exclines+1) = exp(complex(0,2*pi*rand(size(exclines))));
ur = 2*real(ifft(Ur));
ur = ur/std(ur)/3;

figure, plot(t,ur)
grid on, xlabel('Time (s)'), ylabel('Amplitude')

L = numel(t);
fn = fs/2;
NFFT = 2^nextpow2(L);
FTvs = fft(ur,NFFT)/L;
fv = linspace(0,1,NFFT/2+1)*fn;
lv = 1:numel(fv);

figure, plot(fv, abs(FTvs(lv))*2)
grid on, xlabel('Frequency (Hz)'), ylabel('Amplitude')

[r,lags] = xcorr(u,ur,'normalized');
figure, stem(lags,r)


dataR.time = [];
dataR.signals.values = ur';
dataR.signals.dimensions = size(ur,1);

%%

% compile Simulink model comm_beam.slx
