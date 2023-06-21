clc;    %clear command line
clear all;  %clear variables
close all;  %clear figures 

bits = [1 0 1 0 0 0 1 0 1 1 0 1 0 0];

%Modulation :

bitRate = 1;
voltage = 5;

samplingRate = 1000;
samplingTime = 1/samplingRate;
endTime = length(bits)/bitRate;
time = 0:samplingTime:endTime;
disp(time);
sign = 1;
index = 1;
modulation = [];

if(bits(index) == 1)
    sign = -1*sign;
end

for i = 1:length(time)
    modulation(i) = sign * voltage;
    
    if(time(i)*bitRate>= index)
        index = index+1;
        if(index <= length(bits) && bits(index) == 1)
            sign = -1*sign;
        end
    end
end

plot(time,modulation,'LineWidth',3);
axis([0 endTime -voltage-5 voltage+5]);
grid on;

%Demodulation : 

index = 1;
value = voltage;
demodulation = [];

for i = 1:length(modulation)
    if(modulation(i) == value)
        demodulation(index) = 0;
    else
        demodulation(index) = 1;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
        value = modulation(i);
    end
end

disp(demodulation);

% 1 = state change ( stat at -5 ) ; 0 = no change 