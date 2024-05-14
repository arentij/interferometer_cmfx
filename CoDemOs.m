% let's open the file 
% data1 = readmatrix("sep22/RigolDS6.csv");

tic
fs = 0.5e9;
% if file_name == 'sep26/RigolDS6.csv'
%     fs= 1e9;
% end

plt_name = file_name(1:6);  
mkdir([plt_name  'exp' num2str(exp_number)]);


signal = data(:,1) - mean(data(:,1));
approx_ampl = 2^0.5*std(signal(1:100000));

N_data = size(signal,1);
t_array = linspace(0,(N_data-1)/fs,N_data);

% lets assume we actually have 40 MHz
fc = 40e6+134-0.35;
fc = 4.000012753908549e+07;
fc= 4.000012951901465e+07;
fc = 4.000012989240881e07;
fc = 4.00001284864e+07;
fc = 4.000013179300075e7;
fc = 4.000012974902647e7;
fc = 4.000014175033212e7;
fc = 4e7+137.3328;
fc = 4e7+147.3328;

% 128.4864
phi0 = 0.25*2*pi+1.05*pi;
phi0 = 6.05;


%%
debiassed_signal = signal - movmean(signal,40);
ampl_reconst = 2^0.5*movstd(debiassed_signal,15000);
normalized_signal = signal./ampl_reconst*approx_ampl;
normalized_signal = normalized_signal - movmean(normalized_signal,15000);
% figure(plot_index+10)
% clf
% hold on
% plot(t_array,  signal,'r')
% plot(t_array,normalized_signal,'k')
% plot(t_array, ampl_reconst,'b')
% 
% hold off
%%
% figure(plot_index+10)
% time_t_plt = 1+[1:fix(100*fs/fc)];
% 
% clf
% hold on
% plot(t_array(time_t_plt),normalized_signal(time_t_plt));
% plot(t_array(time_t_plt),signal(time_t_plt))
% legend()
% hold off
%

dl_fit = 500e-6;

f_found = false;

% [px, fff] = pwelch((data0(:,2)),[],[],[],fs);
% b1_2 = fff(find(px==max(px)));
% fc = b1_2;

if true
    for fit_try = 1:1
    if fit_try > 1
        if err < 0.4 
            fc = b1;
            phi0 = c1;
        end
    end
    
    ['trying fit N'  num2str(fit_try)]

    N_d = length(t_array);
    k00 = fix(rand()*N_d);
    k01 = fix(rand()*N_d);
    k02 = fix(rand()*N_d);
    k03 = fix(rand()*N_d);
    k0m = fix((5^.5-1)/2*N_d);
    dt_ar = [1:fix(dl_fit*fs),k01:k01+fix(dl_fit*fs),k03:k03+fix(dl_fit*fs),k02:k02+fix(dl_fit*fs),N_d - fix(dl_fit*fs):N_d];
    dt_ar = [1:fix(dl_fit*fs),k0m:k0m+fix(dl_fit*fs),N_d - fix(dl_fit*fs):N_d];
    
    
    dN = fix(dl_fit*fs);
    Ni_chunks0 = [1,  N_d-dN];
%     Ni_chunks0 = [1, k0m, k01-dN, N_d-dN];
    Ni_chunks0 = [1, k0m, k01-dN, N_d-dN];
    Ni_chunks0 = [1, k0m, k01-dN];

    Ni_chunks0 = sort(Ni_chunks0);
    Ni_chunks1 = dN + Ni_chunks0;
    
    time_to_fit = [];
    signal_to_fit = [];
    
    for i_chunk = 1:length(Ni_chunks0)
        dN_arr = [Ni_chunks0(i_chunk):Ni_chunks1(i_chunk)];
        time_to_fit = [time_to_fit, t_array(dN_arr)];
        current_signal = signal(dN_arr);

