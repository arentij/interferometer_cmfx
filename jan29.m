% file_name = 'jan29/RigolDS1.csv';
% file_acc_name = ['../accelerometer/' file_name];
% data_acc = readmatrix(file_acc_name);
% % data = readmatrix(file_name);
% %%
% parse_fname;
% %  
% comment = '';
% 
% fs = 12.5e6;
% phase_rec;
% 
% fs_acc = 100e3;
% acc_2nd_scope;
% % xlim([-60e-3 60e-3])


%%
file_name = 'jan29/RigolDS5.csv';
file_acc_name = ['../accelerometer/' file_name];
data_acc = readmatrix(file_acc_name);
data = readmatrix(file_name);
%%
parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_rec;

fs_acc = 100e3;
acc_2nd_scope;
