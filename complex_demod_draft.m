fc = 40e6+rand()*40e6*1e-2;
fs = 0.5e9;

f_phi = 1e3;

t_lenght = 0.004;
t = (0:1/fs:t_lenght)';


phi = 4*pi/20*(sin(2*pi*f_phi*t)+1.1+1e-2*randn(size(t)));

ramp_l = 0.6e-3;

phi(1:fix(ramp_l*fs)) = zeros(1,fix(ramp_l*fs));
phi(fix(ramp_l*fs):3*fix(ramp_l*fs)) = phi(fix(ramp_l*fs):3*fix(ramp_l*fs))'.*linspace(0,1,2*fix(ramp_l*fs)+1);

phase_add = 2*pi*rand();

observed = 1*sin(2*pi*fc*t + phase_add + phi);

observed = 0.2+ observed + 1e-1*randn(size(observed));

driver = 1*sin(2*pi*fc*t + phase_add);

% figure(211)
% clf
% hold on
% plot(t,observed)
% hold off

%%
mult = exp(-1i*(2*pi*fc*t));

y = observed.*mult;

y_driver = driver.*mult;
% y_lowp = lowpass(y,fc*1.5,fs);


[b, a] = butter(6,1*fc/(fs/2));
y_lowp = filtfilt(b,a,y);

y_dr_lp= filtfilt(b,a,y_driver);

ampl = 2*abs(y_lowp);

% phase_s = atan2(imag(y_lowp)./real(y_lowp),pi/2);
phase_s = angle(y_lowp);
% phase_s = mod(phase_s+pi,pi/4);
phase_0 = angle(y_dr_lp);
% phase_0 = mean(phase_s(1:1000));
%%
figure(213)
plot(t,ampl)
%%

figure(212)
clf
hold on
plot(t,phase_s-phase_0,'b')
plot(t,phi,'r-')
plot(t,phase_0,'k-')
hold off

