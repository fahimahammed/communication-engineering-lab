% Clear the workspace, close all figures, and clear the command window
clear all;
close all;
clc;

% Set the parameters for the carrier and message signals
carrierAmp = 1;          % Carrier signal amplitude
messageAmp = 1;          % Message signal amplitude
carrierFrq = 15;         % Carrier signal frequency
messageFrq = 1;          % Message signal frequency

% Set the total time and time vector
totalTime = 5;
t = 0 : 0.001 : totalTime;

% Generate the message signal as a combination of sine and cosine waves
messageSignal = messageAmp * sin(2 * pi * messageFrq * t) + messageAmp * cos(2 * pi * messageFrq/2 * t);

% Generate the carrier signal
carrierSignal = carrierAmp * sin(2 * pi * carrierFrq * t);

% Perform amplitude modulation
modulatedSignal = (carrierAmp + messageSignal) .* carrierSignal;

% Perform amplitude demodulation
demodulatedSignal = amDemod(modulatedSignal, carrierFrq, messageFrq, length(t));

% Plot the carrier signal
subplot(411);
plot(t, carrierSignal);
title('Carrier Signal');

% Plot the message signal
subplot(412);
plot(t, messageSignal);
title('Message Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Plot the amplitude modulated signal
subplot(413);
plot(t, modulatedSignal);
title('Amplitude Modulated Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Plot the amplitude demodulated signal
subplot(414);
plot(t, demodulatedSignal);
title('Amplitude Demodulated Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Function for amplitude demodulation
function demodulatedSignal = amDemod(s, fc, fs, n)
    % Rectify the modulated signal
    s = abs(s);
    % Set the number of samples on which to do the moving average
    k = round(n * fs / fc);
    % Take the moving average
    demodulatedSignal = movmean(s, k);
    % Remove the DC offset
    demodulatedSignal = demodulatedSignal - mean(demodulatedSignal);
end
