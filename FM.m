% Clear the workspace, close all figures, and clear the command window
clear all;
close all;
clc;

% Set the parameters for the modulation
carrierAmp = 1;          % Carrier signal amplitude
messageAmp = 1;          % Message signal amplitude
carrierFrq = 15;         % Carrier signal frequency
messageFrq = 1;          % Message signal frequency
modulationIndex = 10;    % Modulation index

% Set the total time and time vector
totalTime = 5;                  % Total time duration
t = 0 : 0.001 : totalTime;      % Time vector

% Generate the message signal
messageSignal = messageAmp * cos(2 * pi * messageFrq * t);

% Generate the carrier signal
carrierSignal = carrierAmp * sin(2 * pi * carrierFrq * t);

% Perform frequency modulation
modulatedSignal = carrierAmp .* sin(2*pi*carrierFrq*t + (modulationIndex .* sin(2*pi*messageFrq*t)));

% Plot the carrier signal
subplot(411);
plot(t, carrierSignal);
title('Carrier Signal');

% Plot the message signal
subplot(412);
plot(t, messageSignal);
title('Message Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Plot the frequency modulated signal
subplot(413);
plot(t, modulatedSignal);
title('Frequency Modulated Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Perform demodulation using frequency discrimination
subplot(414);
demodulatedSignal = fmDemod(modulatedSignal);
plot(t(1:end-1), demodulatedSignal);
title('Demodulated Signal');
line ([0, totalTime], [0 0], "linestyle", "--", "color", "r");

% Frequency demodulation function
function demodulatedSignal = fmDemod(modulatedSignal)
    derivative = diff(modulatedSignal);                   % Calculate the derivative of the modulated signal
    absoluteDerivative = abs(derivative);                  % Take the absolute value of the derivative
    [b, a] = butter(10, 0.056);                            % Design a low-pass filter
    demodulatedSignal = filter(b, a, absoluteDerivative);  % Apply the filter to obtain the demodulated signal
end
