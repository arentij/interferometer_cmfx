% if ~exist('rec_phase_arr_c','var')
%     
% %     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/mar27/exp4/exp4_rec_phase.mat';
% %     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/apr01/exp1/exp1_rec_phase.mat';
%     exp_f_name = '/Users/arturperevalov/Documents/MATLAB/interferometer/apr04/exp1/exp1_rec_phase.mat';
%     load(exp_f_name);
%     idx = regexp(exp_f_name,'exp','once');
%     plot_index = str2num(exp_f_name(idx+3));
% end
% %%
lambda1 = 10.56e-6;
lambda2 = 0.639e-6;
matching_koeff = 30;
unwrp_k = pi;
distance_co2 = unwrap(rec_phase_arr_c,unwrp_k)/2/pi*lambda1;
distance_co2 = distance_co2 - mean(distance_co2(1:fix(end/matching_koeff)));
distance_co2 = -distance_co2*1e6;
% mean(distance_co2)

distance_red = unwrap(rec_phase_arr_r,unwrp_k)/2/pi*lambda2;
% distance_red =distance_red -distance_red(fix(end/2));
distance_red =distance_red  - mean(distance_red(1:fix(end/matching_koeff)));
distance_red =distance_red *1e6;

%%
% if ~exist('plot_index','var')
%     plot_index = str2num(exp_f_name(idx+3));
% end

%%

linew = 3;

figure(plot_index+10)
clf
hold on

set(gca,'FontSize',20,'LineWidth',linew)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Reconstructed ~distance ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
box on
dt_red = 0*0.1;
dt_co2 = 0*4.5;
plot(t_rec_phase_c+dt_co2,distance_co2,'k','LineWidth',linew)
plot(t_rec_phase_r+dt_red,distance_red,'r--','LineWidth',linew)
legend({'CO2','Red'})


%%
x = distance_red;
y = distance_co2;
X = [ones(length(x),1) x];
b = X\y

%%
e_charge = 1.6e-19;
m_e = 9.1e-31;
c_light = 3e8;
eps_0 = 8.85e-12;

C_const = -e_charge^2/(4*pi*c_light^2*eps_0*m_e);
C_const = C_const*(lambda1^2-lambda2^2)/1e6;
C_const =1;
%%
% 
figure(plot_index+ 30)
clf
hold on

set(gca,'FontSize',20,'LineWidth',linew)
box on
difference = (distance_co2-distance_red);
time_av = 200e-3;
fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
aver_points = max(1,fix(time_av*fs_rec));
diff_lp = movmean(difference,aver_points);
plot(t_rec_phase_r,abs(difference/C_const),'LineWidth',linew)
plot(t_rec_phase_r,abs(diff_lp/C_const),'LineWidth',linew)
legend({'diff','lowpass diff '})
err = rms((diff_lp));
err_std = std(abs(difference));

t_fake = [-1 -0.95 -0.7+10e-3 0 1];
d_fake = [0 0.023 1.49 1.47 1.41];
xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$\delta, ~\mu m$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Difference between interferometers ~$', num2str(plot_index);  string((err*1000)) ],'Interpreter','latex','FontSize',35); 

% plot(t_fake, d_fake,'blue','linewidth',3)

d_interp = interp1(t_fake, d_fake, t_rec_phase_r);

% plot(t_rec_phase_r, d_interp,'blue','linewidth',3)
% 
% plot(t_rec_phase_r,abs(difference/C_const)-d_interp,'green','linewidth',3)
%%
% 
figure(plot_index + 20)
clf 
hold on

set(gca,'FontSize',20,'LineWidth',linew)
box on
xlabel('$f, Hz$','Interpreter','latex','FontSize',35);
ylabel('$PSD$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Pwelch~of~the~interferometers ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 

fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
[px_co2, fff] = pwelch(detrend(distance_co2).*hanning(size(distance_co2,1),"periodic") ,[],[],[],fs_rec);
log_px = log(px_co2)/log(10);
plot(fff, log_px,'k','LineWidth',linew)

% fs_rec = size(rec_phase_arr_r,1)/(t_rec_phase_r(end)-t_rec_phase_r(1));
[px_red, fff] = pwelch(detrend(distance_red).*hanning(size(distance_red,1),"periodic") ,[],[],[],fs_rec);
log_px = log(px_red)/log(10);
plot(fff, log_px,'--r','LineWidth',linew)
legend({'CO2','Red'})


xlim([0 5e3])
%%
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

% %%
% figure(1000)
% clf
% hold on
% lb = 0.0; 
% rb = 1;
% sig2plt = data(1:1:end,3);
% % sig2plt = sig2plt - mean(sig2plt);
% sig2plt2 = data(1:1:end,1);
% % sig2plt2 = sig2plt2 - mean(sig2plt2);
% t_arr_2plt = linspace(-0.1,0.1,size(sig2plt,1));
% 
% plot(t_arr_2plt,sig2plt)
% plot(t_arr_2plt,sig2plt2)

%% 
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

%%
figure(1001)
clf 
hold on     
plot(t_rec_phase_c, rec_phase_arr_r)
plot(t_rec_phase_r, unwrap(rec_phase_arr_r))
title('red')
%%
figure(1002)
clf 
hold on     
plot(t_rec_phase_c, rec_phase_arr_c,'cyan')

plot(t_rec_phase_c, unwrap(rec_phase_arr_c),'--k')
title('co2')
%%
load gong.mat
gong = audioplayer(y/5,Fs);
play(gong) 
