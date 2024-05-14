% file_name = 'jan09/RigolDS8.csv';
% data = readmatrix(file_name);
%% this one is based on the phase difference calculation between the driver and the signal by FFT not by digital complex demodulation
dt_phase = 1e-6;    % resolution (window size)
ovlp = 0.5;        % overlap in %   (overlaps of the windows)

%%
% let's prep the folder
plt_name = file_name(1:6);  
mkdir([plt_name  'exp' num2str(exp_number)]);

%%
fs = 0.5e9;  % sampling rate
%
driver = data(:,2);
signal = data(:,1);

N_pts = size(driver,1);
% t_art = linspace(0,N_pts/fs,N_pts);
% t_art = t_art - t_art(end)/2;
%% rec_phase will reconstruct the phase shift array 
[rec_phase_arr,t_rec_phase] =  rec_phase(driver,signal,fs,dt_phase,ovlp);
[rec_phase_arr2, t_rec_phase2]=rec_phase_fft(driver,signal,fs,dt_phase,ovlp);
%%
figure(1000);
clf; hold on
plot(t_rec_phase,rec_phase_arr)
plot(t_rec_phase2,0.1+rec_phase_arr2)
%%


t_rec_phase = t_rec_phase - (t_rec_phase(end)-t_rec_phase(1))/2;

%
downsampling = 10;  % for plotting we downsample 10 times or so
rec_phase_arr_ds2 = unwrap(rec_phase_arr);   % let's get rid of the N*Pi shifts
rec_phase_arr_ds2 = movmean(rec_phase_arr_ds2,2*downsampling);  % and average over the downsampling windows
rec_phase_arr_ds2 = rec_phase_arr_ds2(1:downsampling:end); % actually removing extra points
t_arr_ds = movmean(t_rec_phase,2*downsampling);  % the same with the time array
t_arr_ds = t_arr_ds(1:downsampling:end);

phase_to_plot = rec_phase_arr_ds2-rec_phase_arr_ds2(1);
% phase_to_plot = detrend(phase_to_plot);
%% lowpassing

fs_lp = length(phase_to_plot)/(t_arr_ds(end)-t_arr_ds(1));

[b, a] = butter(4,100/(fs_lp/2));

phase_lowpassed = filtfilt(b,a,phase_to_plot);
%% here comes the plotting
figure(plot_index+17)
clf

hold on


plot(t_arr_ds,phase_to_plot,'r','LineWidth',2.0)

set(gca,'FontSize',20,'LineWidth',1)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$Theta, rad$','Interpreter','latex','FontSize',35);
title(['$Reconstructed ~phase ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
box on
%
% lets add a lowpassed signal
% plot(t_arr_ds,phase_to_plot-phase_lowpassed,'k--','LineWidth',.5)
plot(t_arr_ds,phase_lowpassed,'b','LineWidth',3.0)
saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_phase.fig'])
%
% acc_plt;