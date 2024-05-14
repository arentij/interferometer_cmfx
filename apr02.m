file_name = 'apr02/RigolDS4.csv';
data1 = readmatrix(file_name);
%
data = [data1(1:end,1:4)];
%%

parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_two_int();