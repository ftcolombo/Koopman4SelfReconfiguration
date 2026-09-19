clear all
close all
clc

% Training data obtained after applying data_preprocessing.m

load('t1_buf_013.mat')

fs = 2000;
yq = y;
uq = u';

n = 20;
nD = 40;

ts = 1/fs;
Nt = size(uq,1);

tq = 0:ts:(Nt-1)/fs;

wq = [];
Ntraj = size(uq,2);

ny = size(yq,1)/Ntraj;
nu = size(uq,2)/Ntraj;
nw = size(wq,2)/Ntraj;

% figure, plot(tq,yq)
% grid on, xlabel('Time (s)'), ylabel('Output')


% %%

y = yq;
u = [uq wq]';


% % Delay-embedded "state" 
% % zeta_k = [y_{k} ; u_{k-1} ; y_{k-1} ... u_{k-nd} ; y_{k-nd} ];

zeta_current = [ reshape(y(:,1),[ny Ntraj]) ; NaN(nD*(ny + nu+nw),Ntraj)];

tic
X = []; Y = []; U = [];
for i = 1:size(y,2)-1
    zeta_prev = zeta_current;
    i
    
    zeta_current = [ [ reshape(y(:,i+1),[ny Ntraj]) ; reshape(u(:,i),[Ntraj nu+nw])'] ; zeta_current( 1:end-ny-nu-nw , : ) ];

    if(i > nD+1)
        X = [X zeta_prev];
        Y = [Y zeta_current];
        U = [U reshape(u(:,i),[Ntraj nu+nw])'];
    end
end
toc

liftFun = @(x)( x ) ;

nfun = size(X,1);
Nlift = numel(liftFun(rand(nfun,1)));

Xlift = liftFun(X);
Ylift = liftFun(Y);

% Regression
W = [Ylift ; X];
V = [Xlift ; U];
VVt = V*V';
WVt = W*V';

ABC = WVt * pinv(VVt);

Alift = ABC(1:Nlift,1:Nlift);
Blift = ABC(1:Nlift,Nlift+1:end);
Clift = ABC(Nlift+1:end,1:Nlift);

aa = Alift;
aa(abs(aa) < 1e-5)=0;
bb = Blift;
bb(abs(bb) < 1e-5)=0;
cc = Clift;
cc(abs(cc) < 1e-5)=0;

[~,Lambda] = eig(Alift); 
lambda = diag(Lambda);
s_dmd = log(lambda)/ts;
dmd = [abs(s_dmd)/(2*pi) -real(s_dmd)./abs(s_dmd)];

nzeta = size(Alift,1);
sysID = ss(Alift, Blift, Clift(1,:), [], ts);

%% Testing the ability of the DMD model to reconstruct the training data
Ti = 0;
TT = tq(end);
cost_func = 'NRMSE';

itraj = 1;
uqq = [uq(:, (itraj-1)*nu+1 : itraj*nu) wq(:, (itraj-1)*nw+1 : itraj*nw)]';    
yqq = yq((itraj-1)*ny+1 : itraj*ny, :);

yDMD = (lsim(sysID, uqq, tq, zeros(nzeta,1)))';


Gfit = goodnessOfFit(yDMD',yqq',cost_func);
fitcompare = (1-Gfit)*100 

figure, plot(tq, yqq)
hold on, plot(tq, yDMD,'LineWidth',1.2,'LineStyle','-.')
grid on, xlabel('Time (s)'), ylabel('Output')
legend('Experimental','Simulation'), title(['Validation (' num2str(fitcompare,4) '% fit)'])
xlim([0 0.1])


%%
load('buf_013.mat')
data = buf_013; 
% load('buf_227.mat')
% data = buf_227;

t = data.X(2).Data;
fs = round(1/(t(2)-t(1)));

r = data.Y(3).Data; 
u = data.Y(4).Data; 
w = data.Y(5).Data; 
y = data.Y(6).Data; 

Nx = length(y);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfu,fu] = modalfrf(u',y',fs,hamming(nsc),nov,'Sensor','dis');

fb = fu;%0:0.25:1000;
[mag,phase,wout] = bode(sysID, (2*pi)*fb);

maggg = squeeze(mag);
phasegg = squeeze(phase);


figure, 
subplot(2,1,1), plot(fu, mag2db(abs(frfu)),'LineWidth',1.5)
hold on, plot(wout/(2*pi), mag2db(maggg),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]) 
legend('From Data','Estimated by DMD','Location','best')
title('FRF Y/U')

subplot(2,1,2), plot(fu, angle(frfu),'LineWidth',1.5)
hold on, plot(wout/(2*pi), wrapToPi(phasegg*pi/180),'LineWidth',1.5,'LineStyle','-.')
grid on, xlabel('Frequency (Hz)'), ylabel('Phase (rad)'), xlim([60 1000]) 
    

%%
% save('sysIDdatatraj013','sysID','D','ABC','VVt','nD','nzeta','nu','nw','ny','liftFun','dmd')
% save('sysIDdatatraj227','sysID','D','ABC','VVt','nD','nzeta','nu','nw','ny','liftFun','dmd')
