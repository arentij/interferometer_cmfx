% % fs = 0.5e9;
% % dt = 100e-3;
% % t = linspace(0,dt,fix(dt*fs));
% % 
% % fc = 40e6;
% % 
% % f_acoust = 5e3;
% % amplitude = 2 + sin(2*pi*f_acoust*t);
% % 
% % signal = sin(2*pi*fc*t+1).*amplitude+0.4*randn(size(t));
% % %%
% % figure(1000)
% % clf
% % hold on
% % plot(t,signal)
% % 
% % hold off
% % xlim([0 20/f_acoust])
% % 
% % %%
% % 
% % ampl_reconst = 2^0.5*movstd(signal,5000);
% % 
% % figure(1001)
% % clf
% % hold on
% % plot(t, amplitude)
% % plot(t,ampl_reconst)
% % 
% % xlim([0 20/f_acoust])
% % 
% fs = 5e8;
% 
% N_data2 = fs*0.005;
% t_a1  = linspace(0,(N_data2-1)/fs,N_data2);
% 
% f1 = 440;
% f2 = 40e6;
% art_sig = sin(2*pi*f1*t_a1)+ 0.2*sin(2*pi*f2*t_a1)+ 0.0002*randn(size(t_a1));
% 
% 
% [b, a] = butter(8,[0.9 1.1]*f2/(fs/2),"stop");
% y_lowp = filtfilt(b,a,art_sig);
% 
% 
% figure(900)
% clf
% hold on
% plot(t_a1,art_sig,'r--')
% plot(t_a1,y_lowp,'b')
% % plot(t_a1,art_hp)
% hold off
% 
% %%
% % freqz()
% % fc = 300;
% % fs = 1000;
% % 
% % [b,a] = butter(6,fc/(fs/2));
% % 
% % freqz(b,a,[],fs)
% % 
% % subplot(2,1,1)
% % ylim([-100 20])
% 
% %%
% 
% 
% figure(99)
% 
% t_a2 = linspace(0,200e-3,200e-3*fs/100);
% phi_art_0 = 7*pi/6;
% f1 = 94.6;
% art_sig = 0.013+ 0.023*sin(2*pi*t_a2*f1+ phi_art_0)+0.015*sin(2*pi*t_a2*3*f1+ 1*phi_art_0);
% plot(t_a2,art_sig)
% 
% L = findobj(100901017,'type','line');
% copyobj(L,findobj(99,'type','axes'))


int_data = {};
