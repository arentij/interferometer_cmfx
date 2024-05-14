file_name = 'mar26/RigolDS0.csv';
% file_name2= 'jan31/RigolDS8_100000000.csv';
% file_acc_name = ['../accelerometer/' file_name];
% data_acc = readmatrix(file_acc_name);
data1 = readmatrix(file_name);
% data2= readmatrix(file_name2);
%
data = [data1(1:40:end,:)];
%%

parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec;

%%
% figure(40)
% clf; hold on
% plot(data(1:100,4))
% plot(data(1:100,5))

% figure(41)
% histogram(data(2:end,3)-data(1:end-1,3))

