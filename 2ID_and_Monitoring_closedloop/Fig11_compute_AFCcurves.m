clear all
close all
clc


addpath('..\Data')
addpath('..\Data\sysID')

fb = 0:1:1000;

load('sysIDdatatraj013.mat')
sys0 = sysID;

[mag,phase,wout] = bode(sys0, (2*pi)*fb);

maggg0 = squeeze(mag);
phasegg0 = squeeze(phase);

[RE,IM] = nyquist(sys0, (2*pi)*fb);

re0 = squeeze(RE);
im0 = squeeze(IM);

H0 = complex(re0,im0);


%% Compare FRFs and compute AFCs - scenarios with 5 magnets

load('sysID05magsA.mat')
sysA = sysID;

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);

load('sysID05magsB.mat')
sysB = sysID;

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);

load('sysID05magsC.mat')
sysC = sysID;

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);

load('sysID05magsD.mat')
sysD = sysID;

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

% %%
H1 = H0; 

H2 = HA;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCA = AFC;

H2 = HB;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCB = AFC;

H2 = HC;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCC = AFC;

H2 = HD;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCD = AFC;


% %%

figure, 
subplot(2,2,1)
yyaxis left, hold on
h1 = plot(wout/(2*pi), mag2db(maggg0), 'DisplayName','Initial Model'); 
h2 = plot(wout/(2*pi), mag2db(magggA),'--', 'DisplayName','Identified Model');
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 5A')
yyaxis right
plot(wout/(2*pi),AFCA)
ylabel('AFC'), ylim([-1 1])
legend([h1, h2])

subplot(2,2,2)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggB),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 5B')
yyaxis right
plot(wout/(2*pi),AFCB)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,3)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggC),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 5C')
yyaxis right
plot(wout/(2*pi),AFCC)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,4)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggD),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 5D')
yyaxis right
plot(wout/(2*pi),AFCD)
ylabel('AFC'), ylim([-1 1])


%% Compare FRFs and compute AFCs - scenarios with 4 magnets 

load('sysID04magsA.mat')
sysA = sysID;

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);

load('sysID04magsB.mat')
sysB = sysID;

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);

load('sysID04magsC.mat')
sysC = sysID;

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);

load('sysID04magsD.mat')
sysD = sysID;

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

% %%
H1 = H0; 

H2 = HA;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCA = AFC;

H2 = HB;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCB = AFC;

H2 = HC;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCC = AFC;

H2 = HD;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCD = AFC;


% %%

figure, 
subplot(2,2,1)
yyaxis left, hold on
h1 = plot(wout/(2*pi), mag2db(maggg0), 'DisplayName','Initial Model'); 
h2 = plot(wout/(2*pi), mag2db(magggA),'--', 'DisplayName','Identified Model');
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 4A')
yyaxis right
plot(wout/(2*pi),AFCA)
ylabel('AFC'), ylim([-1 1])
legend([h1, h2])

subplot(2,2,2)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggB),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 4B')
yyaxis right
plot(wout/(2*pi),AFCB)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,3)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggC),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 4C')
yyaxis right
plot(wout/(2*pi),AFCC)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,4)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggD),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 4D')
yyaxis right
plot(wout/(2*pi),AFCD)
ylabel('AFC'), ylim([-1 1])


%% Compare FRFs and compute AFCs - scenarios with 3 magnets

load('sysID03magsA.mat')
sysA = sysID;

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);

load('sysID03magsB.mat')
sysB = sysID;

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);

load('sysID03magsC.mat')
sysC = sysID;

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);

load('sysID03magsD.mat')
sysD = sysID;

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

% %%
H1 = H0; 

H2 = HA;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCA = AFC;

H2 = HB;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCB = AFC;

H2 = HC;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCC = AFC;

H2 = HD;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCD = AFC;


% %%

figure, 
subplot(2,2,1)
yyaxis left, hold on
h1 = plot(wout/(2*pi), mag2db(maggg0), 'DisplayName','Initial Model'); 
h2 = plot(wout/(2*pi), mag2db(magggA),'--', 'DisplayName','Identified Model');
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3A')
yyaxis right
plot(wout/(2*pi),AFCA)
ylabel('AFC'), ylim([-1 1])
legend([h1, h2])

subplot(2,2,2)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggB),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3B')
yyaxis right
plot(wout/(2*pi),AFCB)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,3)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggC),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3C')
yyaxis right
plot(wout/(2*pi),AFCC)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,4)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggD),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3D')
yyaxis right
plot(wout/(2*pi),AFCD)
ylabel('AFC'), ylim([-1 1])

%% Compare FRFs and compute AFCs - scenarios with 2 magnets

load('sysID02magsA.mat')
sysA = sysID;

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);

load('sysID02magsB.mat')
sysB = sysID;

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);

load('sysID02magsC.mat')
sysC = sysID;

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);

load('sysID02magsD.mat')
sysD = sysID;

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

% %%
H1 = H0; 

H2 = HA;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCA = AFC;

H2 = HB;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCB = AFC;

H2 = HC;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCC = AFC;

H2 = HD;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCD = AFC;


% %%

figure, 
subplot(2,2,1)
yyaxis left, hold on
h1 = plot(wout/(2*pi), mag2db(maggg0), 'DisplayName','Initial Model'); 
h2 = plot(wout/(2*pi), mag2db(magggA),'--', 'DisplayName','Identified Model');
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 2A')
yyaxis right
plot(wout/(2*pi),AFCA)
ylabel('AFC'), ylim([-1 1])
legend([h1, h2])

subplot(2,2,2)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggB),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 2B')
yyaxis right
plot(wout/(2*pi),AFCB)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,3)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggC),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 2C')
yyaxis right
plot(wout/(2*pi),AFCC)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,4)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggD),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3D')
yyaxis right
plot(wout/(2*pi),AFCD)
ylabel('AFC'), ylim([-1 1])


%% Compare FRFs and compute AFCs - scenarios with 1 magnet

load('sysID01magsA.mat')
sysA = sysID;

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);

load('sysID01magsB.mat')
sysB = sysID;

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);

load('sysID01magsC.mat')
sysC = sysID;

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);

load('sysID01magsD.mat')
sysD = sysID;

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

% %%
H1 = H0; 

H2 = HA;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCA = AFC;

H2 = HB;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCB = AFC;

H2 = HC;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCC = AFC;

H2 = HD;
AFC = [];
for i = 1:length(H1)
    AFC(i) = 2*(abs(H1(i)'*H2(i)))/((H1(i)'*H1(i))+(H2(i)'*H2(i)));

end

AFCD = AFC;


% %%

figure, 
subplot(2,2,1)
yyaxis left, hold on
h1 = plot(wout/(2*pi), mag2db(maggg0), 'DisplayName','Initial Model'); 
h2 = plot(wout/(2*pi), mag2db(magggA),'--', 'DisplayName','Identified Model');
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 1A')
yyaxis right
plot(wout/(2*pi),AFCA)
ylabel('AFC'), ylim([-1 1])
legend([h1, h2])

subplot(2,2,2)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggB),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 1B')
yyaxis right
plot(wout/(2*pi),AFCB)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,3)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggC),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 1C')
yyaxis right
plot(wout/(2*pi),AFCC)
ylabel('AFC'), ylim([-1 1])

subplot(2,2,4)
yyaxis left, hold on
plot(wout/(2*pi), mag2db(maggg0)) 
plot(wout/(2*pi), mag2db(magggD),'--')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-80 0]) 
title('FRF Y/U 3D')
yyaxis right
plot(wout/(2*pi),AFCD)
ylabel('AFC'), ylim([-1 1])

