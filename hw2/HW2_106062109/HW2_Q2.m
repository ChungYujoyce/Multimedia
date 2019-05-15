%%% HW2_Q2.m - bit reduction -> audio dithering -> noise shaping -> low-pass filter -> audio limiting -> normalization
%%% Follow the instructions (hints) and you can finish the homework

%% Clean variables and screen
clear all;close all;clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
[y, fs] = audioread('Tempest.wav');

%%% Plot the spectrum of input audio

[frequency, magnitude] = makeSpectrum(y, fs);
figure(1)
subplot(2,2,1),plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
axis([0 2000 0 30000]);
%%% Plot the shape of input audio
length(y)
whos y;
whos fs;
TotalTime = length(y)./fs;
t = 0:TotalTime/(length(y)):TotalTime-TotalTime/length(y);
subplot(2,2,2),plot(t,y)
title('Input audio shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

%% 2. Bit reduction
% (Hint) The input audio signal is double (-1 ~ 1) 

y_8bit = y*128 + 128;
%max(y_8bit)
%%% Save audio (audiowrite) Tempest_8bit.wav
% (Hint) remember to save the file with bit rate = 8
audiowrite('Tempest_8bit.wav', uint8(y_8bit), fs, 'BitsPerSample',8); %!!!!!!
%% 3. Audio dithering
% (Hint) add random noise
noise = rand(size(y_8bit));
y_noise = y_8bit + noise*128;
%uint8(y_noise)
%audiowrite('Tempest_no.wav', uint8(y_noise), fs);
%%% Plot the spectrum of the dithered result

[frequency, magnitude] = makeSpectrum(floor(y_noise)/255, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Dithered spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
axis([0 2000 0 5000]);
%}
%--shape

length(y_noise)
whos y;
whos fs;
TotalTime = length(y_noise)./fs;
t = 0:TotalTime/(length(y_noise)):TotalTime-TotalTime/length(y_noise);
subplot(2,2,4),plot(t,floor(y_noise)/255)
title('Dithered shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
%}
%% 4. First-order feedback loop for Noise shaping
% (Hint) Check the signal value. How do I quantize the dithered signal? maybe scale up first?
[input, fs] = audioread('Tempest.wav');
original_audio = (input + 1) * 128;
feedback = original_audio;
getsize = size(original_audio(:,1));
c = 1;
for j=1:2
    Error = 0;
    for i=1:getsize(1)
        X = rand* 128;
        feedback(i,j) = feedback(i,j) + X + c*Error;
        Error = original_audio(i,j) - round(feedback(i,j));
        %round(feedback(i,j));
    end
end
%audiowrite('Tempest_shap.wav', uint8(F_out), fs, 'BitsPerSample',8);

%%% Plot the spectrum of noise shaping

[frequency, magnitude] = makeSpectrum(round(feedback)/128-1, fs);
figure(2)
subplot(2,2,1),plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Noise shaping spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
axis([0 2000 0 5000]);
%--shape
length(y)
whos y;
whos fs;
TotalTime = length(y)./fs;
t = 0:TotalTime/(length(y)):TotalTime-TotalTime/length(y);
subplot(2,2,2),plot(t,y)
title('Noise shaping shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

%% 5. Implement Low-pass filter
[y_output, outputFilter] = myFilter(round(feedback)/128-1, fs, 2000,'Blackmann', 'low-pass', 1500);
%audiowrite('Tempest_low.wav', y_output, fs);

%% 6. Audio limiting
thresh = 0.8;
for n=0:size(y_output)-1
    if y_output(n+1,1) > thresh
        y_output(n+1,1) = thresh;
    elseif y_output(n+1,1) < -thresh
        y_output(n+1,1) = - thresh;
    else
        y_output(n+1,1) = y_output(n+1,1);
    end
end
%% 7. Normalization
norm = 1/thresh;
for n=0:size(y_output)-1
    y_output(n+1,1) = y_output(n+1,1)*norm;
end

%% 6. Save audio (audiowrite) Tempest_Recover.wav
audiowrite('Tempest_Recover.wav', y_output, fs);

%%% Plot the spectrum of output audio

[frequency, magnitude] = makeSpectrum(y_output, fs);
subplot(2,2,3),plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('result of dithering & noise spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
axis([0 2000 0 30000]);
%%% Plot the shape of output audio
length(y_output)
whos y;
whos fs;
TotalTime = length(y_output)./fs;
t = 0:TotalTime/(length(y_output)):TotalTime-TotalTime/length(y_output);
subplot(2,2,4),plot(t,y_output-0.35)
title('result of dithering & noise shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

