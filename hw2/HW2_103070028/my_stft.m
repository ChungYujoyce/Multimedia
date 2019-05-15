function [S, F, T] = my_stft(x, segment_duration, segment_overlap, samplerate)
% my_stft:
% input
% x: The target signal.
% segment_duration: The number of samples of each segment.
% segment_overlap: The number of samples overlapping on two adjacent segments.
%
% output
% S: Short-time Fourier transform, returned as a matrix. Time increases across the columns of S and frequency increases down the rows, starting from zero.
% F: Cyclical frequencies, returned as a vector. F has a length equal to the number of rows of S.
% T: Time instants, returned as a vector. The time values in T correspond to the midpoint of each segment.

%% Your implementation
w = zeros(segment_duration,1);
m=segment_duration;
%m = ((length(x)-segment_duration)/segment_overlap)+1;
s_r = ceil((1+m)/2);
s_c = 1+fix((length(x)-length(w))/(segment_duration-segment_overlap));
S = zeros(s_r,s_c);
f = zeros(s_r);
%slice the signal into segments
count=1;
for i=0:segment_duration-segment_overlap:length(x)-segment_overlap-1
    if(i==0)
        w=x(i+1:i+segment_duration);
    else
        w=x(i+1:i+segment_duration);
    end
    %Hanning windowing function
    for j=0:segment_duration-1
        w(j+1)=w(j+1)*(0.5+0.5*cos(2*pi*j)/segment_duration);
    end
    %FFT
    f=fft(w, m);
    S(:, count) = f(1:s_r);
    count=count+1;
end
F = (0:s_r-1)*samplerate/m;
T = (length(w)/2:segment_duration-segment_overlap:length(w)/2+(s_c-1)*(segment_duration-segment_overlap))/samplerate;