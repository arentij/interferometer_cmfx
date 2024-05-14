function [rec_phase_arr,t_rec_phase] = rec_phase_fft(driver,signal,fs,dt_phase,ovlp)
%REC_PHASE Summary of this function goes here
%   Detailed explanation goes here
tic
% ovlp = 0.75;
% dt_phase = 1e-6;

%

N_samples = length(driver);
t_array = linspace(0,N_samples/fs,N_samples);

dt_pts = fix(dt_phase*fs);

step_pts = fix((1-ovlp)*dt_pts);

t1_ind_arr = 1:step_pts:(length(t_array)-dt_pts);


rec_phase_arr = zeros(length(t1_ind_arr),1);
t_rec_phase = zeros(length(t1_ind_arr),1);

for i_slice = 1:length(t1_ind_arr)
    slice_ind = t1_ind_arr(i_slice):t1_ind_arr(i_slice)+dt_pts;
    signal_slice = signal(slice_ind);
    driver_slice = driver(slice_ind);
    t_rec_phase(i_slice) = mean(t_array(slice_ind));
    rec_phase_arr(i_slice) = phase_diff_fft(signal_slice,driver_slice);


end

time_it_took = toc;

end

