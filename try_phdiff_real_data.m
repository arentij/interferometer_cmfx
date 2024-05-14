file_name = 'jan09/RigolDS7.csv';
data07 = readmatrix(file_name);
fs = 0.5e9;
%%
driver = data07(:,2);
signal = data07(:,1);

N_pts = size(driver,1);
t_art = linspace(0,N_pts/fs,N_pts);
%%
dt_phase = 1e-6;
ovlp = 0.75;
[rec_phase_arr,t_rec_phase] = rec_phase(driver,signal,fs,dt_phase,ovlp);
%%
downsampling = 10;
rec_phase_arr_ds2 = unwrap(rec_phase_arr);
rec_phase_arr_ds2 = movmean(rec_phase_arr_ds2,2*downsampling);
rec_phase_arr_ds2 = rec_phase_arr_ds2(1:downsampling:end);
t_arr_ds = movmean(t_rec_phase,2*downsampling);
t_arr_ds = t_arr_ds(1:downsampling:end);


%%
% if there is third channel , lets plot the acceleration
if size(data07,2) >= 3
    data_acc = data07(:,3);
    
    downsmpl_acc = 5000;

    data_acc_ds = data_acc(1:downsmpl_acc:end);
    t_acc = t_art(1:downsmpl_acc:end);

end
%%
figure(1003)
clf
hold on
plot(t_arr_ds,rec_phase_arr_ds2-rec_phase_arr_ds2(1),'b--','LineWidth',2)

%
figure(1003)
% hold on
plot(t_acc,-(data_acc_ds-data_acc_ds(1))/30,'r','LineWidth',2)


%%
figure(1005)
clf
hold on
% accelerometer
fs_int = length(rec_phase_arr)/t_rec_phase(end);
[px, fff] = pwelch(detrend(rec_phase_arr),[],[],[],fs_int);
log_px = log(px)/log(10);
plot(fff, log_px,'LineWidth',2,'Color','blue')
% interferometer
fs_ds_int = length(rec_phase_arr_ds2)/t_arr_ds(end);
[px2, fff2] = pwelch(detrend(data_acc_ds),[],[],[],fs_ds_int);
log_px2 = log(px2)/log(10);
plot(fff2, log_px2,'LineWidth',2,'color','red')

legend({'Accelerometer','Interferometer'})


xlim([0 1000])