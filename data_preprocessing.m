clear all
close all
clc

ii = 13;

    load(['buf_2' num2str(ii) '.mat'])
    data = eval(['buf_2' num2str(ii)]); 
    name = ['t1_buf_2' num2str(ii) '.mat'];

    ts = data.X(2).Data;
    fs = 2000;

    fcut = 2;

    rs = data.Y(3).Data; 
    us = data.Y(4).Data; 
    ws = data.Y(5).Data; 
    ys = data.Y(6).Data; 

    uf = highpass(us, fcut, fs,'ImpulseResponse','iir');
    wf = highpass(ws, fcut, fs,'ImpulseResponse','iir');
    yf = highpass(ys, fcut, fs,'ImpulseResponse','iir');


    % figure, subplot(3,1,1), plot(uf), grid on, ylabel('u')
    % subplot(3,1,2), plot(wf), grid on, ylabel('w')
    % subplot(3,1,3), plot(yf), grid on, ylabel('y')

    ti = find(abs(wf)>1e-2,1); 
    tf = ti + 10*fs;

    t = ts(ti:tf);
    u = uf(ti:tf);
    w = wf(ti:tf);
    y = yf(ti:tf);

    % figure, subplot(3,1,1), plot(t,u), grid on, ylabel('u')
    % subplot(3,1,2), plot(t,w), grid on, ylabel('w')
    % subplot(3,1,3), plot(t,y), grid on, ylabel('y'), xlabel('Time (s)')

    % Nx = length(y);
    % nsc = floor(Nx/4.5);
    % nov = floor(nsc/2);
    % nff = max(256,2^nextpow2(nsc));

    % figure, modalfrf(u',y',fs,hamming(nsc),nov,'sensor','dis')
    % figure, modalfrf(w',y',fs,hamming(nsc),nov,'sensor','dis')

    save(name,'t','u','w','y')