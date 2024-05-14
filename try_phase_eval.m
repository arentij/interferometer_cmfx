% try FFT phase detection
fs = 125e6;
dt = 3e-6;
t_arr = linspace(0,dt,fix(dt*fs));
fc = 40e6+136;
dph = pi/4;

signal = sin(2*pi*fc*t_arr+dph);
driver = sin(2*pi*fc*t_arr);

sig_fft = fft(signal); 

figure(400)
clf; hold on
plot(abs(sig_fft))

figure(401)
clf; hold on
plot(unwrap(angle(sig_fft)))