%         current_signal = data0(dN_arr,2);

        current_signal = current_signal-mean(current_signal);
        current_signal = current_signal/2^0.5/std(current_signal)*approx_ampl;
        signal_to_fit = [signal_to_fit; current_signal];
    end
    % 
    
    
    mdl = fittype('a*sin(2*pi*(b)*t+c)','indep','t');
    fittedmdl2 = fit(time_to_fit',signal_to_fit,mdl,'start',[approx_ampl fc phi0]);
    
    a1 = fittedmdl2.a;
    b1 = fittedmdl2.b;
    c1 = fittedmdl2.c;
    %
    
    % driver = 0.28*sin(2*pi*fc*t_array+phi0);
    
    driver = a1*sin(2*pi*b1*t_array+c1);
    
    
    sig_dr = abs(debiassed_signal'-driver);
    sig_dr = (movmean(sig_dr,200));
    err = rms(sig_dr)/approx_ampl
    if err < 0.2 
        'we got the frequency'
        f_found = true;
        break
    else 
        continue
    end
    %
end
end
if ~f_found 
    warning('The frequency is not that good fit, I will use detrend in the end')
end
driver = data0(:,2)';
driver = driver - movmean(driver,200);

% fixing 250000 scope problem
for i_dr_p = 1: length(driver)-1
    if mod(i_dr_p,250000) == 0
        driver(i_dr_p) = (driver(i_dr_p-1) + driver(i_dr_p-1))/2;
    end

end
figure(plot_index)

clf

for i_plt = 1:length(Ni_chunks0)
    subplot(length(Ni_chunks0),1,i_plt)
    dN_arr = [Ni_chunks0(i_plt):Ni_chunks1(i_plt)];    
    plot(time_to_fit,signal_to_fit,'r','LineWidth',2.0);
    hold on
    plot(t_array(dN_arr),driver(dN_arr),'b--','LineWidth',2.0);
    xlim(t_array(Ni_chunks0(i_plt))+ [0 2e-7])

end
title(['Fitting 40 MHz ', num2str(plot_index); string(datetime)])
subplot(length(Ni_chunks0),1,i_plt)
% title('Original 40 MHz and the fit')
xlabel('t, s')
ylabel('U, V')
hold off

saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_fitting2driver.fig'])


%
figure(plot_index+1)

plot(t_array(1:100:end),sig_dr(1:100:end)/abs(a1),'k')
title(['signal minus driver over amplitude, err = ' num2str(round(err,2)) ', ' num2str(plot_index);  string(datetime)])
xlabel('t, s')
ylabel('U, V')
% title(string(datetime))
%
saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_signal-driver.fig'])

%%

mult = exp(-1i*(2*pi*b1*t_array));

y = signal'.*mult;

% maaaybe?
y = debiassed_signal'.*mult;

% if there is a driver data
% driver = data0(:,2)';
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
figure(plot_index+17)
% title()
clf
xlabel('t, s')
ylabel('Theta, rad')
deconstr_sig = (phase_s-phase_0);

fix_param = 1;
deconstr_sig = 1/fix_param*unwrap(deconstr_sig*fix_param);

deconstr_sig2 = movmean((deconstr_sig),12);
deconstr_sig2 = deconstr_sig2(1:12:end);

current_file_index = 1+ str2num(file_name(14:end-4));
all_day_data_array{current_file_index,1} = deconstr_sig;
all_day_data_array{current_file_index,2} = plot_index;

% int_data{end+1,1} = plot_index;
% int_data{end,2} = deconstr_sig2;

hold on
% plot(t_array,deconstr_sig,'b')

lp_flt_phase = movmean((deconstr_sig),500);
ds_k = 150;
if true
    plot(t_array(1:ds_k:end),lp_flt_phase(1:ds_k:end)-lp_flt_phase(1),'r','LineWidth',2.0)
else
    plot(t_array(1:ds_k:end),detrend(lp_flt_phase(1:ds_k:end)),'r','LineWidth',2.0)
end
%
ds_koeff = 150;
sig_ds = lp_flt_phase(1:ds_koeff:end);
sig_ds_bp = bandpass(sig_ds,380+300*[-1 1],fs/ds_koeff);

plot(t_array(1:ds_koeff:end),sig_ds_bp,'k-','LineWidth',2.0)

% plot(t_array(1:ds_koeff:end),lp_flt_phase(1:ds_koeff:end) - sig_ds_bp,'b','LineWidth',2.0)

%
hold off
% title(string(datetime))
xlabel('t, s');
ylabel('Theta, rad');
title(['Reconstructed phase ', num2str(plot_index); string(datetime) ] )
legend(['Sig0';'S_BP';'S_su'])
%

saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_phase.fig'])
%
%  xlim([0.0272115 0.0272116])

%%
figure(plot_index+9)

% [px, fff] = pwelch(detrend(deconstr_sig(1:end)),[],[],[],fs);

% log_px = log(px)/log(10);
%
% fft_plt_arr = [1:fix(length(fff)/100)];

% semilogx(fff(fft_plt_arr), log_px(fft_plt_arr),'LineWidth',2)
% %%
% figure(1)
% hold on
% plot(fff(fft_plt_arr), log_px(fft_plt_arr),'r--','LineWidth',2)
% xlim([0 2e5])
% hold off
%
title(['Power spectra of the phase ', num2str(plot_index); string(datetime)])
xlabel('f, Hz')
ylabel('PSD, DB')

% xlim([0 2.2e3])
saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_FFT.fig'])

% x1 = 1
%%
% figure(3)
% hold on
% semilogx(fff(fft_plt_arr), log_px(fft_plt_arr),'r','LineWidth',1.5)

%%
% figure(100)
% hold on
% plot(fff(fft_plt_arr), log_px(fft_plt_arr),'LineWidth',2)
% 
% title(['Power spectra of the phase ', num2str(plot_index); string(datetime)])
% xlabel('f, Hz')
% ylabel('PSD, DB')
% 
% xlim([0 2.2e3])
% %
% saveas(gcf,[plt_name  'exp sep 29: 9 10 11 3 6 1_FFT.fig'])
%%

% figure(plot_index + 11)
% clf
% sub_sig = debiassed_signal(1:fix(end/10));
% 
% delay_n = 25;
% plot(sub_sig(1:end-delay_n),sub_sig(1+delay_n:end))
figure(plot_index+18)
clf
hold on
dt_filt = 10e-3;
step_k= 1000;
dN_filt = step_k*fix(dt_filt*fs/step_k);

lp_flt_phase_lp_filt = movmean((deconstr_sig),dN_filt);

plot(t_array(1:dN_filt/step_k:end),deconstr_sig(1:dN_filt/step_k:end) - lp_flt_phase_lp_filt(1:dN_filt/step_k:end),'b--','LineWidth',1)
plot(t_array(1:dN_filt/step_k:end),lp_flt_phase_lp_filt(1:dN_filt/step_k:end)-lp_flt_phase_lp_filt(1),'r','LineWidth',2.0)

title(['Lowpassing over ' num2str(dt_filt) 's'])
legend({'highpassed','lowpassed'},'FontSize',15)
%
% 
% [b1, a1] = butter(6,20/(fs/2),'high');
% y_high_p = filtfilt(b1,a1,lp_flt_phase_lp_filt);
% plot(t_array(1:dN_filt/step_k:end),y_high_p(1:dN_filt/step_k:end)-y_high_p(1),'b','LineWidth',2.0)
hold off


%%
% figure(plot_index+20)
% clf
% hold on
% % dt_filt = 10e-3;
% % step_k= 1000;
% % dN_filt = step_k*fix(dt_filt*fs/step_k);
% 
% % lp_flt_phase_lp_filt;
% 
% % plot(t_array(1:500:end),lp_flt_phase(1:500:end)-lp_flt_phase(1),'r','LineWidth',2.0)
% 
% title(['signal - lowpassed signal' num2str(dt_filt) 's'])
% %

%%
toc