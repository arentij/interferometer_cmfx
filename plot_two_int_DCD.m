% if ~exist('rec_phase_arr_c','var')
%     
% %     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/mar27/exp4/exp4_rec_phase.mat';
% %     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/apr01/exp1/exp1_rec_phase.mat';
%     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/apr04/exp1/exp1_rec_phase.mat';
%     load(exp_f_name);
%     idx = regexp(exp_f_name,'exp','once');
%     plot_index = str2num(exp_f_name(idx+3));
% end
%
%%
lambda_co2 =  10.5;
lambda_red = -0.639;
unwrp_p = pi;
phase_co2 = unwrap(phase_s_co2,unwrp_p)-unwrap(phase_0_co2,unwrp_p);
distance_co2 = (phase_co2/2/pi*lambda_co2);

phase_red = unwrap(phase_s_red,unwrp_p)-unwrap(phase_0_red,unwrp_p);
distance_red = (phase_red/2/pi*lambda_red);
% removing very high freq
dt_av = 10e-6;
dt_av_steps = max(1,fix(dt_av*fs));
%
distance_co2_lp = movmean(distance_co2,dt_av_steps);
distance_red_lp = movmean(distance_red,dt_av_steps);

first_part_match = 4;
distance_co2_lp = distance_co2_lp - mean(distance_co2_lp(1:fix(end/first_part_match)));
distance_red_lp = distance_red_lp - mean(distance_red_lp(1:fix(end/first_part_match)));
%%
linew = 3;
plot_ds = 500;
figure(200 + 1000*downsampling)
clf
hold on
set(gca,'FontSize',20,'LineWidth',linew)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Reconstructed ~distance;~~LP~over ~$',num2str(dt_av*1e6) ,'$~\mu s; ~DS=~$',num2str(plot_ds) ;'$Ind=$', num2str(0), '$;~F_s=$' ,num2str(fs/1e6),'$MHz$'; string(datetime) ],'Interpreter','latex','FontSize',35); 
box on

plot(t_co2(10:plot_ds:end-10),distance_co2_lp(10:plot_ds:end-10),'k','LineWidth',linew)
plot(t_red(10:plot_ds:end-10),distance_red_lp(10:plot_ds:end-10),'r--','LineWidth',linew)

legend({'CO2','Red'})
%%
figure(300 + 1000*downsampling)
clf
hold on
set(gca,'FontSize',20,'LineWidth',linew)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
distance_diff = distance_co2_lp-distance_red_lp;
err = rms(distance_diff);
title(['$nL~Difference;~LP~over ~$',num2str(dt_av*1e6) ,'$~\mu s; ~DS=~$',num2str(plot_ds) ;'$Ind=$', num2str(0), '$;~F_s=$' ,num2str(fs/1e6),'$MHz;~ Err=$' , num2str(fix(err*1000)); string(datetime) ],'Interpreter','latex','FontSize',35); 
box on


%
dt_av_err = 7e-3;
dt_av_steps_err = max(1,fix(dt_av_err*fs));

diff_rms_array = movmean(distance_diff.^2,dt_av_steps_err).^0.5;
%


% plot(t_co2(10:plot_ds:end-10),distance_diff(10:plot_ds:end-10),'b','LineWidth',linew)
plot(t_co2(10:plot_ds:end-10),diff_rms_array(10:plot_ds:end-10),'r--','linewidth', linew    )
% plot(,'r--','LineWidth',linew)
legend({'Interferometers difference'},'Location','northwest')


%%

