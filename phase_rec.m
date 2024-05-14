%% this one is based on the phase difference calculation between the driver and the signal by FFT not by digital complex demodulation 
dt_phase = 10e-6;    % resolution (window size)
ovlp = 0.5;        % overlap in %   (overlaps of the windows)

%%
% let's prep the folder
plt_name = file_name(1:6);  
mkdir([plt_name  'exp' num2str(exp_number)]);

%%
% fs = 0.5e9;  % sampling rate
%
driver = data(1:end,2);
signal = data(1:end,1);

N_pts = size(driver,1);
% t_art = linspace(0,N_pts/fs,N_pts);
% t_art = t_art - t_art(end)/2;
%% rec_phase will reconstruct the phase shift array 
[rec_phase_arr,t_rec_phase] =  rec_phase_fft(driver,signal,fs,dt_phase,ovlp);
t_rec_phase = t_rec_phase - (t_rec_phase(end)-t_rec_phase(1))/2;
%%
% figure(1000)
% 
% if clear_figs
%     clf
% end
% hold on
% plot(driver(1:1000:end))
% plot(signal(1:1000:end))

figure(1001)

if clear_figs
    clf
end
hold on
fs_rec = size(rec_phase_arr,1)/(t_rec_phase(end)-t_rec_phase(1));
[px, fff] = pwelch(detrend(rec_phase_arr).*hanning(size(rec_phase_arr,1),"periodic") ,[],[],[],fs_rec);
% [px2, fff] = pwelch(rec_phase_arr ,[],[],[],fs_rec);

log_px = log(px)/log(10);
% log_px2 = log(px2)/log(10);
plot(fff, log_px,'LineWidth',2)
% plot(fff, log_px2,'LineWidth',2,'Color','red')
xlim([0 2e3])

%%
downsampling = 50;  % for plotting we downsample N times or so
rec_phase_arr_ds2 = unwrap(2*rec_phase_arr)/2;   % let's get rid of the N*Pi shifts
rec_phase_arr_ds2 = movmean(rec_phase_arr_ds2,2*downsampling);  % and average over the downsampling windows
rec_phase_arr_ds2 = rec_phase_arr_ds2(1:downsampling:end); % actually removing extra points
t_arr_ds = movmean(t_rec_phase,2*downsampling);  % the same with the time array
t_arr_ds = t_arr_ds(1:downsampling:end);

phase_to_plot = rec_phase_arr_ds2-rec_phase_arr_ds2(1);
%% lowpassing

fs_lp = length(phase_to_plot)/(t_arr_ds(end)-t_arr_ds(1));

[b, a] = butter(4,100/(fs_lp/2));

phase_lowpassed = filtfilt(b,a,phase_to_plot);
%% here comes the plotting
figure(plot_index+17)

if clear_figs
    clf
end

hold on



set(gca,'FontSize',20,'LineWidth',2)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$Theta, rad$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Reconstructed ~phase ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
box on
%
% lets add a lowpassed signal
% plot(t_arr_ds,phase_to_plot-phase_lowpassed,'k--','LineWidth',.5)
rad2nm = 1; %1/2/pi*10.6e3;
plot(t_arr_ds,-rad2nm*phase_switch*(phase_to_plot-phase_to_plot(fix(end/2))),'LineWidth',2.0)
plot(t_arr_ds,-rad2nm*phase_switch*(phase_lowpassed-phase_to_plot(fix(end/2))),'LineWidth',3.0)

% yyaxis right
% plot(t_arr_ds,phase_switch*(phase_to_plot-phase_to_plot(fix(end/2))),'LineWidth',2.0)

% kappa = 24; % um/m/K


saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_phase.fig'])
%
% acc_plt;
%%
save([plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_rec_phase.mat'],'t_rec_phase','rec_phase_arr');
