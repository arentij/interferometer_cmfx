N_pts_acc = length(data_acc);

t_art_acc = linspace(0,N_pts_acc/fs_acc,N_pts_acc);
t_art_acc = t_art_acc- t_art_acc(end)/2;


sens = 9.98; % V/g
g = 9.8;  % m/s^2
gain = 1000;
accel = data_acc*sens*g/gain;

%%
% integrating 
vel = zeros(size(accel));
dt = (t_art_acc(2)-t_art_acc(1));
av_acc = mean(accel);
for i = 2:length(vel)
    vel(i) = vel(i-1) + dt*accel(i);
end
%
vel= vel-mean(vel);
% vel = detrend(vel,4);

%
pos = zeros(size(vel));
for i = 2:length(pos)
    pos(i) = pos(i-1) + dt*vel(i);
end

pos = pos - mean(pos);
pos = detrend(pos,3);
%%
figure(12)
clf; hold on
% plot(t_art_acc,accel,'k','LineWidth',2)

plot(t_arr_ds,phase_to_plot,'r','LineWidth',2.0)
plot(t_arr_ds,phase_lowpassed,'b','LineWidth',3.0)
box_av = 20000;
plot(t_arr_ds,movmean(phase_lowpassed,box_av),'magenta','LineWidth',3.0)

% plot(t_art_acc,vel,'y','LineWidth',2)
plot(t_art_acc,0.1*(pos-pos(fix(end/2)))*2*pi/10.6e-6 + phase_lowpassed(fix(end/2)),'g','LineWidth',4)

plot(t_art_acc,movmean(0.1*(pos-pos(fix(end/2)))*2*pi/10.6e-6 + phase_lowpassed(fix(end/2)),box_av),'cyan','LineWidth',3)
% xlim([-55e-3 55e-3])

set(gca,'fontsize',18)
xlabel('t, s')
ylabel('phase, rad')
legend({'interferometer','int lowpassed','accelerometer'})
%%
% save("jan17_exp12_ds_data.mat","t_arr_ds","phase_to_plot","phase_lowpassed")

figure(13)
clf; hold on
plot(t_art_acc,accel,'LineWidth',2)

figure(1001)

hold on
[px_acc, fff_acc] = pwelch(accel.*hanning(size(accel,1),"periodic") ,[],[],[],fs_rec);

log_px_acc = log(px_acc)/log(10);
% log_px2 = log(px2)/log(10);
% plot(fff_acc, log_px_acc,'LineWidth',2,'Color','red')
plot(fff_acc, log_px_acc,'LineWidth',2)
% plot(fff, log_px2,'LineWidth',2,'Color','red')
xlim([0 2e3])