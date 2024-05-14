tic
file_name = 'apr10/CMFX_86_scope.csv';
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

if 0 % box averaging 
    pp_box = 2;
    tic 
    signal_red = movmean(signal_red,pp_box);
    driver_red = movmean(driver_red,pp_box);

    signal_co2 = movmean(signal_co2,pp_box);
    driver_co2 = movmean(driver_co2,pp_box);
    t_filt = toc
end

if 1  % bandpass filter
    f_center = 40e6;
    f_bandwidth = 1e6; 
    bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
         'CutoffFrequency1',f_center-f_bandwidth,'CutoffFrequency2',f_center+f_bandwidth, ...
         'SampleRate',fs);
    signal_red = filter(bpFilt, signal_red);
    driver_red = filter(bpFilt, driver_red);
end

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
