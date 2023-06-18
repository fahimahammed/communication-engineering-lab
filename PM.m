% Clear the workspace, close all figures, and clear the command window
clear all;
close all;
clc;

% Set the parameters for the carrier and message signals
carrierAmp = 1;          % Carrier signal amplitude
messageAmp = 1;          % Message signal amplitude
carrierFrq = 15;         % Carrier signal frequency
messageFrq = 1;          % Message signal frequency

% Modulation index, best if 1/2
% modulationIndex = messageAmp / carrierAmp;
modulationIndex = 10;

TotalTime = 5;
t = 0 : 0.001 : TotalTime;

messageSignal = messageAmp * cos(2 * pi * messageFrq * t);
% messageSignal = messageAmp * sin(2 * pi * messageFrq * t) + messageAmp * cos(2 * pi * messageFrq/2 * t);

carrierSignal = carrierAmp * sin(2 * pi * carrierFrq * t);

modulatedSignal = carrierAmp .* sin(2*pi*carrierFrq*t + (modulationIndex .* cos(2*pi*messageFrq*t)));


subplot(411);
plot(t, carrierSignal);
title('Carrier Signal');

subplot(412);
plot(t, messageSignal);
title('Message Signal');
line ([0, TotalTime], [0 0], "linestyle", "--", "color", "r");

subplot(413);
plot(t, modulatedSignal);
title('Phase Modulated Signal');
line ([0, TotalTime], [0 0], "linestyle", "--", "color", "r");


demodulatedSignal = pmDemod(modulatedSignal);
subplot(414);
plot(t(1:end-1), demodulatedSignal);
title('Demodulated Signal');
line ([0, TotalTime], [0 0], "linestyle", "--", "color", "r");


function m = pmDemod(s)
    % Perform phase demodulation
    x = diff(s);
    y = abs(x);
    [b, a] = butter(10, 0.056);
    m = filter(b, a, y);
end
