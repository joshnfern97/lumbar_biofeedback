# lumbar_biofeedback

This package is used to predict lumbar bio-torque using wearable sensors. It includes both python and matlab helper functions (to manipulated c3d files and plot feedback). 

## biofeedback_pipeline.ipynb 
This is the main code. In this code, it reads IMU data and processed bio-torque ground truth data to train a ML model (with the help of readSTO.m). Once it does this, it reads the IMU data from the specificied c3d data. It converts to the c3d into useable data (generate_feature_tables.m, generate_tables.m) for the ML algorithm to predict the bio-torque. Once the bio-torque is predicted, it calls a matlab function (plot_torque_info.m) to output visual feedback to a user.

## generate_feature_tables.m
This function generates feature tables from c3d files. In the c3d files, there is IMU data. Once extracted, the IMU data (accelerometer and gyro x,y,z) is put into features of min, max, std, mean, and end value of a window of 100ms incremented by 20ms. This is then passed back to biofeedback_pipeline.ipynb where the trained model predicts the lumbar bio-torque based on these features.

## generate_tables.m
This function creates a useable timeseries table of desired IMU data. It is the same as generate_feature_tables.m except it creates timeseries tables instead of a feature table. In the future, a temporal nueral network will be used instead of the current ML algorithm (Extreme Gradient Boost) and this algorithm requires timeseries data instead of feature tables. 

## ReadSTO.m
This function is used to read a .sto file. The ground truth torque values are stored in this file type and this matlab function reads it and pass it back to biofeedback_pipeline.ipynb
