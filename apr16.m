file_name_par = 'apr16/2024_04_16/CMFX_00886_scope.parquet';
file_name_csv = [file_name_par(1:end-7) , 'csv'];
cmfx_i = strfind(file_name_par,'CMFX_');

%
file_name = file_name_csv;
% 
data1 =parquetread(file_name_par); 
% data2 = readmatrix(file_name_csv);
%
data = table2array(data1(1:end,[1,3,2,4]));
% data = [data2(1:end,[1,3,2,4])];
%%
figure(123)
clf;
hold on
shft = 1;
data = data(shft:end,:);
plot(data(shft+[1:26],1),'color','y','LineWidth',2)
plot(data(shft+[1:26],2),'c','LineWidth',2)
plot(data(shft+[1:26],3),'m','LineWidth',2)
plot(data(shft+[1:26],4),'b','LineWidth',2)

%%

parse_fname;

fs = 12.5e6;
fs_red = fs;
fs_co2 = fs;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = str2num(file_name_par(cmfx_i+5:cmfx_i+9))*100+01;
plot_two_int();