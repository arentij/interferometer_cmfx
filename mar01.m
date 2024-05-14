file_name = 'mar01/RigolDS9.csv';
file_name2= 'mar01/RigolDS9_100000000.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data1 = readmatrix(file_name);
data2= readmatrix(file_name2);
%%
data = [data1; data2];
% data = [data1(1:fix(end/5),:)];
%%
tic
parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec;
toc
%%
% figure(40)
% clf; hold on
% plot(data(1:100,4))
% plot(data(1:100,5))

% figure(41)
% histogram(data(2:end,3)-data(1:end-1,3))
%%

fs_acc = 100e3;
acc_2nd_scope;

load gong
sound(y,Fs)