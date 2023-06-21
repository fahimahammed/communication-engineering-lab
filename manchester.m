clc;    %clear command line
clear all;  %clear variables
close all;  %clear figures 

%bits = [1 0 1 0 0 0 1 0 1 1 0 1 0 0 1];
bits = [1 0 1 1 0 0 1]

%Modulation :

bitRate = 1;
voltage = 5;

samplingRate = 1000;
samplingTime = 1/samplingRate;
endTime = length(bits)/bitRate;
time = 0:samplingTime:endTime;

index = 1;
sign = 1;
modulation = [];

for i = 1:length(time)
    if(bits(index) == 0)
        modulation(i) = voltage;
    else
        modulation(i) = -voltage;
    end
    if(time(i)*bitRate >= index-1/2)
        modulation(i) = -modulation(i);
    end
    if(time(i)*bitRate >= index)
        index = index+1;
    end
end

plot(time,modulation,'LineWidth',3);
axis([0 endTime -voltage-5 voltage+5]);
grid on;

%Demodulation : 

index = 1;
demodulation = [];

for i = 1:length(modulation)
    if(modulation(i) == voltage && time(i)*bitRate < index-1/2)
        demodulation(index) = 0;
    end
    if(modulation(i) == -voltage && time(i)*bitRate < index-1/2)
        demodulation(index) = 1;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
    end
end

disp(demodulation);

% 1 = 1/2(-5) + 1/2(5); 0 = 1/2(5) + 1/2(-5) ( IEEE 802.3 ) (Tomas)
% Dr. Thomas== 0 = negitive to positive; 1 = positive to negitive
% IEEE 0 = positive to negative; 1 = negitive to positive