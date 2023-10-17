% let's open the file 
data = readmatrix("sep21/RigolDS0.csv");
tic
fs = 0.5e9;
signal = data(:,1) - mean(data(:,1));
% % 
% signal = [signal; signal];
% signal = [signal; signal];
% signal = [signal; signal];

N_data = size(signal,1);
t_array = linspace(0,(N_data-1)/fs,N_data);


% lets assume we actually have 40 MHz
fc = 40e6+134+0.15;

phi0 = 0.25*2*pi+1.05*pi;
driver = 0.28*sin(2*pi*fc*t_array+phi0);


figure(700)
clf
subplot(2,1,1)
hold on

plot(t_array,signal,'r')
plot(t_array,driver,'b--')

xlim(0.0+[0 1e-7])
hold off

subplot(2,1,2)
hold on
plot(t_array,signal,'r')
plot(t_array,driver,'b--')

xlim(0.019+[0 1e-7])
hold off

%%
figure(701)
sig_dr = signal'-driver;
sig_dr = abs(movmean(sig_dr,5000));
plot(t_array,sig_dr,'k')
%%

mult = exp(-1i*(2*pi*fc*t_array));

y = signal'.*mult;

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
figure(707)
deconstr_sig = (phase_s-phase_0);
% for i=1:length(deconstr_sig)
%     if deconstr_sig(i) > pi
%         deconstr_sig(i) = deconstr_sig(i) - pi;
%     elseif deconstr_sig(i) < -pi
%         deconstr_sig(i) = deconstr_sig(i) + pi;
%     end
% end
add_per_step = 0;
for i=1:length(deconstr_sig)-1
    if (deconstr_sig(i+1) - deconstr_sig(i)) > pi*0.9
        add_per_step = add_per_step - pi;
        deconstr_sig(i+1) = deconstr_sig(i+1) + add_per_step;
    elseif (deconstr_sig(i+1) - deconstr_sig(i)) < -pi*0.9
        add_per_step = add_per_step + pi;
        deconstr_sig(i+1) = deconstr_sig(i+1) + add_per_step;
    end
end
clf
hold on
plot(t_array,deconstr_sig,'b')

plot(t_array,movmean(deconstr_sig,1000),'r--')
hold off
toc
%%
% figure(708)
% pwelch(detrend(deconstr_sig))

%%
figure(709)
[px, fff] = pwelch(detrend(deconstr_sig(1:end)),[],[],[],fs);

plot(fff, log(px))

xlim([0 22e3])
% x1 = 1
