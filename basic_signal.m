% Generate an analog signal (sine wave)
t = 0:0.001:1; % Time vector from 0 to 1 second with a step size of 0.001
f1 = 5; % Frequency of the analog signal (in Hz)
A1 = 1; % Amplitude of the analog signal
analog_signal = A1 * sin(2*pi*f1*t);

% Generate a digital signal (square wave)
f2 = 10; % Frequency of the digital signal (in Hz)
duty_cycle = 0.5; % Duty cycle of the square wave (50%)
digital_signal = square(2*pi*f2*t, duty_cycle);

% Create a composite signal by adding the analog and digital signals
composite_signal = analog_signal + digital_signal;

% Plot the signals
figure;

subplot(3,1,1);
plot(t, analog_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Analog Signal (Sine Wave)');

subplot(3,1,2);
plot(t, digital_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Digital Signal (Square Wave)');

subplot(3,1,3);
plot(t, composite_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Composite Signal');
