f_c = 40e6+90;
f_s = 250e6;
N_pts = 50e6;
t_arr = linspace(0,N_pts/f_s,N_pts);

driver_fake = sin(f_c*2*pi*t_arr);
driver_fake = driver_fake + 0.1*randn(size(driver_fake));
figure(82)
plot(driver_fake(1:100))
%
f_main = detect_freq(driver_fake,f_s);
%%
f_main - f_c