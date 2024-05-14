function [t,phase_s,phase_0,f_c] = dicodem(driver,signal,fs)
%DICODEM returns phase difference between two signals based on Digital
%COmplex Demodulation algoritm 
%   Detailed explanation goes here
plotting = 0;
t = linspace(0,length(driver)/fs,length(driver));
t = t - t(fix(end/2));

% first lets remove DC and in general low frequency signal
% the simplest way is to remove movmean 
box_av = 125; % if we have 12.5 points per oscillation (40 MHz signal by 500 MHz sampling)
signal = signal - movmean(signal,box_av);
driver = driver - movmean(driver,box_av);

% now lets define the driver frequency with FFT so it is kinda okay
% rf_fft = fft(driver);
% psd_driver = abs(rf_fft);
% max_psd = max(max(psd_driver));
% ind =find(psd_driver==max_psd);
% 
% 
% 
% f_c = ind(1)/length(driver)*fs;

f_c = detect_freq(driver,fs);

if plotting 
    figure(80)
    clf
    hold on
    plot(log(psd_driver))
    
end

% now lets do the DCD 
mult = exp(-1i*(2*pi*f_c*t));

y = signal'.*mult;
y_driver = driver'.*mult;

[b, a] = butter(6,1*f_c/(fs/2));  % here is the low pass filter for carrier frequency - we need to remove the 2 nd harmonics etc

y_lowp = filtfilt(b,a,y);
y_dr_lp= filtfilt(b,a,y_driver);

% ampl = 2*abs(y_lowp);
phase_s = angle(y_lowp);  % that's the phase of the signal relative to the assumed driver
phase_0 = angle(y_dr_lp); % and this is the phase of the driver relative to the assumed driver

% phase = unwrap(phase_s-phase_0);
% phase = phase - mean(phase);


end

