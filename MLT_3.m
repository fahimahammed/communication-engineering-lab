%input_bit = [0 1 0 1 1 0 1 1];
input_bit = [1 1 1 1 1 1 1 1 0 0 0 0 0 0 1];
bit_duration = 1000;
time = 0:1:bit_duration*length(input_bit);

% modulatioin
lastLevel = -1;
previous_state = 0;
output_data = [previous_state zeros(1, bit_duration*length(input_bit))];
index = 2;
for i=1:length(input_bit)
  if input_bit(i) == 1
    if previous_state == 0 && lastLevel == -1
      previous_state = 1;
      lastLevel = 1;
    elseif previous_state == 0 && lastLevel == 1
      previous_state = -1;
      lastLevel = -1;
    else
      previous_state = 0;
    end
    for j=1:bit_duration
      output_data(index) = previous_state;
      index = index + 1;
    end
  else
    for j=1:bit_duration-1
      output_data(index) = previous_state;
      index = index + 1;
    end
  end
end
plot(time, output_data, 'LineWidth', 3);
xlim([0 length(time)]);
ylim([-1.5 1.5]);


% demodulation
demodulated_data = zeros(1, (length(output_data)-1)/bit_duration);
previous_state = output_data(1);
index = 1;
for i=2:bit_duration:length(output_data)
  if output_data(i)==previous_state
    demodulated_data(index) = 0;
    index = index + 1;
    previous_state = output_data(i);
  else
    demodulated_data(index) = 1;
    index = index + 1;
    previous_state = output_data(i);
  end
end
demodulated_data