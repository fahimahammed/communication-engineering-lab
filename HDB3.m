%High Density bipolar 3-zeros(HDB3) :

clc;    %clear command line
clear all;  %clear variables
close all;  %clear figures

%bits = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0];
bits = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
%Modulation :

bitRate = 1;
voltage = 5;

samplingRate = 1000;
samplingTime = 1/samplingRate;
endTime = length(bits)/bitRate;
time = 0:samplingTime:endTime;

modulation = zeros(1,length(time));
lastbit = -voltage;
pulse = 0;
cnt = 0;

for i = 1:length(bits)
    if(bits(i)==0)
        cnt = cnt+1;
        if(cnt==4)
            if(mod(pulse,2)==0)
                modulation((i-1-3)*samplingRate+1:(i-3)*samplingRate) = -lastbit;
                modulation((i-1-2)*samplingRate+1:(i-2)*samplingRate) = 0;
                modulation((i-1-1)*samplingRate+1:(i-1)*samplingRate) = 0;
                modulation((i-1-0)*samplingRate+1:(i-0)*samplingRate) = -lastbit;
                lastbit=-lastbit;
                pulse =0;
                cnt=0;
            else
                modulation((i-1-3)*samplingRate+1:(i-3)*samplingRate) = 0;
                modulation((i-1-2)*samplingRate+1:(i-2)*samplingRate) = 0;
                modulation((i-1-1)*samplingRate+1:(i-1)*samplingRate) = 0;
                modulation((i-1-0)*samplingRate+1:(i-0)*samplingRate) = lastbit;
                pulse =0;
                cnt=0;
            end
        end
    else
        modulation((i-1)*samplingRate+1:(i+0)*samplingRate)=-lastbit;
        lastbit=-lastbit;
        pulse = pulse+1;
        cnt=0;
    end
end

plot(time,modulation,'LineWidth',3);
axis([0 endTime -voltage-5 voltage+5]);
%ay= gca;
%ay.XGrid = 'on';
%ay.GridLineStyle = '--';
grid on;

%Demodulation : 

cnt = 0;
lastbit = -voltage;

for i = 1:length(time)
  if (time(i)>cnt)
    cnt = cnt + 1;
    if (modulation(i)==lastbit)
      demodulation(cnt-3:cnt) = 0;
    else
      if(modulation(i)==0)
        demodulation(cnt) = 0;
      else
        demodulaiton(cnt) = 1;
        lastbit = -lastbit;
      end
    end
  end
end

disp('HDB3 Decoding:');
disp(demodulation);
            