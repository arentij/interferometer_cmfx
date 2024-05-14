file_name = 'apr05/CMFX_846_scope.csv';
% file_name = 'apr05/RigolDS2.csv';

% data1 = readmatrix(file_name);
%
data = [data1(1:end,[5,7,6,8])];
% data = [data1(1:end,[1,2,3,4])];
%%

parse_fname;

fs = 50e6;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = 84600;
plot_two_int();