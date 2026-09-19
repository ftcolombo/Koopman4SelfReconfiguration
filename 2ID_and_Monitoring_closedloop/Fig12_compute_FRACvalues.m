clear all
close all
clc

addpath('..\Data')
addpath('..\Data\sysID')

fb = 0:0.25:1000;
DMD = [];

load('sysIDdatatraj013.mat')
sys0 = sysID;
DMD = [DMD dmd];

[mag,phase,wout] = bode(sys0, (2*pi)*fb);

maggg0 = squeeze(mag);
phasegg0 = squeeze(phase);

[RE,IM] = nyquist(sys0, (2*pi)*fb);

re0 = squeeze(RE);
im0 = squeeze(IM);

H0 = complex(re0,im0);



%% Compare FRFs and compute FRAC - scenarios with 5 magnets

load('sysID05magsA.mat')
sysA = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);


load('sysID05magsB.mat')
sysB = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);


load('sysID05magsC.mat')
sysC = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);


load('sysID05magsD.mat')
sysD = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

%%

fi = find(fb==60);
H1 = H0(fi:end); 
eFRAC5 = [];

H2 = HA(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC5 = [eFRAC5 FRAC];

H2 = HB(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC5 = [eFRAC5 FRAC];

H2 = HC(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC5 = [eFRAC5 FRAC];

H2 = HD(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC5 = [eFRAC5 FRAC];

%% Compare FRFs and compute FRAC - scenarios with 4 magnets

load('sysID04magsA.mat')
sysA = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);


load('sysID04magsB.mat')
sysB = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);


load('sysID04magsC.mat')
sysC = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);


load('sysID04magsD.mat')
sysD = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

%%

fi = find(fb==60);
H1 = H0(fi:end); 
eFRAC4 = [];

H2 = HA(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC4 = [eFRAC4 FRAC];

H2 = HB(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC4 = [eFRAC4 FRAC];

H2 = HC(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC4 = [eFRAC4 FRAC];

H2 = HD(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC4 = [eFRAC4 FRAC];

%% Compare FRFs and compute FRAC - scenarios with 3 magnets

load('sysID03magsA.mat')
sysA = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);


load('sysID03magsB.mat')
sysB = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);


load('sysID03magsC.mat')
sysC = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);


load('sysID03magsD.mat')
sysD = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

%%

fi = find(fb==60);
H1 = H0(fi:end); 
eFRAC3 = [];

H2 = HA(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC3 = [eFRAC3 FRAC];

H2 = HB(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC3 = [eFRAC3 FRAC];

H2 = HC(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC3 = [eFRAC3 FRAC];

H2 = HD(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC3 = [eFRAC3 FRAC];

%% Compare FRFs and compute FRAC - scenarios with 2 magnets

load('sysID02magsA.mat')
sysA = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);


load('sysID02magsB.mat')
sysB = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);


load('sysID02magsC.mat')
sysC = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);


load('sysID02magsD.mat')
sysD = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

%%

fi = find(fb==60);
H1 = H0(fi:end); 
eFRAC2 = [];

H2 = HA(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC2 = [eFRAC2 FRAC];

H2 = HB(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC2 = [eFRAC2 FRAC];

H2 = HC(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC2 = [eFRAC2 FRAC];

H2 = HD(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC2 = [eFRAC2 FRAC];

%% Compare FRFs and compute FRAC - scenarios with 1 magnets

load('sysID01magsA.mat')
sysA = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysA, (2*pi)*fb);

magggA = squeeze(mag);
phaseggA = squeeze(phase);

[RE,IM] = nyquist(sysA, (2*pi)*fb);

reA = squeeze(RE);
imA = squeeze(IM);

HA = complex(reA,imA);


load('sysID01magsB.mat')
sysB = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysB, (2*pi)*fb);

magggB = squeeze(mag);
phaseggB = squeeze(phase);

[RE,IM] = nyquist(sysB, (2*pi)*fb);

reB = squeeze(RE);
imB = squeeze(IM);

HB = complex(reB,imB);


load('sysID01magsC.mat')
sysC = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysC, (2*pi)*fb);

magggC = squeeze(mag);
phaseggC = squeeze(phase);

[RE,IM] = nyquist(sysC, (2*pi)*fb);

reC = squeeze(RE);
imC = squeeze(IM);

HC = complex(reC,imC);


load('sysID01magsD.mat')
sysD = sysID;
DMD = [DMD dmd];

[mag,phase,~] = bode(sysD, (2*pi)*fb);

magggD = squeeze(mag);
phaseggD = squeeze(phase);

[RE,IM] = nyquist(sysD, (2*pi)*fb);

reD = squeeze(RE);
imD = squeeze(IM);

HD = complex(reD,imD);

%%

fi = find(fb==60);
H1 = H0(fi:end); 
eFRAC1 = [];

H2 = HA(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC1 = [eFRAC1 FRAC];

H2 = HB(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC1 = [eFRAC1 FRAC];

H2 = HC(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC1 = [eFRAC1 FRAC];

H2 = HD(fi:end);

FRAC = (abs(H1'*H2))^2/((H1'*H1)*(H2'*H2));
eFRAC1 = [eFRAC1 FRAC];

%% Draw Fig. 12

figure, hold on

plot(1:4,100*eFRAC5,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741],'MarkerFaceColor',[0,0.447,0.741])
plot(1:4,100*eFRAC4,'LineStyle','none','Marker','pentagram','MarkerEdgeColor',[0.85,0.325,0.098],'MarkerFaceColor',[0.85,0.325,0.098],'MarkerSize',10)
plot(1:4,100*eFRAC3,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.694,0.125],'MarkerFaceColor',[0.929,0.694,0.125])
plot(1:4,100*eFRAC2,'LineStyle','none','Marker','hexagram','MarkerEdgeColor',[0.494,0.184,0.556],'MarkerFaceColor',[0.494,0.184,0.556],'MarkerSize',10)
plot(1:4,100*eFRAC1,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0 0.75 0.75],'MarkerFaceColor',[0 0.75 0.75])


grid on, ylabel('FRAC (%)'), title('Frequency Response Assurance Criterion')
legend('5 magnets','4 magnets','3 magnets','2 magnets','1 magnet','Location','best')
ylim([0 100]), xlim([0.5 4.5])

xticklabels({' ','A',' ','B',' ','C',' ','D'})
