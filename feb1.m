file_name = 'feb01/RigolDS6.csv';
file_name2= 'feb01/RigolDS6_100000000.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data1 = readmatrix(file_name);
data2= readmatrix(file_name2);
%%
data = [data1; data2];
%%
parse_fname;
fs = 12.5e6; % for 12.5 it is 1
clear_figs = 1;
phase_switch = 1;
phase_rec;

%% 
fs_acc = 100e3;
acc_2nd_scope;

