clear all;
close all;

bits = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
disp(bits);


bitrate  = 1;
voltage  = 5;
samplingRate = 1000;
samplingTime = 1/samplingRate;
endTime = length(bits)/bitrate;
time = 0:samplingTime:endTime;
index = 1;
count=0;
ct1 = 0;
for i=1:length(bits)
  if(bits(i)==0)
  count= count+1;
  end
if(bits(i)==1)
count=0;
ct1= ct1+1;
end
if(count==4)
	if(mod(ct1,2)==0)
		bits(i) = -1;
		bits(i-3) = 1;
		ct1= ct1+1;
    end
	if(mod(ct1,2)==1)
	  bits(i) = -1;
		ct1= ct1+1;
    end
	count=0;
end

end
disp(bits);
pre = -1; %pre means previous voltage sign...before starting the bit pattern..
if(bits(1)==1)
pre = -pre;
end
for i=1:length(time)
if(bits(index)==1)
modulation(i) = voltage*(pre);
end
if(bits(index)==0)
modulation(i) = 0;
end
if(bits(index)==-1)
modulation(i) = voltage*pre;
end
if(bitrate*time(i)>=index)
index=index+1;
if(index<=length(bits) && bits(index)==1)
pre = -pre;
end
end
end
plot(time, modulation, "LineWidth", 1);
axis([0 endTime -voltage-5 voltage+5]);
grid on;


%demodulation
index = 1;
pre = -voltage;  %previous voltage...
for i=1:length(modulation)
if(modulation(i) == 0)
demodulation(index) = 0;
end
if(modulation(i)~=0)
if(pre==modulation(i))
demodulation(index)=-1;
else
demodulation(index)=1;
end
end
if(bitrate*time(i)>=index)
if(modulation(i)~=0)
pre  = modulation(i);
end
index= index+1;
end
end
disp(demodulation);
for i=1:length(demodulation)
if(demodulation(i)==-1)
demodulation(i)=0;
demodulation(i-3)=0;
end
end
disp(demodulation);

% 000V ( odd) , B00V ( even )
% 