% figure(plot_index+10)
% clf
% hold on
% 
% set(gca,'FontSize',20,'LineWidth',linew)
% 
% xlabel('$t, s$','Interpreter','latex','FontSize',35);
% ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% % ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
% title(['$Reconstructed ~distance ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
% box on
% 
% plot(t_rec_phase_c,distance_co2,'k','LineWidth',linew)
% plot(t_rec_phase_r,distance_red,'r--','LineWidth',linew)


%%
% x = distance_red;
% y = distance_co2;
% X = [ones(length(x),1) x];
% b = X\y
% 
% 
% figure(plot_index+ 30)
% clf
% hold on
% 
% set(gca,'FontSize',20,'LineWidth',linew)
% box on
% difference = distance_co2-distance_red;
% time_av = 10e-6;
% fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
% aver_points = max(1,fix(time_av*fs_rec));
% diff_lp = movmean(difference,aver_points);
% plot(t_rec_phase_r,abs(difference),'LineWidth',linew)
% plot(t_rec_phase_r,abs(diff_lp),'LineWidth',linew)
% legend({'diff','lowpass diff '})
% err = rms((diff_lp));
% err_std = std(abs(difference));
% 
% xlabel('$t, s$','Interpreter','latex','FontSize',35);
% ylabel('$\delta, ~\mu m$','Interpreter','latex','FontSize',35);
% % ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
% title(['$Difference between interferometers ~$', num2str(plot_index);  string((err*1000)) ],'Interpreter','latex','FontSize',35); 
% 
% 
% %
% 
% figure(plot_index + 20)
% clf 
% hold on
% 
% set(gca,'FontSize',20,'LineWidth',linew)
% box on
% xlabel('$f, Hz$','Interpreter','latex','FontSize',35);
% ylabel('$PSD$','Interpreter','latex','FontSize',35);
% % ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
% title(['$Pwelch~of~the~interferometers ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
% 
% fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
% [px_co2, fff] = pwelch(detrend(distance_co2).*hanning(size(distance_co2,1),"periodic") ,[],[],[],fs_rec);
% log_px = log(px_co2)/log(10);
% plot(fff, log_px,'k','LineWidth',linew)
% 
% % fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
% [px_red, fff] = pwelch(detrend(distance_red).*hanning(size(distance_red,1),"periodic") ,[],[],[],fs_rec);
% log_px = log(px_red)/log(10);
% plot(fff, log_px,'--r','LineWidth',linew)
% legend({'CO2','Red'})
% 
% 
% xlim([0 5e3])
% %%
% figure(plot_index+40)
% clf
% hold on
% 
% set(gca,'FontSize',20,'LineWidth',linew)
% 
% xlabel('$t, s$','Interpreter','latex','FontSize',35);
% ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% % ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
% title(['$Reconstructed ~distance~ LOWPASSED ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
% box on
% 
% time_av = 30e-6;
% fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
% aver_points = max(1,fix(time_av*fs_rec));
% 
% distance_co2_lp = movmean(distance_co2,aver_points);
% distance_red_lp = movmean(distance_red,aver_points);
% 
% plot(t_rec_phase_c,distance_co2_lp,'k','LineWidth',linew)
% plot(t_rec_phase_r,distance_red_lp,'r--','LineWidth',linew)
% legend({'CO2','Red'})
% 
% %%
% figure(1000)
% clf
% hold on
% lb = 0.39999; 
% rb = 0.4001;
% sig2plt = data(fix(end*lb):1:fix(end*rb),3);
% % sig2plt = sig2plt - mean(sig2plt);
% sig2plt2 = data(fix(end*lb):1:fix(end*rb),1);
% % sig2plt2 = sig2plt2 - mean(sig2plt2);
% t_arr_2plt = linspace(-0.25+0.5*lb,-0.25+0.5*rb,size(sig2plt,1));
% 
% plot(t_arr_2plt*1e6,sig2plt)
% plot(t_arr_2plt*1e6,sig2plt2)
% 
% %% 
% figure(2000)
% 
% clf
% hold on
% [px_co2, fff] = pwelch(detrend(sig2plt).*hanning(size(sig2plt,1),"periodic") ,[],[],[],fs);
% log_px = log(px_co2)/log(10);
% plot(fff, log_px,'b','LineWidth',linew)
% [px_co2, fff] = pwelch(detrend(sig2plt2).*hanning(size(sig2plt2,1),"periodic") ,[],[],[],fs);
% log_px = log(px_co2)/log(10);
% plot(fff, log_px,'y','LineWidth',linew)
% 
% %%
% figure(1001)
% clf 
% hold on     
% plot(t_rec_phase_c, rec_phase_arr_r)
% plot(t_rec_phase_c, unwrap(rec_phase_arr_r))
% title('red')
% %%
% figure(1002)
% clf 
% hold on     
% plot(t_rec_phase_c, rec_phase_arr_c,'green')
% 
% plot(t_rec_phase_c, unwrap(rec_phase_arr_c),'--y')
% title('co2')
%%
% figure(71)
% clf
% hold on
% k_unrwap = 1;
% plot_unwrap = 1/2/pi*1/k_unrwap*(k_unrwap*phase_red);
% plot(plot_unwrap)
% 
% figure(72)
% clf
% hold on
% plot(abs(plot_unwrap(2:end)-plot_unwrap(1:end-1)))
if 0
    figure(73)
    clf
    hold on
    k_unrwap = 1;
    phase_s_red_un = 1/2/pi/k_unrwap*unwrap(k_unrwap*phase_s_red,2*pi);
    
    plot((phase_s_red_un))
    plot(movmean(phase_s_red_un,100))
    title('Red')

    figure(74)
    clf
    hold on
    k_unrwap = 1;
    phase_s_co2_un = 1/2/pi/k_unrwap*unwrap(k_unrwap*phase_s_co2,2*pi);
    
    plot((phase_s_co2_un))
    plot(movmean(phase_s_co2_un,100))
    title('CO2')
    
%     phase_s_red_un_clean = clean_pts(phase_s_red_un,0.1);
    
%     plot(unwrap(phase_s_red_un_clean ))

%     phase_0_red_un_lp = unwrap(phase_s_red_un_clean);
%     phase_0_red_un_lp = movmean(phase_0_red_un_lp,10000); 
%     plot(phase_0_red_un_lp)
    
%     plot(phase_s_red_un-phase_0_red_un_lp)
    % plot((unwrap(phase_s_red-movmean(unwrap(phase_0_red,pi),100))))
    % xlim(1.03e5+ 0.01e5*[-1 1])
end