clc;    %clear command line
clear all;  %clear variables
close all;  %clear figures 

%bits = [1 0 1 0 0 0 1 0 1 1 0 1 0 0 1];
bits = [0 1 1 0 0 1 0 0 1];

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

if(bits(index)==1)
    sign = -1*sign;
end

for i = 1:length(time)
    if(bits(index)==0)
        modulation(i) = 0;
    else
        modulation(i) = sign*voltage;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
        if(index <= length(bits) && bits(index)==1)
            sign = -1*sign;
        end
    end
end

plot(time,modulation,'LineWidth',3);
axis([0 endTime -voltage-5 voltage+5]);
grid on;

%Demodulation : 

index = 1;
prev = voltage;
demodulation = [];

for i = 1:length(modulation)
    if(modulation(i) == 0)
        demodulation(index) = 0;
    else
        demodulation(index) = 1;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
    end
end

disp(demodulation);

% alternate mark inversion
% zero = 0; 1 = alternate