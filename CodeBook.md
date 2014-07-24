Code Book
==================

The data used represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available here: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The labeled dataset is partitioned into a training set (70%) and a test set (30%) and includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the `subject` who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

**The "Inertial Signals" data sets are not used!**

Variables
-------------

For each record it is provided: 

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label 
	- WALKING
	- WALKING_UPSTAIRS
	- WALKING_DOWNSTAIRS
	- SITTING
	- STANDING
	- LAYING
- An identifier of the subject who carried out the experiment.

The complete list of all 561 features (variables) is available in `features.txt`


Data Transformation Steps
-------------
1. Merged training and test sets to create one data set.
2. Extracted only mean and standard deviation measurements.
3. Added activity column to data set. Sources are `y_train.txt` and `y_test.txt`
4. Aded subject column to data set. Sources are `subject_train.txt` and `subject_test.txt`
4. Labeled the data set with descriptive variable names. Source for those names is `features.txt`.
5. 	Calculated the average of each variable for each activity and each subject.
6. 	Stored the result in a tidy data set called `FinalTidyData.txt`