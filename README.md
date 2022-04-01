# lumbar_biofeedback

This package is used to predict lumbar bio-torque using wearable sensors. It includes both python and matlab helper functions (to manipulated c3d files and plot feedback). To use this package, Install:

Anaconda - https://docs.anaconda.com/anaconda/install/windows/

Jupyter Notebook - https://jupyter.org/install

Matlab Engine - https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html



### biofeedback_pipeline.ipynb 
This is the main code. In this code, it reads IMU data and processed bio-torque ground truth data to train a ML model (with the help of readSTO.m). Once it does this, it reads the IMU data from the specificied c3d data. It converts to the c3d into useable data (generate_feature_tables.m, generate_tables.m) for the ML algorithm to predict the bio-torque. Once the bio-torque is predicted, it calls a matlab function (plot_torque_info.m) to output visual feedback to a user.

### generate_feature_tables.m
This function generates feature tables from c3d files. In the c3d files, there is IMU data. Once extracted, the IMU data (accelerometer and gyro x,y,z) is put into features of min, max, std, mean, and end value of a window of 100ms incremented by 20ms. This is then passed back to biofeedback_pipeline.ipynb where the trained model predicts the lumbar bio-torque based on these features.

### generate_tables.m
This function creates a useable timeseries table of desired IMU data. It is the same as generate_feature_tables.m except it creates timeseries tables instead of a feature table. In the future, a temporal nueral network will be used instead of the current ML algorithm (Extreme Gradient Boost) and this algorithm requires timeseries data instead of feature tables. 

### ReadSTO.m
This function is used to read a .sto file. The ground truth torque values are stored in this file type and this matlab function reads it and pass it back to biofeedback_pipeline.ipynb (not needed for pipeline unless you want to plot ground truth over the predicted value)

### bio_torque_XGB_LUMBAR_SUB_IND_v2.ipynb

This notebook is used to analyze the subject independent performance of the XGBoost algorithm. This script was used to establish how to set up the model and therefore is similar to the code found in biofeedback_pipeline.ipynb (not needed by pipeline)

### bio_torque_ML_overview.ipynb

This notebook was used to test linear regression, nueral networks, and XGBoost performance on the dataset to predict human bio-torque. It was one of the first notebooks made and was used to establish what model to use for the bio-torque predictions. (not needed by pipeline)
