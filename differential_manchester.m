clc;    %clear command line
clear all;  %clear variables
close all;  %clear figures 

bits =[1 0 1 0 0 0 1 0 1 1 0 1 0 0 1];

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

if(bits(index)==0)
    sign = -1*sign;
end

for i = 1:length(time)
    if(time(i)*bitRate < index-1/2)
        modulation(i) = sign*voltage;
    else
        modulation(i) = -sign*voltage;
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
    if(modulation(i) == prev && time(i)*bitRate < index-1/2)
        demodulation(index) = 1;
    end
    if(modulation(i) ~=prev && time(i)*bitRate < index-1/2)
        demodulation(index) = 0;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
        prev = modulation(i);
    end
end

disp(demodulation);