function [f_main] = detect_freq(data,fs)
%DETECT_FREQ Summary of this function goes here
%   Detailed explanation goes here
data = data(:);
plotting = 0;

data_fft = fft(data.*hanning(size(data,1)));
psd_data = abs(data_fft);
max_psd = max(max(psd_data));
ind_max =find(psd_data==max_psd);

gap = 1;

window_ind = [ind_max(1)-gap:ind_max(1)+gap];


av_ind = -1+ mean(window_ind'.*psd_data(window_ind))/(mean(psd_data(window_ind)));
dind = ind_max(1) - av_ind;

if plotting 
    figure(81)
    clf
    hold on
    plot(log(psd_data))
    xlim([(ind_max(1)-5) (ind_max(1) + 5)])
    

    figure(91)
    plot(window_ind/length(data)*fs-40e6,psd_data(window_ind))
end


f_main = av_ind/length(data)*fs;
end

