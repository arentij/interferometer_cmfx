% % trying downsampling the original data with this new FFT code
%%
file_name = 'jan17/RigolDS12.csv';
data = readmatrix(file_name);
data_ds_cell = {};
%%
fs = 5e8; % original sampling rate

% data_ds_cell = {};
% okay, let's just try to downsample k times and see when it brakes;
% figure(13)
% clf; hold on
for k_ds = [1:30] 
    data_ds_cell{end+1,3} = k_ds;
    k_ds
    fs_ds = fs/k_ds;
    data_ds = data(1:k_ds:end,:);
    %
    dt_phase = 1e-6;    % resolution (window size)
    ovlp = 0.75;        % overlap in %   (overlaps of the windows)
    
    driver = data_ds(:,2);
    signal = data_ds(:,1);
    
    N_pts = size(driver,1);
    
    [rec_phase_arr,t_rec_phase] = rec_phase(driver,signal,fs_ds,dt_phase,ovlp);
    t_rec_phase = t_rec_phase - (t_rec_phase(end)-t_rec_phase(1))/2;
    
    data_ds_cell{end,1} = t_rec_phase;
    data_ds_cell{end,2} = rec_phase_arr;

%     figure(13)
%     plot(t_rec_phase,rec_phase_arr-mean(rec_phase_arr),'LineWidth',2)

%
end
%%
figure(14)
clf
hold on
lgd_cell = {};
for i_data =  [30,1]
    
    t_rec_phase = data_ds_cell{i_data,1};
    rec_phase_arr=data_ds_cell{i_data,2};
    rec_phase_arr = movmean(rec_phase_arr,1);
%     if
    k = data_ds_cell{i_data,3};
    if k >= 8
        fctr = 1;
    else
        fctr = 1;
    end
    fs_i = fs/k;

    lgd_cell{end+1} = [num2str(fs_i/1e6) ' MHz'];
    plot(t_rec_phase,dphdl*fctr*(rec_phase_arr-mean(rec_phase_arr)),'LineWidth',2)
end
legend(lgd_cell{:})

%%
error_array = ones(size(data_ds_cell,1),3);

baseline = movmean(data_ds_cell{1,2},40); % so the error will be over 10 us averaged original 500 MHz  4 factor is from overlapping 75%
baseline = baseline - mean(baseline);
t_base = data_ds_cell{1,1};

for i_data = 1:size(data_ds_cell,1)
   
    t_rec_phase = data_ds_cell{i_data,1};
    rec_phase_arr=data_ds_cell{i_data,2};
    rec_phase_arr = rec_phase_arr- mean(rec_phase_arr);
    rec_phase_arr = movmean(rec_phase_arr,1);
    % we need to interpolate the baseline for other sampling rates
    baseline_i = interp1(t_base,baseline,t_rec_phase);
    
%     rec_phase_arr = movmean(rec_phase_arr,10); 
    err = rms(baseline_i(2:end-1)-rec_phase_arr(2:end-1));
    err2= rms(baseline_i(2:end-1)+rec_phase_arr(2:end-1));

    error_array(i_data,1) = err;
    error_array(i_data,2) = data_ds_cell{i_data,3};
    error_array(i_data,3) = err2;
end

dphdl = 10.6e-6 / 2/pi/1e-9;

% phase/2Pi = dL/10.6e-6 => dl = 10.6e-6 / 2/pi * phase

figure(15)
clf; hold on
scatter(5e2./error_array(:,2),error_array(:,1)*dphdl,200,'filled')
scatter(5e2./error_array(:,2),error_array(:,3)*dphdl,200,'filled')

ylim([0 70])