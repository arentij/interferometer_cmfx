% % Parameters
% num_samples = 1000;  % Number of samples
% voltage_range = 5;  % Voltage range (e.g., -5V to +5V)
% resolution = 12;     % ADC resolution
% 
% % Generate a voltage signal (e.g., sine wave)
% t = linspace(0, 1, num_samples);  % Time vector
% voltage_signal = voltage_range/2 * sin(2*pi*5*t);  % Example sine wave
% 
% % Simulate quantization (mapping to 12-bit values)
% quantized_values = round((voltage_signal + voltage_range/2) / voltage_range * (2^resolution - 1));
% 
% % Add noise (optional)
% % noise = randn(size(quantized_values)) * (1/(2^(resolution+1))); % Gaussian noise with standard deviation proportional to quantization step
% % quantized_values = quantized_values + noise;
% 
% % Plot the original signal and the quantized signal
% figure;
% plot(t, voltage_signal, 'b', t, quantized_values * voltage_range / (2^resolution - 1) - voltage_range/2, 'r');
% xlabel('Time');
% ylabel('Voltage');
% legend('Original Signal', 'Quantized Signal');
% title('Original vs Quantized Signal');

fs = 12.5e6;
fc_red = -40e6 + 100*randn();
fc_co2 =  40e6 + 100*randn();

t1 = 0e-3;
t_total = 0.1e-3;
t2 = t1 + t_total;

t_array_art = linspace(t1,t2,fix(fs*t_total));

v_red = 2+ 400e-3 * sin(2*pi*fc_red*t_array_art);

v_red_q = quantize(v_red);

figure(53);
clf
hold on
plot(t_array_art,v_red)
plot(t_array_art,v_red_q)

