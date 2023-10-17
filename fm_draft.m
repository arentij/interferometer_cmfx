% y = fmmod(x,Fc,Fs,freqdev) returns a frequency modulated (FM) 
% signal y, given the input message signal x, 
% where the carrier signal has frequency Fc and 
% sampling rate Fs. 
% freqdev is the frequency deviation of the modulated signal.


fs = 200e6;
fc = 40e6;
t = (0:1/fs:0.05)';

x = 3*sin(2*pi*10e3*t) + sin(2*pi*7.3e2*t);

x1 = x + randn(size(x))*1e-3;

fDev = 1e4;

y = fmmod(x,fc,fs,fDev);

y1 = y + randn(size(y))*1e-3;

z = fmdemod(y1,fc,fs,fDev);
%%
figure(210)
clf 
hold on
plot(t,z,'b--');
plot(t,x,'c');
xlabel('t, s')
ylabel('U, V')
xlim([t(100) t(end-100) ])

% dL = 0.01;
% s_rate = 1e-9;
% t_array = linspace(0,dL,fix(dL/s_rate));
% 
% w1 = 1e3;
% noise_db = -2;
% x = sin(2*pi*w1*t_array)+10^noise_db*randn(size(t_array));
% 
% Fc = 40e6;
% Fs = s_rate;
% freqdev = 1e6;
% 
% %
% y = fmmod(x,Fc,Fs,freqdev);
% 
% figure(55)
% clf
% plot(t_array,x,'c',t_array      ,y,'b--')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('Original Signal','Modulated Signal')




