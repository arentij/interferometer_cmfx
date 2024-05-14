file_name = 'mar27/RigolDS3.csv';
data1 = readmatrix(file_name);
%
data = [data1(1:end,1:4)];
%%

parse_fname;
fs = 12.5e6;
clear_figs = 1;
phase_switch = 1;
phase_rec2;

%%
lambda1 = 10.3e-6;
lambda2 = 0.639e-6;

distance_co2 = unwrap(rec_phase_arr_c)/2/pi*lambda1;
distance_co2 = distance_co2 - mean(distance_co2);
distance_co2 = distance_co2*1e6;

k = 1.0;
distance_red = -1/k*unwrap(k*rec_phase_arr_r)/2/pi*lambda2;
distance_red =distance_red -distance_red(fix(end/2));
distance_red =distance_red -mean(distance_red);
distance_red =distance_red *1e6;


%%
figure(plot_index+16)
clf
hold on

set(gca,'FontSize',20,'LineWidth',2)

xlabel('$t, s$','Interpreter','latex','FontSize',35);
ylabel('$L, \mu m$','Interpreter','latex','FontSize',35);
% ylabel('$\Delta X, nm$','Interpreter','latex','FontSize',35);
title(['$Reconstructed ~phase ~$', num2str(plot_index); string(datetime) ],'Interpreter','latex','FontSize',35); 
box on

plot(t_rec_phase_c,distance_co2,'k','LineWidth',1)
plot(t_rec_phase_r,distance_red,'r--','LineWidth',1)
legend({'CO2','Red'})


%%
x = distance_red;
y = distance_co2;
X = [ones(length(x),1) x];
b = X\y


figure(127)
clf
hold on
difference = distance_co2-distance_red;
diff_lp = movmean(difference,50);
plot(t_rec_phase_r,difference)
plot(t_rec_phase_r,diff_lp,'LineWidth',2)
