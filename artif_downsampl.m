% fs_array = linspace(1:)
% 80 40 20 10 5 2.5
% 500, 250, 125, 100, 50, 

run_results = {};  % (1 - fs, 2 - time_array, 3 - original_phase, 4 - reconstructed_phase)
%%
% fs_array = sort([1,2,3,4,5,9,10,11, 16, 19, 20,21,25, 30, 35,39,40,41, 50, 70, 79, 80, 81, 100, 125,250,500]*1e6);
% fs_array = [100]*1e6;
fs_array = [1e6*[linspace(0.4,100,300)], 12.5e6];
fs_array = [12.5e6];
error_array = ones(size(fs_array,2),2);
for fs_ind = 1:size(fs_array,2)

    fs = fs_array(fs_ind)
    
    t0 = 0; t1 = 50e-3;
    t_art = linspace(t0,t1,fix((t1-t0)*fs));
    
    phase = art_phase(t_art);
    phase1 = phase + 0.01*randn(size(phase));
    
    rng(1)
    fc = 40e6+137+5*randn();
    
    driver = 1*sin(2*pi*fc*t_art+2*pi*rand());
    driver = driver + 0.01*randn(size(driver));
    %
    
    sensor_data = 0+400e-3*sin(2*pi*fc*t_art + phase1);
    sensor_data = sensor_data + 0.01*randn(size(driver));
    
    %%
    dt_phase = 3e-6;    % resolution (window size)
    ovlp = 0.5;        % overlap in %   (overlaps of the windows)    
    [rec_phase_arr,t_rec_phase] = rec_phase_fft(driver,sensor_data,fs,dt_phase,ovlp);
    
    run_results{end+1,1} = fs;  % (1 - fs, 2 - time_array, 3 - original_phase, 4 - reconstructed_phase)
    run_results{end,2} = t_rec_phase;
    
%     matching phase
    phase_match = interp1(t_art,phase,t_rec_phase); 
    
    run_results{end,3} = phase_match;
    run_results{end,4} = rec_phase_arr;
    
%     (sensor_data - mean(sensor_data)) - (rec_phase_arr - mean(rec_phase_arr));

    error_array(fs_ind,1) = rms((phase_match - mean(phase_match)) - (rec_phase_arr - mean(rec_phase_arr)));
    error_array(fs_ind,2) = rms((phase_match - mean(phase_match)) + (rec_phase_arr - mean(rec_phase_arr)));
end
%%
figure(30)
clf; hold on
scatter(fs_array,error_array(:,1),100,'filled','MarkerFaceColor','b')
scatter(fs_array,error_array(:,2),100,'filled','MarkerFaceColor','r')

if 1
    figure(20)
    clf; hold on;
    % plot(t_art,phase-mean(phase))
    
    figure(21)
    clf; hold on
    plot(t_art(1:1000),driver(1:1000))
    plot(t_art(1:1000),sensor_data(1:1000))
    
    figure(20)
    % clf; hold on
    plot(t_rec_phase,rec_phase_arr-mean(rec_phase_arr),'LineWidth',2)
    plot(t_art,phase-mean(phase),'LineWidth',2)
    legend({'Reconstructed','Original No Noise'})
end

%%
fraction_arr = sort([2, 1, 1/2, 2/3, 1/3, 1/4, 2/5, 2/7]);
figure(1)
% clf; hold on;
% scatter(fs_array/1e6,error_array(:,1),200,'filled','MarkerFaceColor','b')
% scatter(fs_array/1e6,error_array(:,2),200,'filled','MarkerFaceColor','r')

for i_frac = 1:length(fraction_arr)

    frac_freq = fraction_arr(i_frac)*fc;
    line([frac_freq frac_freq]/1e6,[0 1],'color','magenta','linewidth',3)
    text(frac_freq,0.05+ 1.6/length(fraction_arr)*(i_frac)^-1, num2str(fraction_arr(i_frac),3),'fontsize',30,'color','magenta')

end
ylim([0 0.3])
box on
xlabel('f_s, Hz')
ylabel('err, rad')

set(gca,'FontSize',25,'linewidth',3)
legend({'Normal','Inverted'})