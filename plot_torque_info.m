function [done] = plot_torque_info(predicted_torque,peak_values)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
figure(1) 
data = cell2mat(predicted_torque);
window_increment = 0.02;
start_time = 0.1;

save('predicted_torque_ex','predicted_torque')
time_steps = start_time:window_increment:(length(data)-1)*window_increment+start_time;
plot(time_steps, data,'LineWidth',2)
xlabel('Time [s]')
ylabel('Lumbar Bio-Torque')
ax = gca;
ax.FontSize = 16; 

%Find Peak Torque of the last trial
figure(2)
labels = {};
for i = 1:length(peak_values)
    labels{i} = ['Trial ', num2str(i)];
    
end
bar_data = cell2mat(peak_values);
bar(bar_data)
set(gca, 'XTick', 1:length(labels),'XTickLabel',labels);
ax1 = gca;
ax1.FontSize = 16; 
ymin = min(bar_data)-5;
ymax = max(bar_data)+5;
ylim([ymin,ymax])
title('Peak Lumbar Bio-Torque for Each Trial')



if length(peak_values)>1
    figure(3)    
    torque_change = bar_data(end-1)-bar_data(end);

    plot(diff(bar_data))
    set(gca, 'XTick', 1:length(labels(2:end)),'XTickLabel',labels(2:end));
    message = ["Change in Torque: ", num2str(torque_change)];
    title(message);
end

done =1;
end

