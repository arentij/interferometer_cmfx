file_name = 'feb13/RigolDS9.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data1 = readmatrix(file_name);

%%
data = [data1];
%%

parse_fname;
fs = 50e6;
clear_figs = 1;
phase_switch = 1;
phase_rec;
%% 
fs_acc = 100e3;
acc_2nd_scope;
