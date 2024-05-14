% Define sampling frequency and frequency range of interest
fs = 500e6; % Sampling frequency (500 MHz)
f_center = 40e6; % Center frequency (40 MHz)
f_bandwidth = 5e6; % Bandwidth (±5 MHz)

% Generate a sample signal (for demonstration purposes)
t = 0:1/fs:1e-6; % Time vector (1 second duration)
x = cos(2*pi*f_center*t); % Sample signal (40 MHz cosine wave)

x = x + 2*cos(2.1*2*pi*f_center*t) + 0.1*randn(size(x));

% Design a bandpass filter to retain frequencies within the desired range
bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
         'CutoffFrequency1',f_center-f_bandwidth,'CutoffFrequency2',f_center+f_bandwidth, ...
         'SampleRate',fs);

% Apply the bandpass filter to the signal
filtered_signal = filter(bpFilt, x);

% Plot the original and filtered signals
figure;
subplot(2,1,1);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
