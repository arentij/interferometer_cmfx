figure(99)
clf 
hold on
leg = {};
for ind_exp = [1:7]
    t_array = linspace(0,0.1,4166667);
    phase = int_data{ind_exp,2};
    leg{end+1,1} =  num2str(int_data{ind_exp,1});
    % lowpassing, averaging over 1 us (42 pts correspond to ~1 us)
    phase_lp = movmean(phase,10);
    plot(t_array,phase_lp);
    
end
%
legend((leg{:}))

%%

figure(100)
clf 
hold on
leg = {};
for ind_exp = [1:7]
%     t_array = linspace(0,0.1,4166667);
    phase = int_data{ind_exp,2};
    leg{end+1,1} =  num2str(int_data{ind_exp,1});
    phase = phase(1041666:1041666*2); % cutting 25 ms after the ignitron
    [px, fff] = pwelch(detrend(phase),[],[],[],500000000/12);

    log_px = log(px)/log(10);
    plot(fff, log_px,'LineWidth',2)

    
end
set(gca,'xscale','log')
legend((leg{:}))
%
title('Power spectra of the phase ')
xlabel('f, Hz')
ylabel('PSD, DB')
