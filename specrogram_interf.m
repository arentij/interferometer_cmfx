figure(plot_index+50)

resample_coeff = 400;

fs2 = fs/resample_coeff;

deconstr_sig3 = deconstr_sig(1:resample_coeff:end);
dN_dec_sig = size(deconstr_sig3,2);
max_time = dN_dec_sig/fs2;

seg_dT = 2e-3;
overlap = 0.02;

dN_pts = seg_dT *fs2;
dN_slep = fix(dN_pts*overlap);

N_slices = fix((dN_dec_sig-dN_pts)/(dN_pts*overlap));

ind_t_array = zeros(N_slices,2);
% ind_t_array(1,1) = 1;

for i_ind_t = 1:N_slices
    ind_t_array(i_ind_t,1) =  1+(i_ind_t-1)*dN_slep;
end
ind_t_array(:,2) = ind_t_array(:,1)+dN_pts;

%


for i_ind_t = 1:N_slices
    ind1 = ind_t_array(i_ind_t,1);
    ind2 = ind_t_array(i_ind_t,2);

    current_sig = deconstr_sig3(ind1:ind2);

    [px, fff] = pwelch(detrend(current_sig),[],[],[],fs2);
    log_px = log(px)/log(10);

    if i_ind_t == 1
        
        fft_array = zeros(length(log_px),N_slices);
    end

    fft_array(:,i_ind_t) = log_px;
end

%%
figure(plot_index+50)
t_mid_array = max_time* 0.5*(ind_t_array(:,2)+ind_t_array(:,1))/dN_dec_sig;
h = pcolor(t_mid_array,(fff),fft_array-1*mean(fft_array(:,1:3),2));
set(h, 'EdgeColor', 'none');
% caxis([-9.5 -5.5])
ylim([0 30e3])