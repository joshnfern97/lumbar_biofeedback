function [result] = generate_feature_tables(c3dFilePath, degree )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

c3dFile = btkReadAcquisition(c3dFilePath); % read C3D file
analogs = btkGetAnalogs(c3dFile); % import analog data


%Get FP for Right and Left Foot
if degree == 180
    disp('Reading FP for 180 degree lift')
    right_FP_x = analogs.Force_Fx6;
    right_FP_y = analogs.Force_Fy6;
    right_FP_z = analogs.Force_Fz6;
    
    left_FP_x = analogs.Force_Fx8;
    left_FP_y = analogs.Force_Fy8;
    left_FP_z = analogs.Force_Fz8;
    
end

if degree == 90
    disp('Reading FP for 90 degree lift')
    right_FP_x = analogs.Force_Fx5;
    right_FP_y = analogs.Force_Fy5;
    right_FP_z = analogs.Force_Fz5;
    
    left_FP_x = analogs.Force_Fx8;
    left_FP_y = analogs.Force_Fy8;
    left_FP_z = analogs.Force_Fz8;
    
end

if degree == 0
    disp('Reading FP for 0 degree lift')
    right_FP_x = analogs.Force_Fx7;
    right_FP_y = analogs.Force_Fy7;
    right_FP_z = analogs.Force_Fz7;
    
    left_FP_x = analogs.Force_Fx8;
    left_FP_y = analogs.Force_Fy8;
    left_FP_z = analogs.Force_Fz8;
    
end


%Get Data from Shank IMU
shank_acc_x = analogs.Sensor_1_Acc_ACCX1;
shank_acc_y = analogs.Sensor_1_Acc_ACCY1;
shank_acc_z = analogs.Sensor_1_Acc_ACCZ1;
shank_gyro_x = analogs.Sensor_1_Gyro_GYROX1;
shank_gyro_y = analogs.Sensor_1_Gyro_GYROY1;
shank_gyro_z = analogs.Sensor_1_Gyro_GYROZ1;

%Get Data from Foot IMU
foot_acc_x = analogs.Sensor_2_Acc_ACCX2;
foot_acc_y = analogs.Sensor_2_Acc_ACCY2;
foot_acc_z = analogs.Sensor_2_Acc_ACCZ2;
foot_gyro_x = analogs.Sensor_2_Gyro_GYROX2;
foot_gyro_y = analogs.Sensor_2_Gyro_GYROY2;
foot_gyro_z = analogs.Sensor_2_Gyro_GYROZ2;

%Get Data from Thigh IMU
thigh_acc_x = analogs.Sensor_5_Acc_ACCX5;
thigh_acc_y = analogs.Sensor_5_Acc_ACCY5;
thigh_acc_z = analogs.Sensor_5_Acc_ACCZ5;
thigh_gyro_x = analogs.Sensor_5_Gyro_GYROX5;
thigh_gyro_y = analogs.Sensor_5_Gyro_GYROY5;
thigh_gyro_z = analogs.Sensor_5_Gyro_GYROZ5;

%Get Data from torso IMU
torso_acc_x = analogs.Sensor_6_Acc_ACCX6;
torso_acc_y = analogs.Sensor_6_Acc_ACCY6;
torso_acc_z = analogs.Sensor_6_Acc_ACCZ6;
torso_gyro_x = analogs.Sensor_6_Gyro_GYROX6;
torso_gyro_y = analogs.Sensor_6_Gyro_GYROY6;
torso_gyro_z = analogs.Sensor_6_Gyro_GYROZ6;




feature_col_1 = {'min_','max_', 'mean_', 'std_', 'end_'};
feature_col_2 = {'right_FP_x', 'right_FP_y', 'right_FP_z', ...
          'left_FP_x', 'left_FP_y', 'left_FP_z', ...
          'shank_acc_x', 'shank_acc_y', 'shank_acc_z', 'shank_gyro_x', 'shank_gyro_y', 'shank_gyro_z' ,...
          'foot_acc_x', 'foot_acc_y', 'foot_acc_z', 'foot_gyro_x', 'foot_gyro_y', 'foot_gyro_z', ...
          'thigh_acc_x', 'thigh_acc_y', 'thigh_acc_z', 'thigh_gyro_x', 'thigh_gyro_y', 'thigh_gyro_z', ...
          'torso_acc_x', 'torso_acc_y', 'torso_acc_z', 'torso_gyro_x', 'torso_gyro_y', 'torso_gyro_z'};
      
%start_lift = data.start_lift(1);
%end_lift = data.end_lift(1);

feature_column_names = {};

for i=1:length(feature_col_2)
    for j = 1:length(feature_col_1)

  
       feature_column_names = horzcat(feature_column_names,[feature_col_1{j},feature_col_2{i}]);
       
   end
    
end

window_start = 1;
window = 200; %2000 Hz so 200 samples for 100 milliseconds
increment = 40; %increment by 20 ms
window_end= window_start+window;

data = [right_FP_x, right_FP_y, right_FP_z, ...
      left_FP_x, left_FP_y, left_FP_z, ...
      shank_acc_x, shank_acc_y, shank_acc_z, shank_gyro_x, shank_gyro_y, shank_gyro_z ,...
      foot_acc_x, foot_acc_y, foot_acc_z, foot_gyro_x, foot_gyro_y, foot_gyro_z, ...
      thigh_acc_x, thigh_acc_y, thigh_acc_z, thigh_gyro_x, thigh_gyro_y, thigh_gyro_z, ...
      torso_acc_x, torso_acc_y, torso_acc_z, torso_gyro_x, torso_gyro_y, torso_gyro_z];

N_features = length(feature_column_names);

row_number = floor((size(data,1)-window)/increment)+1;

feature_table = zeros(row_number, N_features);


for j = 1:row_number
feature_row =zeros(1,N_features);


    
    
feature_row(1:length(feature_col_1):end) = min(data(window_start:window_end-1,:),[],1);
feature_row(2:length(feature_col_1):end) = max(data(window_start:window_end-1,:),[],1);
feature_row(3:length(feature_col_1):end) = mean(data(window_start:window_end-1,:),1);
feature_row(4:length(feature_col_1):end) = std(data(window_start:window_end-1,:),[],1);
feature_row(5:length(feature_col_1):end) = data(window_end-1,:);

    

feature_table(j,:) = feature_row;
window_start = window_start + increment;
window_end = window_start+window;


end




      
result = {feature_table, feature_column_names};


end