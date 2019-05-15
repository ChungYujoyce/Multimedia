%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('audio/HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
[frequency, magnitude] = make_spectrum(y_input, fs);
figure(1);
plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
axis([0 2000 0 30000]);
%% 2. Filtering 
% (Hint) Implement my_filter here
% [...] = my_filter(...);
%%%low-pass
w_c = fs/2;
[outputSignal, outputFilter] = my_filter(y_input, fs, 1501,'Blackmann', 'low-pass', 380);
%%%bandpass
[outputSignal_pass, outputFilter_pass] = my_filter(y_input, fs, 1501,'Blackmann', 'bandpass', [381 700]);
%%%high-pass
[outputSignal_high, outputFilter_high] = my_filter(y_input, fs, 1501,'Blackmann', 'high-pass', 701);
%%% Plot the shape of filters in Time domain
%low-pass
N=1501;
x = -N/2:1:N/2-1;
y = outputFilter(x+N/2+1,1);
figure(2);
subplot(2,2,1),plot(x,y);
title('Low-pass Filter (Time)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%bandpass
x = -N/2:1:N/2-1;


y = outputFilter_pass(x+N/2+1,1);
subplot(2,2,2),plot(x,y);
title('Bandpass Filter (Time)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%high-pass
x = -N/2:1:N/2-1;
y = outputFilter_high(x+N/2+1,1);
subplot(2,2,3),plot(x,y);
title('High-pass Filter (Time)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%%% Plot the spectrum of filters (Frequency Analysis)
%low-pass
[frequency, magnitude] = make_spectrum(outputFilter, fs);
figure(3);
subplot(2,2,1),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('Low-pass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%bandpass
[frequency, magnitude] = make_spectrum(outputFilter_pass, fs);
subplot(2,2,2),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('Bandpass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%high-pass
[frequency, magnitude] = make_spectrum(outputFilter_high, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('High-pass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter
% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);
audiowrite('Low-passFilter_0_380.wav', outputSignal, fs);
audiowrite('BandpassFilter381_700.wav',outputSignal_pass, fs);
audiowrite('HighpassFilter_701_.wav',outputSignal_high,fs);
%%% Plot the spectrum of filtered signals
%low-pass
[frequency, magnitude] = make_spectrum(outputSignal, fs);
figure(4);
subplot(2,2,1),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Low-pass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%bandpass
[frequency, magnitude] = make_spectrum(outputSignal_pass, fs);
subplot(2,2,2),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Bandpass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%high-pass
[frequency, magnitude] = make_spectrum(outputSignal_high, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('High-pass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);