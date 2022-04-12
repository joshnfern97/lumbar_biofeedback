%% 0 Degree Lifts

%subject_array = {'04','05','06','07','09','10','15'};
subject_array = {'04'};
% trial_array = {'01','02','03','04','05','06','07'};
trial_array = {'01'};

total_data = [];


for i = 1:length(subject_array)
    for j = 1:length(trial_array)
        file = ['consolidated_channel_data\',subject_array{i},'\DOE_Biomech_',subject_array{i},'_L_0_KW_',trial_array{j},'.csv']
        data = readtable(file);


        total_data = [total_data;data];
    end
end
%%
% channels1 = total_data(:,1:end-12);
% channels2 = total_data(:,end-11:end-6);
% channels = [channels2,channels1];
channels = total_data(:,1:end-6);

headers = channels.Properties.VariableNames;
figure(1)
for i = 1:length(headers)
   subplot(5,6,i)
   name = headers{i};
   plot(channels.(name))
   message = [name, ':',num2str(i)];
   title(messagePCA)
    
    
end


joint_angles = total_data(:,end-5:end-3);
joint_torques = total_data(:,end-2:end);

% Find eigenvalues and vectors

array = table2array(channels);
x = zscore(array)
cov_data = cov(x);

[V,D] = eig(cov_data);
[eig_val,I] = sort(diag(D),'descend');
loading = V(:,I);

percent_var = eig_val(1:3)./sum(eig_val);
figure(2)
bar(percent_var)
title('Percent Variance of First 3 PCs')


%Plot Loading of PC1
figure(3)
bar(V(:,1))
xlabel('Data Features')
title('Loading for PC1')
figure(4)
bar(V(:,2))
xlabel('Data Features')
title('Loading for PC2')




