clear all
close all
clc

addpath('..\Data')
addpath('..\Data\trajs')

load('trajs05mags.mat') %% all 42 trajectories (u-w-y) preprocessed and 
% collected from the experiment with 05 magnets

u5 = uq;
w5 = wq;
y5 = yq;

load('trajs04mags.mat')

u4 = uq;
w4 = wq;
y4 = yq;

load('trajs03mags.mat')

u3 = uq;
w3 = wq;
y3 = yq;

load('trajs02mags.mat')

u2 = uq;
w2 = wq;
y2 = yq;

load('trajs01mags.mat')

u1 = uq;
w1 = wq;
y1 = yq;

ts = 1/fs;
Nt = size(u5,1);
tq = 0:ts:(Nt-1)/fs;

forder = 4;
fmaxf = 900;
[Af,Bf,Cf,Df] = butter(forder,fmaxf/(fs/2),"high");
sysf = ss(Af,Bf,Cf,Df,1/fs);


%%

Nx = size(yq,1);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[frfw5, fw5] = modalfrf(w5(:,2)',y5(:,2)',fs,hamming(nsc),nov,'Sensor','dis');
[frfu5, fu5] = modalfrf(u5(:,1)',y5(:,1)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw5cl, fw5cl] = modalfrf(w5(:,3)',y5(:,3)',fs,hamming(nsc),nov,'Sensor','dis');

[frfw4, fw4] = modalfrf(w4(:,2)',y4(:,2)',fs,hamming(nsc),nov,'Sensor','dis');
[frfu4, fu4] = modalfrf(u4(:,1)',y4(:,1)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw4cl, fw4cl] = modalfrf(w4(:,3)',y4(:,3)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw4cl2, fw4cl2] = modalfrf(w4(:,27)',y4(:,27)',fs,hamming(nsc),nov,'Sensor','dis');

[frfw3, fw3] = modalfrf(w3(:,2)',y3(:,2)',fs,hamming(nsc),nov,'Sensor','dis');
[frfu3, fu3] = modalfrf(u3(:,1)',y3(:,1)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw3cl, fw3cl] = modalfrf(w3(:,3)',y3(:,3)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw3cl2, fw3cl2] = modalfrf(w3(:,27)',y3(:,27)',fs,hamming(nsc),nov,'Sensor','dis');
 
[frfw2, fw2] = modalfrf(w2(:,2)',y2(:,2)',fs,hamming(nsc),nov,'Sensor','dis');
[frfu2, fu2] = modalfrf(u2(:,1)',y2(:,1)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw2cl, fw2cl] = modalfrf(w2(:,3)',y2(:,3)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw2cl2, fw2cl2] = modalfrf(w2(:,27)',y2(:,27)',fs,hamming(nsc),nov,'Sensor','dis');

[frfw1, fw1] = modalfrf(w1(:,2)',y1(:,2)',fs,hamming(nsc),nov,'Sensor','dis');
[frfu1, fu1] = modalfrf(u1(:,1)',y1(:,1)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw1cl, fw1cl] = modalfrf(w1(:,3)',y1(:,3)',fs,hamming(nsc),nov,'Sensor','dis');
[frfw1cl2, fw1cl2] = modalfrf(w1(:,27)',y1(:,27)',fs,hamming(nsc),nov,'Sensor','dis');


%% Draw Fig. 13

figure, 
subplot(2,2,1), hold on
plot(fw4(1:3:end), mag2db(abs(frfw4(1:3:end))),'Color',[0 0.45 0.75],'LineWidth',1.5)
plot(fw4cl(1:3:end), mag2db(abs(frfw4cl(1:3:end))),'Color',[0.85 0.32 0.09],'LineWidth',1)
plot(fw4cl2(1:3:end), mag2db(abs(frfw4cl2(1:3:end))),'Color',[0.46 0.67 0.18],'LineWidth',1)
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-60 -15])
title('FRF Y/W Caso 4A'), 
legend('OL', 'CL initial', 'CL updated','Location','southeast')

subplot(2,2,2), hold on
plot(fw3(1:3:end), mag2db(abs(frfw3(1:3:end))),'Color',[0 0.45 0.75],'LineWidth',1.5)
plot(fw3cl(1:3:end), mag2db(abs(frfw3cl(1:3:end))),'Color',[0.85 0.32 0.09],'LineWidth',1)
plot(fw3cl2(1:3:end), mag2db(abs(frfw3cl2(1:3:end))),'Color',[0.46 0.67 0.18],'LineWidth',1)
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-60 -15]) 
title('FRF Y/W Caso 3A'), 

