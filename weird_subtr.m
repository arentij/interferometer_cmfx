distance_red_fix =distance_red;
distance_co2_fix =distance_co2;
t_rec_phase_r;

t_1 = -0.1;
dt_match = 1e-3;

t_2 = 0.1;


zeroing_ind = [find(t_rec_phase_r > t_1-dt_match, 1): find(t_rec_phase_r > t_1, 1)];
mean(t_rec_phase_r_save(zeroing_ind))

zeroing2_ind = [find(t_rec_phase_r > t_2+dt_match, 1): find(t_rec_phase_r > t_2+2*dt_match, 1)];

distance_red_fix = distance_red_fix - mean(distance_red_fix(zeroing_ind));
distance_co2_fix = distance_co2_fix - mean(distance_co2_fix(zeroing_ind));

K = mean(distance_co2_fix(zeroing2_ind))/mean(distance_red_fix(zeroing2_ind))

t_wind =       [-0.25  -0.1 -0.075 -0.05  0    0.1   0.25];
window_shift = -[0      0    0.4    0.85     1.25  1.6   1.6]*1.55;
n_red = 2.5375;
n_co2 = 2.3957;

%

figure(60)
clf
hold on 
% plot(t_rec_phase_r,red_shift*k_fix,'r','LineWidth',3)
plot(t_rec_phase_r,distance_red_fix,'r','LineWidth',3)
plot(t_rec_phase_r,distance_co2_fix,'k','LineWidth',3)

plot(t_rec_phase_r,distance_red_fix*K-distance_co2_fix,'g','LineWidth',3)

plot(t_wind, window_shift*(n_red-1),'--','color','magenta','LineWidth',3)

plot(t_wind, window_shift*(n_co2-1),'--','color','cyan','LineWidth',3)