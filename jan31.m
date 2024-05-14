file_name = 'jan31/RigolDS8.csv';
file_name2= 'jan31/RigolDS8_100000000.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data1 = readmatrix(file_name);
data2= readmatrix(file_name2);
%%
data = [data1; data2];
%%

parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec;
%% 
fs_acc = 100e3;
acc_2nd_scope;
