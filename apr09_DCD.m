tic
file_name = 'apr09/CMFX_1_scope.csv';
% data1 = readmatrix(file_name);
t_load = toc

%%
ds_ind = 1;

downsampling = fix(ds_ind);

fs = 250e6/downsampling;
signal_co2 = data1(1:downsampling:end,6);
driver_co2 = data1(1:downsampling:end,8);

signal_red = data1(1:downsampling:end,5);
driver_red = data1(1:downsampling:end,7);


%%
tic
[t_co2,phase_s_co2,phase_0_co2,f_c_co2] = dicodem(driver_co2,signal_co2,fs);

tic
[t_red,phase_s_red,phase_0_red,f_c_red] = dicodem(driver_red,signal_red,fs);
t_dcd = toc

%%
tic
plot_two_int_DCD();
t_plt = toc
