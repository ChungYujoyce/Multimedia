%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
[frequency, magnitude] = makeSpectrum(y_input, fs);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
axis([0 2000 0 30000]); %change the axis range to make the plotted result more clearly 
%% 2. Filtering 
%low-pass
[outputSignal, outputFilter] = myFilter(y_input, fs, 1501,'Blackmann', 'low-pass', 380);
%bandpass
[outputSignal_pass, outputFilter_pass] = myFilter(y_input, fs, 1501,'Blackmann', 'bandpass', [380 701]);
%high-pass
[outputSignal_high, outputFilter_high] = myFilter(y_input, fs, 1501,'Blackmann', 'high-pass', 701);

%%% Plot the shape of filters in Time domain
% low-pass

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
[frequency, magnitude] = makeSpectrum(outputFilter, fs);
figure(3);
subplot(2,2,1),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('Low-pass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%bandpass
[frequency, magnitude] = makeSpectrum(outputFilter_pass, fs);
subplot(2,2,2),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('Bandpass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%high-pass
[frequency, magnitude] = makeSpectrum(outputFilter_high, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth); 
title('High-pass Filter (Frequency)', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter
% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);
audiowrite('Low-pass_380.wav', outputSignal, fs);
audiowrite('Bandpass_380_701.wav',outputSignal_pass, fs);
audiowrite('High-pass_701.wav',outputSignal_high,fs);
%%% Plot the spectrum of filtered signals
%low-pass
[frequency, magnitude] = makeSpectrum(outputSignal, fs);
figure(4);
subplot(2,2,1),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Low-pass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%bandpass
[frequency, magnitude] = makeSpectrum(outputSignal_pass, fs);
subplot(2,2,2),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Bandpass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%high-pass
[frequency, magnitude] = makeSpectrum(outputSignal_high, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('High-pass OutputSignal', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

%% 4, Reduce the sample rate of the three separated songs to 2kHz.
%low-pass
%[outputSignal_2kHz, outputFilter] = myFilter(y_input, fs, 1501,'Blackmann', 'low-pass', 380);
outputSignal_2kHz = resample(outputSignal,2000,fs);
%bandpass
%[outputSignal_pass_2kHz, outputFilter_pass] = myFilter(y_input, fs, 1501,'Blackmann', 'bandpass', [380 701]);
outputSignal_pass_2kHz = resample(outputSignal_pass,2000,fs);
%high-pass
%[outputSignal_high_2kHz, outputFilter_high] = myFilter(y_input, fs, 1501,'Blackmann', 'high-pass', 701);
outputSignal_high_2kHz = resample(outputSignal_high,2000,fs);


%% 4. Save the files after changing the sampling rate
audiowrite('Low-pass_380_2kHz.wav', outputSignal_2kHz, 2000);
audiowrite('Bandpass_380_701_2kHz.wav',outputSignal_pass_2kHz, 2000);
audiowrite('High-pass_701_2kHz.wav',outputSignal_high_2kHz,2000);


%% 5. one-fold echo and multiple-fold echo (slide #69)
% one-echo
V = length(outputSignal);
one_fold_out = outputSignal;
for n=3200:length(outputSignal)-1
    one_fold_out(n+1,1)=outputSignal(n+1,1)+0.8*outputSignal(n-3200+1,1);
end
% multiple-echo
multi_fold_out = outputSignal;
for n=3200:length(outputSignal)-1
    multi_fold_out(n+1,1)=outputSignal(n+1,1)+0.8*multi_fold_out(n-3200+1,1);
end

%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'
audiowrite('Echo_one.wav', one_fold_out, fs);
audiowrite('Echo_multiple.wav',multi_fold_out, fs);


