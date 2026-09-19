clear all
close all
clc

addpath('..\Data')
addpath('..\Data\sysID')
addpath('..\Data\trajs')

% selecting trajs
tab_data = { 't1_buf_019.mat' 'sysID05magsA.mat';
    't1_buf_026.mat' 'sysID05magsB.mat';
    't1_buf_031.mat' 'sysID05magsC.mat';
    't1_buf_038.mat' 'sysID05magsD.mat';
    't1_buf_065.mat' 'sysID04magsA.mat';
    't1_buf_071.mat' 'sysID04magsB.mat';
    't1_buf_077.mat' 'sysID04magsC.mat';
    't1_buf_084.mat' 'sysID04magsD.mat';
    't1_buf_107.mat' 'sysID03magsA.mat';
    't1_buf_113.mat' 'sysID03magsB.mat';
    't1_buf_119.mat' 'sysID03magsC.mat';
    't1_buf_126.mat' 'sysID03magsD.mat';
    't1_buf_149.mat' 'sysID02magsA.mat';
    't1_buf_155.mat' 'sysID02magsB.mat';
    't1_buf_161.mat' 'sysID02magsC.mat';
    't1_buf_168.mat' 'sysID02magsD.mat';
    't1_buf_191.mat' 'sysID01magsA.mat';
    't1_buf_197.mat' 'sysID01magsB.mat';
    't1_buf_204.mat' 'sysID01magsC.mat';
    't1_buf_210.mat' 'sysID01magsD.mat'};

%%

load('sysIDdatatraj013.mat')

x0 = zeros(nzeta,1);
fs = 2000;

forder = 4;
fmaxf = 900;
[Af,Bf,Cf,Df] = butter(forder,fmaxf/(fs/2),"high");

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

boundConf = 0.15;


%%

RRr = [];

for i = 1:size(tab_data,1)
    i
    
    % Training data
    load(string(tab_data(i,1)))
    load(string(tab_data(i,2)))
    
    sysID2 = sysID;

    yq = y;
    uq = u';
    rq = r';
    wq = [];
    
    ts = 1/fs;
    Nt = size(uq,1);
    
    tq = 0:ts:(Nt-1)/fs;
    
    dataR.time = tq';
    dataR.signals.values = rq;
    dataR.signals.dimensions = size(rq,2);
    
    fcut = 2;
    
    out = sim(sim_closed_loop_with_identifiedmodel);
    
    usim = (out.usim.Data)';
    ysim = (out.ysim.Data)';
    tsim = out.tout;

    lagsmax = 50;
    ery = yq - ysim;
    
    [Rerr,lags] = xcorr(ery,r,lagsmax);
    [Rey,~] = xcorr(ery,lagsmax);
    [Rr,~] = xcorr(r,lagsmax);
    
    fi = find(lags == 0);
    
    Rey0 = Rey(fi);
    Rr0 = Rr(fi);
    
    Rerr = Rerr/sqrt(Rey0*Rr0);

    RRr = [RRr max(abs(Rerr))];

    if i == 1
        % Draw Fig. 9(a)
        figure, stem(lags,Rerr)
        hold on, plot(lagsmax*[-1 1],boundConf*[1 1],'k','LineStyle','--')
        plot(lagsmax*[-1 1],boundConf*[-1 -1],'k','LineStyle','--')
        grid on, xlabel('Lags'), xlim([-10 50]), ylim([-0.2 0.2]) 
    end
       
    

end


%% Draw Fig. 9(b)

zz = (reshape(RRr,[4,5]))';

figure, plot(1:4,zz(1,:),'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741],'MarkerFaceColor',[0,0.447,0.741])
hold on, plot(1:4,zz(2,:),'LineStyle','none','Marker','pentagram','MarkerEdgeColor',[0.85,0.325,0.098],'MarkerFaceColor',[0.85,0.325,0.098],'MarkerSize',10)
plot(1:4,zz(3,:),'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.694,0.125],'MarkerFaceColor',[0.929,0.694,0.125])
plot(1:4,zz(4,:),'LineStyle','none','Marker','hexagram','MarkerEdgeColor',[0.494,0.184,0.556],'MarkerFaceColor',[0.494,0.184,0.556],'MarkerSize',10)
plot(1:4,zz(5,:),'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0 0.75 0.75],'MarkerFaceColor',[0 0.75 0.75])

grid on, ylabel('max(abs(r))'), title('Max r'), xlabel('Disturbance profile')
legend('5 magnets','4 magnets','3 magnets','2 magnets','1 magnet')
ylim([0 0.15]), xlim([0.5 4.5])

