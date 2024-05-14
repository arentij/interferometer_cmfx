file_name = 'apr17/CMFX_862_scope.csv';
file_name = '/Volumes/CMFX_256G/interferometer/apr17/RigolDS0.csv';


file_name = 'apr17/CMFX_001_scope.csv';
cmfx_i = strfind(file_name,'CMFX_');

%

% data1 = readmatrix(file_name);
%
% data = [data1(1:end,[5,7,6,8])];
data = [data1(1:end,[1,2,3,4])];
%%

parse_fname;

mo=4; 

fs = 25e6;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = str2num(file_name(cmfx_i+5:cmfx_i+7))*100+01;
plot_two_int();