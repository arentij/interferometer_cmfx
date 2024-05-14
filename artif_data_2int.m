fs = 1.25e6;
fc_red = -40e6 + 100*randn();
fc_co2 =  40e6 + 100*randn();

t1 = -30e-3;
t_total = 100e-3;
t2 = t1 + t_total;

t_discharge = 50e-3;

t_array_art = linspace(t1,t2,fix(fs*t_total));

%% now lets make the distance between the last mirrors
w_tower = 15 + randn(1); % tower moving
w_table = 3 + randn(1);  % table moving

d0 = 0 + 0.01*randn(1); % base double distance between table and tower

a_tower = 1e-6+randn()*1e-7;
a_table = 2e-6+randn()*3e-7;

distance = d0 + a_tower*sin(rand()*2*pi+2*pi*w_tower*t_array_art) + a_table*sin(rand()*2*pi+2*pi*w_table*t_array_art);

a_mir_red = 40e-9 + 5e-9*randn();
a_mir_co2 = 40e-9 + 5e-9*randn();

w_mir_red = 320 + 5*randn();
w_mir_co2 = 320 + 5*randn();

distance_d_red = distance + a_mir_red*sin(2*pi*rand() + 2*pi*w_mir_red*t_array_art);
distance_d_co2 = distance + a_mir_co2*sin(2*pi*rand() + 2*pi*w_mir_co2*t_array_art);


figure(50)
clf
hold on

plot(t_array_art,distance_d_red,'r','LineWidth',3)
plot(t_array_art,distance_d_co2,'k--','LineWidth',3)
%%
a_dis_move = 1e-6;
t_dis_mov = [t1, 0, t_discharge, t2];
d_dis     = [0,  0, a_dis_move, a_dis_move];

d_dis_sampled = interp1(t_dis_mov,d_dis,t_array_art);
plot(t_array_art,d_dis_sampled+distance_d_red,'g')
%% adding the physical displacement during the discharge
distance_d_red = distance_d_red + d_dis_sampled;

distance_d_co2 = distance_d_co2 + d_dis_sampled;

%%
% creating plasma phase
phi_plasma = -0.3; % max co2 displacement
t_plasma_lows = [t1, 0, t_discharge, t2];
phi_plasma_lows     = [0,  0, phi_plasma, phi_plasma];

phi_plasma = interp1(t_plasma_lows,phi_plasma_lows,t_array_art);

t_decay = 1e-3;


phi_plasma = phi_plasma.*min(1,exp(-(t_array_art-t_discharge)/t_decay));
plot(51)
clf; hold on
plot(t_array_art*1e3,phi_plasma)
%%
% now lets create the phase arrays for lasers
lambda_co2 = 10.5e-6;
lambda_red = 0.639e-6;

phase_co2 = distance_d_co2 / lambda_co2 * 2*pi + phi_plasma;
phase_co2 = mod(phase_co2,2*pi);

phase_red = distance_d_red / lambda_red *2*pi;
phase_red = mod(phase_red,2*pi);

plot(52);
clf; hold on
plot(t_array_art,phase_red,'r','LineWidth',2)
plot(t_array_art,phase_co2,'k--','LineWidth',2)