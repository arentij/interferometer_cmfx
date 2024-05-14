file_name =      'jan30/RigolDS2.csv';
file_name2 = 'jan30_500/RigolDS2.csv';
tic
data_new = readmatrix(file_name);
toc
% data_500 = readmatrix(file_name2);
%%
% 0 - chtrough the chamber, 500 mhz and 25 mhz - might be screwed up driver
% 1 - same but the date looks better
% 
%%

%
parse_fname;
tic
clear_figs = 1;
phase_switch = -1;
data = data_new(1:fix(end/5),:);
fs = 50e6;
phase_rec;
toc
%%
data = data_500;
clear_figs = 0;
fs = 500e6;
phase_switch = 1;
phase_rec;