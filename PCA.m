

subject_array = {'04','05','06','07','09','10','15'};
%subject_array = {'04'};
trial_array = {'01','02','03','04','05','06','07'};
%trial_array = {'01'};

total_data = [];

degree = 180;

for i = 1:length(subject_array)
    for j = 1:length(trial_array)
        if degree ==0
        file = ['consolidated_channel_data\',subject_array{i},'\DOE_Biomech_',subject_array{i},'_L_0_KW_',trial_array{j},'.csv']
        else
        file = ['consolidated_channel_data\',subject_array{i},'\DOE_Biomech_',subject_array{i},'_L_',num2str(degree),'_R_KW_',trial_array{j},'.csv']   
            
        end
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
   title(message)
    
    
end


joint_angles = total_data(:,end-5:end-3);
joint_torques = total_data(:,end-2:end);

% Find eigenvalues and vectors

array = table2array(channels);
x = zscore(array);
cov_data = cov(x);

[V,D] = eig(cov_data);
[eig_val,I] = sort(diag(D),'descend');
loading = V(:,I);

PCA_num = 3;
percent_var = eig_val(1:PCA_num)./sum(eig_val);
total_var_explained = sum(percent_var)
figure(2)
b = bar(percent_var);
b.FaceColor = 'flat';
colors = [1 0 0;
          0 0 1;
          .5 0 .5];
b.CData(1,:) = colors(1,:);
b.CData(2,:) = colors(2,:);
b.CData(3,:) = colors(3,:);
xlabel('PCA')
ylabel('Percent Variance')
title('Percent Variance of First 3 PCs')



for i = 1:PCA_num
    figure(i+2)
    b = bar(V(:,i));
    b.FaceColor = 'flat';
    b.CData = colors(i,:);
    xlabel('Data Features')
    message = ['Loading for PC',num2str(i)];
    title(message)


end



