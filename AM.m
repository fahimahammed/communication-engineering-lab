clc;
clear all;
close all;

% Modulation
amplitude = 1;         % Carrier signal amplitude
fc = 100;              % Carrier frequency
fm = 10;               % Message signal frequency
t = 0:0.001:1;
message = sin(2*pi*fm*t);  % Message signal

carrier = amplitude*sin(2*pi*fc*t);  % Carrier signal
modulated = (1 + message).*carrier;  % Modulated signal

% Demodulation
demodulated = modulated./carrier;   % Demodulated signal

% Plotting
subplot(4,1,1);
plot(t, carrier);
title('Carrier Signal');

subplot(4,1,2);
plot(t, message);
title('Message Signal');

subplot(4,1,3);
plot(t, modulated);
title('Modulated Signal');

subplot(4,1,4);
plot(t, demodulated);
title('Deodulated Signal');
