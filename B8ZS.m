clear all;
close all;
clc;

bits = [1 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1];
voltage = 3;

zero_cnt = 0;
prv_nonzero_voltage = -voltage;
modulated = [];
for i = 1 : length(bits)
    if bits(i) == 0
        zero_cnt = zero_cnt + 1;
    else
        modulated(i) = -prv_nonzero_voltage;
        prv_nonzero_voltage = -prv_nonzero_voltage;
        zero_cnt = 0;
    end
    if zero_cnt == 8
        modulated(i-4) = prv_nonzero_voltage;
        modulated(i-3) = -prv_nonzero_voltage;
        modulated(i-1) = -prv_nonzero_voltage;
        modulated(i) = prv_nonzero_voltage;
        zero_cnt = 0;
    end
end
%disp(modulated);

bit_duration = 2;
fs = 100;
Total_time = length(bits) * bit_duration;   % time needed to send whole data
time = 0: 1/fs: Total_time;

idx = 1;
signal = [];
for i = 1 : length(time)
    signal(i) = modulated(idx);
    if time(i) / bit_duration >= idx
        idx = idx + 1;
    end
end

% ploting
plot(time, signal);
xticks([0: bit_duration: Total_time]);
yticks([-voltage-2: 2: voltage+2]);
ylim([-voltage-2, voltage+2]);
xlim([0, Total_time]);
grid on;
title("B8ZS");
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
set(ax2, 'YTick', [-voltage-2: 2: voltage+2]);
set(ax2, 'XTickLabel', bits);
set(ax2, 'XLabel', 'Data bits');



%Demodulation
demodulated = [];
idx = 1;
prv_nonzero_voltage = -voltage;
for i = 1 : length(time)
    if time(i)/bit_duration >= idx
        data = signal(i);

        if data == 0
            demodulated(idx) = 0;
        elseif (data == prv_nonzero_voltage)
            demodulated(idx) = 0;
            demodulated(idx+1) = 0;
            demodulated(idx+3) = 0;
            demodulated(idx+4) = 0;

            idx = idx + 4;
        else
            demodulated(idx) = 1;
            prv_nonzero_voltage = -prv_nonzero_voltage;
        end
        idx = idx + 1;
    end
end

disp("Orginal bits:");
disp(bits);

disp("Demodulation:");
disp(demodulated);