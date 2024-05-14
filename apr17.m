file_name_par = 'apr16/2024_04_16/CMFX_00886_scope.parquet';
% file_name_par = 'apr17/2024_04_17/CMFX_00900_scope.parquet';
file_name_csv = [file_name_par(1:end-7) , 'csv'];
% file_name_csv = '/'
cmfx_i = strfind(file_name_par,'CMFX_');

%
file_name = file_name_csv;
% 
data1 =parquetread(file_name_par); 
% data2 = readmatrix(file_name_csv);
%
data = table2array(data1(1:end,[1,3,2,4]));
% data = [data2(1:end,[1,3,2,4])];
fs = 12.5e6;
%%
figure(123)
clf;
hold on
shft = 0;
% data = data(shft:end,:);
t1_plt = 2.4e6;
t2_plt = 24.4e6;
t_arr_123 = linspace(-1,1,2*fs)*1e6;
plot(t_arr_123(shft+[t1_plt:t2_plt]),5*data(shft+[t1_plt:t2_plt],1),'color','k','LineWidth',3)
plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],2),'c','LineWidth',2)
plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],3),'m','LineWidth',2)
plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],4),'b','LineWidth',2)

xlim(-800e3+ [0 1800000])
%%

parse_fname;


fs_red = fs;
fs_co2 = fs;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = str2num(file_name_par(cmfx_i+5:cmfx_i+9))*100+01;
plot_two_int();