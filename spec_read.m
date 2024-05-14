%% the spectrometer clips at 4000 counts 
% plasma:
% file 886 -20 kV discharge with 200 ms 
% no plasma:
% 20 - the flashlight in the face through the fiber, 5 ms
% 21 - the flashlight in the face without the fiber, 5 ms
% 22 - daylight sky 6 pm 100 ms
% 23 - daylight sky 6 pm 100 ms
% 24 - helium lamp 100 ms
% 25 - helium lamp 3 ms

% for some reason there is a 100 count base line, idk why

% the "*_spectrometer.csv" files contain a line of indecies, a line of wavelengths
% and N lines of actual data

% the "*_spectrometer_log.csv contains the time of the first spectra and
% times in ms after the first one of the corresponding line


spectr_data_file = 'apr17/2024_04_17/CMFX_00887_spectrometer.csv';
spectr_data = readmatrix(spectr_data_file);

spectr_data_log_file = [spectr_data_file(1:end-4), '_log.csv']
spectr_log  = readmatrix(spectr_data_log_file);
cmfx_i = strfind(spectr_data_file,'CMFX_');
plot_index = str2num(spectr_data_file(cmfx_i+5:cmfx_i+9))*100;


waves = spectr_data(2,:);

inten = spectr_data(3:end,:);

figure(plot_index);
clf
hold on
for i = 1:3
    plot(waves,inten(i,:)-0*inten(end,:))
end

figure(91)
waterfall([1:size(inten,1)]*10,waves,inten'-0*inten(end,:)')
