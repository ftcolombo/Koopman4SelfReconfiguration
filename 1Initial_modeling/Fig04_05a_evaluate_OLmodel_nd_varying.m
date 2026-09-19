clear all
% close all
clc

% Training data

addpath('..\Data')

load('t1_buf_013.mat')
fs = 2000;
wq = [];

yq = y;
uq = u';

ts = 1/fs;
Nt = size(uq,1);

tq = 0:ts:(Nt-1)/fs;

Ntraj = size(uq,2);

ny = size(yq,1)/Ntraj;
nu = size(uq,2)/Ntraj;
nw = size(wq,2)/Ntraj;

y = yq;
u = [uq wq]';

X0 = [y(:,2:end-1); u(:,1:end-2)];
Y0 = [y(:,3:end); u(:,2:end-1)];
U0 = u(:,2:end-1);


%% Stabilization analysis

r_min = 10;
r_max = 45;
kk = r_min:1:r_max;
nr = length(kk);

sr = zeros(r_max, nr);

for ink = kk

    nD = ink

    XX=[];YY=[];UU=[];
    if nD>0
        for i = 0:nD
            XX = [X0(:,i+1:end); XX(:,1:end-1)];
            YY = [Y0(:,i+1:end); YY(:,1:end-1)];
            UU = [U0(:,i+1:end); UU(:,1:end-1)];
        end
        X=XX(1:end-1,:); Y=YY(1:end-1,:); U=UU(1,:);
    else
        X=X0; Y=Y0; U=U0;
    
    end

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
    
    [~,Lambda] = eig(Alift); 
    lambda = diag(Lambda);
    s_dmd = log(lambda)/ts;

    
    sr(1:length(s_dmd), i) = s_dmd;

end


%% Evaluating the stability of the eigenvalues computed by DMD for an increased order r of the SVD

o_min = 10; % analysing only the models with order >= o_min
f_max = 1000; % restricting the frequency range to [ 0 ; f_max ]

nr = length(kk);

fr = abs(sr)/(2*pi);
dr = 0*fr;
for i = 1:max(kk)
    dr(:,i) = -real(sr(:,i))./abs(sr(:,i));
end

fst = false(size(fr));

tol = [0.002 0.002];
for i = kk(1):kk(end-1)
    f0 = fr(1:2*i+1, i);
    f1 = fr(1:2*(i+1)+1, i+1);
    d0 = dr(1:2*i+1, i);
    d1 = dr(1:2*(i+1)+1, i+1);    
    for j = 1:2*i+1
        if abs(f0(j)) < tol(1) && min(abs(f0(j)-f1(:))) < tol(1)
            fst(j,i) = true;
        end
        if min(abs(f0(j)-f1(:))) < tol(1)*f0(j)
            fst(j,i) = true;
        end
    end
end

i_f = 0;
i_ns = 0;
for i = kk(1):kk(end-1)
    for j = 1:2*i+1
        if fst(j,i) == true
            i_f = i_f+1;
            v_f(1,i_f) = fr(j,i);
            v_f(2,i_f) = i;
        else
            i_ns = i_ns+1;
            v_ns(1,i_ns) = fr(j,i);
            v_ns(2,i_ns) = i;
        end
    end
end

a_ns = find(v_ns(2,:) >= o_min,1);
a_f = find(v_f(2,:) >= o_min,1);

v_ns2 = v_ns(:,a_ns:end);
v_f2 = v_f(:,a_f:end);

j = 1;
for i = 1:size(v_ns2,2)
    if v_ns2(1,i) <= f_max
        v_ns3(:,j) = v_ns2(:,i);
        j = j+1;
    end
end


j = 1;
for i = 1:size(v_f2,2)
    if v_f2(1,i) <= f_max
        v_f3(:,j) = v_f2(:,i);
        j = j+1;
    end
end

%%

fs = 2000;

Nx = length(y);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfu,fu] = modalfrf(u',y',fs,hamming(nsc),nov,'Sensor','dis');

%% Draw Fig. 5.(a)

figure,
yyaxis left
hold on
plot(v_ns3(1,1:2:end),v_ns3(2,1:2:end),'.', 'MarkerSize', 6, 'Color', [0.8 0.8 0.8])
plot(v_f3(1,1:2:end),v_f3(2,1:2:end),'o', 'MarkerSize', 2, 'Color', [0 0 0.55])
ylabel('Model Order')

yyaxis right
plot(fu, mag2db(abs(frfu)))
ylabel('Magnitude (dB)')

legend('Not Stable', 'Stable in freq.', 'frequency response')
legend('Orientation','horizontal')

grid on
xlabel('Frequency (Hz)')
title('Stability Diagram')
xlim([60 1000])






%% Testing the ability of the DMD model to estimate the testing data

cost_func = 'NRMSE';

load("test_buf_013.mat") % test data: portion of traj_013 not used for training
w = [];

w = [];

Nt = size(t,2);
tq = 0:ts:(Nt-1)/fs;

r_min = 10;
r_max = 45;
kk = r_min:1:r_max;


for ink = kk

    nD = ink

    XX=[];YY=[];UU=[];
    if nD>0
        for i = 0:nD
            XX = [X0(:,i+1:end); XX(:,1:end-1)];
            YY = [Y0(:,i+1:end); YY(:,1:end-1)];
            UU = [U0(:,i+1:end); UU(:,1:end-1)];
        end
        X=XX(1:end-1,:); Y=YY(1:end-1,:); U=UU(1,:);
    else
        X=X0; Y=Y0; U=U0;

    end



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



    [~,Lambda] = eig(Alift); 
    lambda = diag(Lambda);
    s_dmd = log(lambda)/ts;

    nzeta = size(Alift,1);
    sysID = ss(Alift, Blift, Clift(1,:), [], ts);

    yDMD = (lsim(sysID, u, tq, zeros(nzeta,1)))';

    fit = goodnessOfFit(yDMD',y',cost_func);

    fitcompare(ink) = (1-fit)*100;


end

%% Draw Fig. 4

figure, 
plot(kk, fitcompare(kk),'Marker','o')
grid on, xlabel('Number of time embeddings'), ylabel('fit %')
ylim([35 100])




