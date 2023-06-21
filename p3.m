clc;
clear all;
close all;

bits = [1 0 1 1 0 0 1];

bitrate = 1;

sampling_rate = 100;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

% Generate carrier signals
fc0 = 5; % Frequency for bit 0
fc1 = 10; % Frequency for bit 1
carrier0 = sin(2*pi*fc0*time);
carrier1 = sin(2*pi*fc1*time);

% Modulation
modulation = zeros(1, length(time));

for i = 1:length(bits)
    if bits(i) == 1
        modulation((i-1)*sampling_rate+1:i*sampling_rate) = carrier1((i-1)*sampling_rate+1:i*sampling_rate);
    else
        modulation((i-1)*sampling_rate+1:i*sampling_rate) = carrier0((i-1)*sampling_rate+1:i*sampling_rate);
    end
end

% Plot Modulated signal
plot(time, modulation, 'LineWidth', 1);
xlabel('Time');
ylabel('Amplitude');
title('Digital-to-Analog Conversion Modulated Signal');
