function [phase_d] = phase_diff_fft(signal, driver)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    fs = 50e6;
    dt = size(driver,1)/fs;
    plotting = 0;
    t_arr = linspace(0,dt,fix(dt*fs));
%     fc = 40e6+137 + 10*randn();
%     dph = pi/4;
%     
%     signal = sin(2*pi*fc*t_arr+dph);
%     driver = sin(2*pi*fc*t_arr);
%     noise_lvl = 0.1;
%     signal = signal + noise_lvl * randn(size(signal));
%     driver = driver + noise_lvl * randn(size(driver));
%     
    signal = signal(:);
    signal = signal - mean(signal);
    driver = driver(:);
    driver = driver - mean(driver); 
    
    signal = (0.21 + rand())* signal;
    driver = (0.21 + 2*rand())* driver;
    if plotting
        figure(200)
        clf; hold on
        plot(t_arr,signal,'LineWidth',2)
        plot(t_arr,driver,'LineWidth',2)
    end
    sig_win = hanning(length(signal), 'periodic');
    driv_win = hanning(length(driver), 'periodic');
    
    
%     figure(201)
%     clf
%     hold on
%     plot(t_arr,sig_win)
%     plot(t_arr,driv_win)
    
    % perform fft on the signals
    sig_fft = fft(signal); 
    driv_fft = fft(driver);
    
    sig_fft = fft(signal.*sig_win); 
    driv_fft = fft(driver.*driv_win);
    
    
    % figure(202)
    % clf
    % hold on
%     plot(t_arr,signal.*sig_win)
%     plot(t_arr,driver.*driv_win)
    
    f_arr = linspace(0,fs,length(sig_fft));
    if plotting
        figure(203)
        clf; hold on
        plot(f_arr,(abs(sig_fft)))
        plot(f_arr,(abs(driv_fft)))
    end
%     
%     figure(204)
%     clf; hold on
%     plot(f_arr,angle(sig_fft))
%     plot(f_arr,angle(driv_fft))
    
    % fundamental frequency detection
    [~, ind_max_sig] = max(abs(sig_fft));
    [~, ind_max_driv] = max(abs(driv_fft));
    
    % phase difference estimation
    % aver_win = 0;
    % fft_ampl_av_arr = abs(sig_fft(ind_max_sig-aver_win:ind_max_sig+aver_win));
    % 
    % fft_angl_av_arr = angle(sig_fft(ind_max_sig-aver_win:ind_max_sig+aver_win));
    % fft_angl_av_arr = mod(fft_angl_av_arr + pi, pi);
    % 
    % av_phase = sum(fft_ampl_av_arr.*fft_angl_av_arr)/sum(fft_ampl_av_arr);
    
    
    
    PhDiff = angle(sig_fft(ind_max_driv)) -angle(driv_fft(ind_max_driv)) ;
    
    phdiff_arr = angle(sig_fft) -angle(driv_fft) ;
    
    if plotting

        figure(205)
        clf; hold on
        plot(f_arr,mod(phdiff_arr+pi,2*pi)-pi)
    %     line([0 f_arr(end)],[dph dph],'color','r')
    %     line([0 f_arr(end)],-[dph dph],'color','r')
        % xlim( indx + [-3 3])
        xlim([f_arr(ind_max_sig -3) f_arr(ind_max_sig+3)])
    end
    
    % restrict the phase difference in the range [-pi, pi]
    phase_d = mod(PhDiff + pi, 2*pi) - pi;
    
%     abs(1 - abs(dph / PhDiff))
end