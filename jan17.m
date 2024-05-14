file_name = 'jan17/RigolDS12.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data = readmatrix(file_name);
%%
parse_fname;
%  
comment = 'Through the chamber, vibrator off, LowPass on 100';
% phase_diff;
fs = 500e6;
ds_fctr = 40;

fs = fs/ds_fctr;
phase_rec;
%%
fs_acc = 100e3;
acc_2nd_scope;
xlim([-60e-3 60e-3])
%% 
% numbers 10,11 are with the vibrator, 12 is only the retroreflector
%%
% figure(123)
% clf; hold on
% plot(data(1:5e6,1))
% plot(data(1:5e6,2))