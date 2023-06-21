clc;
clear all;
close all;

bits = [1 0 1 1 0 0 1];

bitrate = 1;

sampling_rate = 100;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

% Generate carrier signal
fc = 5; % Carrier frequency
carrier = sin(2*pi*fc*time);

% Generate message signal
numSamples = length(time);
numBits = length(bits);
samplesPerBit = numSamples / numBits;
samplesPerBit = ceil(samplesPerBit); % Round up to the nearest integer
message = kron(bits, ones(1, samplesPerBit));

% ASK Modulation
modulation = carrier .* message;

% Plot carrier and message signal
subplot(3, 1, 1);
plot(time, carrier, 'LineWidth', 1);
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');

subplot(3, 1, 2);
stairs(time, message, 'LineWidth', 1);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');

% Plot ASK Modulated signal
subplot(3, 1, 3);
plot(time, modulation, 'LineWidth', 1);
xlabel('Time');
ylabel('Amplitude');
title('ASK Modulated Signal');

% ASK Demodulation
demodulation = zeros(1, numBits);
threshold = 0.5;

for i = 1:numBits
    start_index = round((i-1)*samplesPerBit) + 1;
    end_index = round(i*samplesPerBit);
    demodulation(i) = mean(modulation(start_index:end_index)) > threshold;
end

disp(demodulation);
