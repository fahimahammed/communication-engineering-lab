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
% sign = 1;
index = 1;
modulation = [];

for i = 1:length(time)
    if(bits(index) == 1)
        modulation(i) = voltage;
    else
        modulation(i) = -voltage;
    end

    if(time(i)*bitRate>= index-1/2)
        modulation(i)=0;
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
%value = voltage;
demodulation = [];

for i = 1:length(modulation)
    if(modulation(i) == voltage)
        demodulation(index) = 1;
    end
    if(modulation(i) == -voltage)
        demodulation(index) = 0;
    end
    if(time(i)*bitRate >= index)
        index = index+1;
        %value = modulation(i);
    end
end

disp(demodulation);