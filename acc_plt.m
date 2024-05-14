%% here we deal with the accelerometer data
% if there is third channel , lets plot the acceleration
if size(data,2) >= 3
    
    data_acc = data(:,3);
    downsmpl_acc = 1000;

    data_acc_lp = movmean(data_acc,downsmpl_acc*2);
    t_acc_lp = movmean(t_art,downsmpl_acc*2);
    
    data_acc_ds = data_acc_lp(1:downsmpl_acc:end);
    t_acc = t_acc_lp(1:downsmpl_acc:end);

else
    data_acc =  file_acc_name;
end

% figure(800)
% plot(t_acc,data_acc_ds)

%%
figure(1004)
clf
hold on
% accelerometer
fs_int = length(rec_phase_arr)/t_rec_phase(end);
[px, fff] = pwelch(detrend(rec_phase_arr),[],[],[],fs_int);
log_px = log(px)/log(10);
% plot(fff, log_px,'LineWidth',2,'Color','blue')
% interferometer
fs_ds_int = length(rec_phase_arr_ds2)/t_arr_ds(end);
[px2, fff2] = pwelch(detrend(data_acc_ds),[],[],[],fs_ds_int);
log_px2 = log(px2)/log(10);
plot(fff2, log_px2,'LineWidth',2,'color','red')

legend({'Accelerometer','Interferometer'})


xlim([0 1000])

%%
% integrating 
vel = zeros(size(data_acc_ds));
dt = (t_acc(2)-t_acc(1));
av_acc = mean(data_acc_ds);
for i = 2:length(vel)
    vel(i) = vel(i-1) + dt*data_acc_ds(i);
end

vel= vel-mean(vel);

pos = zeros(size(vel));
for i = 2:length(pos)
    pos(i) = pos(i-1) + dt*vel(i);
end

pos = pos - mean(pos);

figure(plot_index+17)
% hold on
acc_data = data_acc_ds/30;
plot(t_acc,acc_data,'k','LineWidth',2)

plot(t_acc,vel*100,'LineWidth',2,'color','green')
plot(t_acc,pos*10000,'LineWidth',2,'color','cyan')
lgd = legend({'Phase Interf','Phase Int LP','Accelerometer','Velocity','Position'},'Interpreter','latex','FontSize',22,'Location','best');
% file_name_wav2 = [file_name_acc(1:end-4), '_2.wav'];
%
txt_obj = text(0.01,-0.35,comment,'fontsize',25);
%%
%% set(lgd,'Position','best')
% lgd.Position = 'North';
set(txt_obj,'Position',[0.01 -0.0252])
%%
saveas(gcf,[plt_name  'exp' num2str(exp_number) '/exp' num2str(exp_number) '_phase.fig'])