subplot(2,2,3), hold on
plot(fw2(1:3:end), mag2db(abs(frfw2(1:3:end))),'Color',[0 0.45 0.75],'LineWidth',1.5)
plot(fw2cl(1:3:end), mag2db(abs(frfw2cl(1:3:end))),'Color',[0.85 0.32 0.09],'LineWidth',1)
plot(fw2cl2(1:3:end), mag2db(abs(frfw2cl2(1:3:end))),'Color',[0.46 0.67 0.18],'LineWidth',1)
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-60 -15]) 
title('FRF Y/W Caso 2A'), 

subplot(2,2,4), hold on
plot(fw1(1:3:end), mag2db(abs(frfw1(1:3:end))),'Color',[0 0.45 0.75],'LineWidth',1.5)
plot(fw1cl(1:3:end), mag2db(abs(frfw1cl(1:3:end))),'Color',[0.85 0.32 0.09],'LineWidth',1)
plot(fw1cl2(1:3:end), mag2db(abs(frfw1cl2(1:3:end))),'Color',[0.46 0.67 0.18],'LineWidth',1)
grid on, xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), xlim([60 1000]), ylim([-60 -15]) 
title('FRF Y/W Caso 1A'), 


%%

yj = y5;
uj = u5;

Qy = 2e3; Qu = 10; R = 1;
J5 = zeros(1,size(uj,2));
for i = 1:size(uj,1)
    for j = 1:size(uj,2)
        J5(j) = J5(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end

yj = y4;
uj = u4;

Qy = 2e3; Qu = 10; R = 1;
J4 = zeros(1,size(uj,2));
for i = 1:size(uj,1)
    for j = 1:size(uj,2)
        J4(j) = J4(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end

yj = y3;
uj = u3;

Qy = 2e3; Qu = 10; R = 1;
J3 = zeros(1,size(uj,2));
for i = 1:size(uj,1)
    for j = 1:size(uj,2)
        J3(j) = J3(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end

yj = y2;
uj = u2;

Qy = 2e3; Qu = 10; R = 1;
J2 = zeros(1,size(uj,2));
for i = 1:size(uj,1)
    for j = 1:size(uj,2)
        J2(j) = J2(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end

yj = y1;
uj = u1;

Qy = 2e3; Qu = 10; R = 1;
J1 = zeros(1,size(uj,2));
for i = 1:size(uj,1)
    for j = 1:size(uj,2)
        J1(j) = J1(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end


indb = [3:6 9:12 15:18 21:24];

%%
load('trajsOLYW.mat') % set of 5 trajectories, collected with 5 -> 1 magnet, 
% considering open-loop response to the disturbance

yj = yq;

Qy = 2e3; 
JOL = zeros(1,size(yj,2));
for i = 1:size(yj,1)
    for j = 1:size(yj,2)
        JOL(j) = JOL(j) + yj(i,j)'.*Qy.*yj(i,j);
    end
end

JOL = JOL*1e-3;

J5Aini = J5(3)*1e-3;

J4Aini = J4(3)*1e-3;
J4Aadap = J4(27)*1e-3;

J3Aini = J3(3)*1e-3;
J3Aadap = J3(27)*1e-3;

J2Aini = J2(3)*1e-3;
J2Aadap = J2(27)*1e-3;

J1Aini = J1(3)*1e-3;
J1Aadap = J1(27)*1e-3;

JA = [JOL; [J5Aini J4Aini J3Aini J2Aini J1Aini]; [0*J5Aini J4Aadap J3Aadap J2Aadap J1Aadap]]';

%% Draw Fig. 14(a)

figure, bar(JA)
grid on, title('Vibration cost - disturbance profile A')
ylabel('Cost J'), xlabel('Number of Magnets 5->1 (1 = 5 mag, 2 = 4 mag, ...)'), ylim([0 4])

%%

indSA = 3:6;
indSB = 9:12;
indSC = 15:18;
indSD = 21:24;

indSAh = 27:30;
indSBh = 31:34;
indSCh = 35:38;
indSDh = 39:42;

xcatH = categorical({'A' 'B' 'C' 'D'},{'A' 'B' 'C' 'D'});

Jy = J4*1e-3;
J4ini = [Jy(indSA); Jy(indSB); Jy(indSC); Jy(indSD)]';
J4adap = [Jy(indSAh); Jy(indSBh); Jy(indSCh); Jy(indSDh)]';

J4ini = mean(J4ini); 
J4adap = mean(J4adap);
J4imp = 100*(J4ini-J4adap)./J4ini;

Jy = J3*1e-3;
J3ini = [Jy(indSA); Jy(indSB); Jy(indSC); Jy(indSD)]';
J3adap = [Jy(indSAh); Jy(indSBh); Jy(indSCh); Jy(indSDh)]';

J3ini = mean(J3ini);
J3adap = mean(J3adap);
J3imp = 100*(J3ini-J3adap)./J3ini;

Jy = J2*1e-3;
J2ini = [Jy(indSA); Jy(indSB); Jy(indSC); Jy(indSD)]';
J2adap = [Jy(indSAh); Jy(indSBh); Jy(indSCh); Jy(indSDh)]';

J2ini = mean(J2ini);
J2adap = mean(J2adap);
J2imp = 100*(J2ini-J2adap)./J2ini;

Jy = J1*1e-3;
J1ini = [Jy(indSA); Jy(indSB); Jy(indSC); Jy(indSD)]';
J1adap = [Jy(indSAh); Jy(indSBh); Jy(indSCh); Jy(indSDh)]';

J1ini = mean(J1ini);
J1adap = mean(J1adap);
J1imp = 100*(J1ini-J1adap)./J1ini;

J = [[J4ini; J4adap]' [J3ini; J3adap]' [J2ini; J2adap]' [J1ini; J1adap]'];

Jimp = [J4imp; J3imp; J2imp; J1imp];

%% Draw Fig. 14(b)

figure, 
subplot1 = subplot(2,2,1);
bar1 = bar(J(:,1:2));
xtips2 = bar1(2).XEndPoints;
ytips2 = bar1(2).YEndPoints;

text(xtips2(1),ytips2(1),[num2str(Jimp(1,1),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(2),ytips2(2),[num2str(Jimp(1,2),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(3),ytips2(3),[num2str(Jimp(1,3),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(4),ytips2(4),[num2str(Jimp(1,4),'%.0f'),'%'],'HorizontalAlignment','center','VerticalAlignment','bottom')
grid on, title('(a) 4 magnets')
ylabel('Cost J'), xlabel('Disturbance profiles (1 = A, 2 = B, ...)'), ylim([0 10])

set(bar1(1),'DisplayName','Initial');
set(bar1(2),'DisplayName','Updated');
legend(subplot1,'show', 'Location','northwest');

subplot(2,2,2), 
bar1 = bar(J(:,3:4));
xtips2 = bar1(2).XEndPoints;
ytips2 = bar1(2).YEndPoints;
text(xtips2(1),ytips2(1),[num2str(Jimp(2,1),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(2),ytips2(2),[num2str(Jimp(2,2),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(3),ytips2(3),[num2str(Jimp(2,3),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(4),ytips2(4),[num2str(Jimp(2,4),'%.0f'),'%'],'HorizontalAlignment','center','VerticalAlignment','bottom')
grid on, title('(b) 3 magnets')
ylabel('Cost J'), xlabel('Disturbance profiles'), ylim([0 10])

subplot(2,2,3), 
bar1 = bar(J(:,5:6));
xtips2 = bar1(2).XEndPoints;
ytips2 = bar1(2).YEndPoints;
text(xtips2(1),ytips2(1),[num2str(Jimp(3,1),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(2),ytips2(2),[num2str(Jimp(3,2),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(3),ytips2(3),[num2str(Jimp(3,3),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(4),ytips2(4),[num2str(Jimp(3,4),'%.0f'),'%'],'HorizontalAlignment','center','VerticalAlignment','bottom')
grid on, title('(c) 2 magnets')
ylabel('Cost J'), xlabel('Disturbance profiles'), ylim([0 10])

subplot(2,2,4), 
bar1 = bar(J(:,7:8));
xtips2 = bar1(2).XEndPoints;
ytips2 = bar1(2).YEndPoints;
text(xtips2(1),ytips2(1),[num2str(Jimp(4,1),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(2),ytips2(2),[num2str(Jimp(4,2),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(3),ytips2(3),[num2str(Jimp(4,3),'%.0f'),'%'],'HorizontalAlignment','left','VerticalAlignment','bottom')
text(xtips2(4),ytips2(4),[num2str(Jimp(4,4),'%.0f'),'%'],'HorizontalAlignment','center','VerticalAlignment','bottom')
grid on, title('(d) 1 magnet')
ylabel('Cost J'), xlabel('Disturbance profiles'), ylim([0 10])


