clear all;
close all;
clc;

bits = [1 0 1 0 0 1 1 0 1 1 0 0 1];
bit_duration = 2;

fs = 100;
Total_time = length(bits) * bit_duration;   %# time needed to send whole data
time = 0: 1/fs: Total_time;


amplitude = 2;
f = 0.5;
carrier_signal = amplitude * sin(2 * pi * f * time);

%plot(time, carrier_signal);

idx = 1;
modulated_carrier_signal = carrier_signal;
for i = 1 : length(carrier_signal)
     if bits(idx) == 0
        modulated_carrier_signal(i) = modulated_carrier_signal(i) * (-1);
     end
     if time(i)/bit_duration >= idx
        idx = idx + 1;
     end
end


%# ploting
plot(time, modulated_carrier_signal);
xticks([0: bit_duration: Total_time]);
yticks([-amplitude-2: 2: amplitude+2]);
ylim([-amplitude-2, amplitude+2]);
xlim([0, Total_time]);
grid on;
title("PSK");
xlabel("Time");
ylabel("Amplitude");
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

% Top axis
ax1=gca;
ax2 = axes('Position', get(ax1, 'Position'), 'Color', 'none');
set(ax2, 'XAxisLocation', 'top');
set(ax2, 'XLim', get(ax1, 'XLim'));
set(ax2, 'YLim', get(ax1, 'YLim'));
set(ax2, 'XTick', [bit_duration/2: bit_duration: Total_time]);
set(ax2, 'YTick', [-amplitude-2: 2: amplitude+2]);
set(ax2, 'XTickLabel', bits);
%set(ax2, 'XLabel', 'Data bits');




%Demodulation
demodulated = [];
idx = 1;
for i = 1 : length(time)
    if time(i)/bit_duration >= idx
        data = modulated_carrier_signal(i);

        if data == carrier_signal(i)
            demodulated(idx) = 1;
        else
            demodulated(idx) = 0;
        end
        idx = idx + 1;
    end
end

disp("Orginal bits:");
disp(bits);

disp("Demodulation:");
disp(demodulated);