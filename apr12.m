file_name = 'apr12/CMFX_880_scope.csv';
file_name2 = 'apr12/RigolDS3.csv';

cmfx_i = strfind(file_name,'CMFX_');

%

data1 = readmatrix(file_name);
data2 = readmatrix(file_name2);
% % %
% data = [data1(1:end,[5,7,6,8])];
% data = [data1(1:end,[1,2,3,4])];
%%

parse_fname;

% fs = 250e6;
fs_red = 50e6;
fs_co2 = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = str2num(file_name(cmfx_i+5:cmfx_i+7))*100+01;

plot_two_int();

%%
figure(91)
clf
hold on
plot(data2(1:10:end,1))