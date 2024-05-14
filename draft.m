lambda1 = 10.6e-6;
lambda2 = 0.639e-6;

load('/Users/arturperevalov/Documents/MATLAB/interferometer/mar27/exp3/exp3_rec_phase.mat');

distance_co2 = unwrap(rec_phase_arr)/2/pi*lambda1;
distance_co2 = distance_co2 - distance_co2(fix(end)/2);
distance_co2 = distance_co2 - mean(distance_co2);
distance_co2 = distance_co2*1e6;

load('/Users/arturperevalov/Documents/MATLAB/interferometer/mar27/exp3/exp3_rec_phase2.mat');
distance_red = -unwrap(rec_phase_arr)/2/pi*lambda2;
distance_red =distance_red -distance_red(fix(end/2));
distance_red =distance_red -mean(distance_red);
distance_red =distance_red *1e6;
figure(123)
clf
hold on
plot(t_rec_phase,distance_co2,'k')
plot(t_rec_phase,distance_red,'r')


figure(124)
clf
hold on
% plot(t_rec_phase,distance_co2)
plot(t_rec_phase,abs(distance_co2-distance_red))


mean(abs(distance_co2-distance_red))
%%

figure(125)
clf
hold on
fs_rec = size(rec_phase_arr,1)/(t_rec_phase(end)-t_rec_phase(1));
[px, fff] = pwelch(detrend(distance_co2).*hanning(size(distance_co2,1),"periodic") ,[],[],[],fs_rec);
log_px = log(px)/log(10);
% log_px2 = log(px2)/log(10);
% plot(fff, log_px,'LineWidth',2)
plot(fff, log_px,'LineWidth',2,'Color','k')

fs_rec = size(rec_phase_arr,1)/(t_rec_phase(end)-t_rec_phase(1));
[px, fff] = pwelch(detrend(distance_red).*hanning(size(distance_red,1),"periodic") ,[],[],[],fs_rec);
log_px = log(px)/log(10);
% log_px2 = log(px2)/log(10);
% plot(fff, log_px,'LineWidth',2)
plot(fff, log_px,'LineWidth',2,'Color','red')

xlim([0 2e3])


%%
gap = 1e-3;
gap_pts = fix(gap*fs_rec);

distance_co2_lp = movmean(distance_co2,gap_pts);
distance_red_lp = movmean(distance_red,gap_pts);

figure(126)
clf
hold on
plot(t_rec_phase,distance_co2_lp,'k')
plot(t_rec_phase,distance_red_lp,'r')

err = mean(abs(distance_co2_lp-distance_red_lp))

figure(127)
clf
hold on
plot(t_rec_phase,distance_co2_lp-distance_red_lp,'k')
title(['Average error ' num2str(err)])
% movmean()

