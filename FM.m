% Clear the workspace, close all figures, and clear the command window
clear all;
close all;
clc;

% Set the parameters for the modulation
carrier_amp = 1;       % Carrier signal amplitude
message_amp = 1;       % Message signal amplitude
carrier_frq = 15;      % Carrier signal frequency
message_frq = 1;       % Message signal frequency
modulation_index = 10; % Modulation index

% Set the total time and time vector
Total_time = 5;          % Total time duration
t = 0 : 0.001 : Total_time;  % Time vector

% Generate the message signal
message_signal = message_amp * cos(2 * pi * message_frq * t);

% Generate the carrier signal
carrier_signal = carrier_amp * sin(2 * pi * carrier_frq * t);

% Perform frequency modulation
modulated_signal = carrier_amp .* sin(2*pi*carrier_frq*t + (modulation_index .* sin(2*pi*message_frq*t)));

% Plot the carrier signal
subplot(411);
plot(t, carrier_signal);
title('Carrier Signal');

% Plot the message signal
subplot(412);
plot(t, message_signal);
title('Message Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

% Plot the frequency modulated signal
subplot(413);
plot(t, modulated_signal);
title('Frequency Modulated Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

% Perform demodulation using frequency discrimination
subplot(414);
demodulated_signal = fmDemod(modulated_signal);
plot(t(1:end-1), demodulated_signal);
title('Demodulated Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

% Frequency demodulation function
function m = fmDemod(s)
    x = diff(s);                  % Calculate the derivative of the modulated signal
    y = abs(x);                   % Take the absolute value of the derivative
    [b, a] = butter(10, 0.056);   % Design a low-pass filter
    m = filter(b, a, y);          % Apply the filter to obtain the demodulated signal
end
