clear all
close all
clc

addpath('..\Data')
addpath('..\Data\trajs')

load('trajs05mags.mat') %% all 42 trajectories (u-w-y) preprocessed and 
% collected from the experiment with 05 magnets

urms5 = rms(uq);
yrms5 = rms(yq);

load('trajs04mags.mat')

urms4 = rms(uq);
yrms4 = rms(yq);

load('trajs03mags.mat')

urms3 = rms(uq);
yrms3 = rms(yq);

load('trajs02mags.mat')

urms2 = rms(uq);
yrms2 = rms(yq);

load('trajs01mags.mat')

urms1 = rms(uq);
yrms1 = rms(yq);

clear uq yq wq

ind5A = [3:6 27:42];

indSA = 3:6;
indSB = 9:12;
indSC = 15:18;
indSD = 21:24;

%%

yrms5A = yrms5(ind5A);
urms5A = urms5(ind5A);
yu5A = yrms5A./urms5A;
x5A = linspace(1-0.25,1+0.25,length(ind5A));

yrms5B = yrms5(indSB);
urms5B = urms5(indSB);
yu5B = yrms5B./urms5B;
x5B = linspace(2-0.1,2+0.1,length(indSB));

yrms5C = yrms5(indSC);
urms5C = urms5(indSC);
yu5C = yrms5C./urms5C;
x5C = linspace(3-0.1,3+0.1,length(indSC));

yrms5D = yrms5(indSD);
urms5D = urms5(indSD);
yu5D = yrms5D./urms5D;
x5D = linspace(4-0.1,4+0.1,length(indSD));

yrms4A = yrms4(indSA);
urms4A = urms4(indSA);
yu4A = yrms4A./urms4A;
x4A = linspace(1-0.1,1+0.1,length(indSA));

yrms4B = yrms4(indSB);
urms4B = urms4(indSB);
yu4B = yrms4B./urms4B;
x4B = linspace(2-0.1,2+0.1,length(indSB));

yrms4C = yrms4(indSC);
urms4C = urms4(indSC);
yu4C = yrms4C./urms4C;
x4C = linspace(3-0.1,3+0.1,length(indSC));

yrms4D = yrms4(indSD);
urms4D = urms4(indSD);
yu4D = yrms4D./urms4D;
x4D = linspace(4-0.1,4+0.1,length(indSD));


yrms3A = yrms3(indSA);
urms3A = urms3(indSA);
yu3A = yrms3A./urms3A;
x3A = linspace(1-0.1,1+0.1,length(indSA));

yrms3B = yrms3(indSB);
urms3B = urms3(indSB);
yu3B = yrms3B./urms3B;
x3B = linspace(2-0.1,2+0.1,length(indSB));

yrms3C = yrms3(indSC);
urms3C = urms3(indSC);
yu3C = yrms3C./urms3C;
x3C = linspace(3-0.1,3+0.1,length(indSC));

yrms3D = yrms3(indSD);
urms3D = urms3(indSD);
yu3D = yrms3D./urms3D;
x3D = linspace(4-0.1,4+0.1,length(indSD));


yrms2A = yrms2(indSA);
urms2A = urms2(indSA);
yu2A = yrms2A./urms2A;
x2A = linspace(1-0.1,1+0.1,length(indSA));

yrms2B = yrms2(indSB);
urms2B = urms2(indSB);
yu2B = yrms2B./urms2B;
x2B = linspace(2-0.1,2+0.1,length(indSB));

yrms2C = yrms2(indSC);
urms2C = urms2(indSC);
yu2C = yrms2C./urms2C;
x2C = linspace(3-0.1,3+0.1,length(indSC));

yrms2D = yrms2(indSD);
urms2D = urms2(indSD);
yu2D = yrms2D./urms2D;
x2D = linspace(4-0.1,4+0.1,length(indSD));


yrms1A = yrms1(indSA);
urms1A = urms1(indSA);
yu1A = yrms1A./urms1A;
x1A = linspace(1-0.1,1+0.1,length(indSA));

yrms1B = yrms1(indSB);
urms1B = urms1(indSB);
yu1B = yrms1B./urms1B;
x1B = linspace(2-0.1,2+0.1,length(indSB));

yrms1C = yrms1(indSC);
urms1C = urms1(indSC);
yu1C = yrms1C./urms1C;
x1C = linspace(3-0.1,3+0.1,length(indSC));

yrms1D = yrms1(indSD);
urms1D = urms1(indSD);
yu1D = yrms1D./urms1D;
x1D = linspace(4-0.1,4+0.1,length(indSD));


figure, 
subplot(2,1,1), plot(x5A,yrms5A,'LineStyle','none','Marker','o','MarkerEdgeColor',[0.47,0.67,0.19])
hold on, plot(x5B,yrms5B,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741])
plot(x5C,yrms5C,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741])
h5 = plot(x5D,yrms5D,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741],'DisplayName','5 magnets');

plot(x4A,yrms4A,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
plot(x4B,yrms4B,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
plot(x4C,yrms4C,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
h4 = plot(x4D,yrms4D,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098],'DisplayName','4 magnets');

plot(x3A,yrms3A,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
plot(x3B,yrms3B,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
plot(x3C,yrms3C,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
h3 = plot(x3D,yrms3D,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125],'DisplayName','3 magnets');

plot(x2A,yrms2A,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
plot(x2B,yrms2B,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
plot(x2C,yrms2C,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
h2 = plot(x2D,yrms2D,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556],'DisplayName','2 magnets');

plot(x1A,yrms1A,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
plot(x1B,yrms1B,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
plot(x1C,yrms1C,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
h1 = plot(x1D,yrms1D,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75],'DisplayName','1 magnet');


grid on, ylabel('RMS value (V)'), title('(a) Y')
legend([h5, h4, h3, h2, h1])
xlim([0.5 4.5]), ylim([2 16]*1e-3)
xticklabels({' ','A',' ','B',' ','C',' ','D'})

subplot(2,1,2), plot(x5A,yu5A,'LineStyle','none','Marker','o','MarkerEdgeColor',[0.47,0.67,0.19])
hold on, plot(x5B,yu5B,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741])
plot(x5C,yu5C,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741])
h5 = plot(x5D,yu5D,'LineStyle','none','Marker','o','MarkerEdgeColor',[0,0.447,0.741],'DisplayName','5 magnets');

plot(x4A,yu4A,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
plot(x4B,yu4B,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
plot(x4C,yu4C,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098])
h4 = plot(x4D,yu4D,'LineStyle','none','Marker','x','MarkerEdgeColor',[0.85,0.325,0.098],'DisplayName','4 magnets');

plot(x3A,yu3A,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
plot(x3B,yu3B,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
plot(x3C,yu3C,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125])
h3 = plot(x3D,yu3D,'LineStyle','none','Marker','square','MarkerEdgeColor',[0.929,0.6940,0.125],'DisplayName','3 magnets');

plot(x2A,yu2A,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
plot(x2B,yu2B,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
plot(x2C,yu2C,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556])
h2 = plot(x2D,yu2D,'LineStyle','none','Marker','+','MarkerEdgeColor',[0.494,0.184,0.556],'DisplayName','2 magnets');

plot(x1A,yu1A,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
plot(x1B,yu1B,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
plot(x1C,yu1C,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75])
plot(x1D,yu1D,'LineStyle','none','Marker','diamond','MarkerEdgeColor',[0,0.75,0.75],'DisplayName','1 magnet');


grid on, ylabel('RMS value (V/V)'), title('(b) Y/U')
xlim([0.5 4.5]), ylim([0.04 0.1])
xticklabels({' ','A',' ','B',' ','C',' ','D'})

