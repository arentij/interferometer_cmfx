k_wtf = 4;
data = data1(1:k_wtf:end,1:2);
fs = 500e6/k_wtf;
t = linspace(0,length(data)/fs,length(data));

%%
data_ac = data - movmean(data,125);
%%
figure(50)
clf; hold on
plot(t,data(:,1:2))
plot(t,data_ac(:,1:2),'--')
xlim([0 1e-6])

%%
rf_fft_co2 = fft(data_ac(:,2));

psd = abs(rf_fft_co2);

maximum = max(max(psd));
ind =find(psd==maximum)

figure(51)
plot(psd)
%%
f40 = ind(1)/length(data_ac(:,2))*fs

%%

% f40 = 40e6+137;
mult = exp(-1i*(2*pi*f40*t));

signal_co2 = data_ac(:,1);
driver_co2 = data_ac(:,2);

y = signal_co2'.*mult;
y_driver = driver_co2'.*mult;

[b, a] = butter(6,1*f40/(fs/2));
y_lowp = filtfilt(b,a,y);

y_dr_lp= filtfilt(b,a,y_driver);

ampl = 2*abs(y_lowp);


phase_s = angle(y_lowp);

phase_0 = angle(y_dr_lp);

%%
phase_co2_dcd = unwrap(phase_s-phase_0);

phase_co2_dcd = phase_co2_dcd - mean(phase_co2_dcd);

distance_co2_dcd = phase_co2_dcd/2/pi*10.6;
distance_co2_dcd_lp = movmean(distance_co2_dcd,500);  

figure(212)
clf
hold on
plot(t,distance_co2_dcd,'b')
plot(t,distance_co2_dcd_lp,'k--' )
ylim(0.5*[-1 1])
% plot(t,unwrap(phase_s),'r-')
% plot(t,unwrap(phase_0),'k-')
hold off
%%
figure(222)
clf
hold on
% plot(t,distance_co2_dcd,'b')
% plot(t,distance_co2_dcd_lp,'k--' )
% ylim(0.5*[-1 1])
plot(t,unwrap(phase_s),'r-')
plot(t,unwrap(phase_0),'k-')
hold off

%%
figure(213)
[px_co2, fff] = pwelch(detrend(distance_co2_dcd).*hanning(size(distance_co2_dcd,1),"periodic") ,[],[],[],fs);
log_px = log(px_co2)/log(10);
plot(fff, log_px,'k','LineWidth',2)

%%
figure(1040800010)

hold on
plot(t(1:10:end)-50e-3,distance_co2_dcd_lp(1:10:end),'r--', 'LineWidth',3)