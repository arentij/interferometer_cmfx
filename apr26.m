file_name_par = 'apr26/CMFX_00925_scope.parquet';
file_name_csv = [file_name_par(1:end-7) , 'csv'];
cmfx_i = strfind(file_name_par,'CMFX_');
file_name = file_name_par;
data1 =parquetread(file_name_par); 
%
data = table2array(data1(1:end,[1,3,2,4]));
% CMFX_00953_scope.parquet
fs = 12.5e6;
%
% file_name_par = file_name_par(7:end);
%%
figure(123)
clf;
hold on
shft = 0;
% data = data(shft:end,:);
t1_plt = 0.0001e6;
t2_plt = 2.4001e6;
t_arr_123 = linspace(-1,1,2*fs)*1e6;
% plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],1),'color','k','LineWidth',3)
% plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],2),'c','LineWidth',2)
% plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],3),'m','LineWidth',2)
% plot(t_arr_123(shft+[t1_plt:t2_plt]),data(shft+[t1_plt:t2_plt],4),'b','LineWidth',2)

plot(data(:,1),'color','k','LineWidth',3)

% xlim(-800e3+ [0 1800000])
%%

parse_fname;
mnth = 4;
year = 24;
day = 26;


exp_ind = strfind(file_name,'CMFX_');
exp_number = str2double(file_name(exp_ind+5:exp_ind+9));

plot_index =(year-23)*10^9 + mnth*10^7 + day*10^5 + exp_number*10^2
%%
fs_red = fs;
fs_co2 = fs;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
plot_index = str2num(file_name_par(cmfx_i+5:cmfx_i+9))*100+01;
plot_two_int();

%%
t_rec_phase_r_save = t_rec_phase_r + 200e-3;
t_rec_phase_c_save = t_rec_phase_c + 200e-3;
% save(['apr25/' 'Exp' num2str(exp_number,'%05d') '_rec_dist.mat'],'t_rec_phase_r_save','distance_red','t_rec_phase_c_save','distance_co2');
%%        

figure(80)
clf
hold on
plot(t_rec_phase_r_save,distance_red,'r','linewidth',3)
plot(t_rec_phase_c_save,distance_co2,'k','linewidth',3)