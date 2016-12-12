## Code Book 

We describe here the variables, the dataset, and the transformations performed to clean up and organise the data. The goal of this project is to prepare tidy data that can be used for later analysis. 

### Dataset info

* The dataset can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*  A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Dataset files 

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used in the feature vector.

- 'features.txt': List of all features measured.

- 'activity_labels.txt': Links the class labels with their activity name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

The script download the dataset in the working directory (only if it has not been previously downloaded, to make to code faster).

### Data trasformations
 The code perform the following manipulations:

1- Merges the training and the test sets to create one data set.

2- Extracts only the measurements on the mean and standard deviation for each measurement.

3- Uses descriptive activity names to name the activities in the data set.

- WALKING (value 1)
- WALKING_UPSTAIRS (value 2)
- WALKING_DOWNSTAIRS (value 3)
- SITTING (value 4)
- STANDING (value 5)
- LAYING (value 6)

4- Appropriately labels the data set with descriptive variable names.
In particular we define:
- t, time;
- f, frequency
- Acc, accelerometer;
- Gyro, gyroscope;
- BodyBody, Body;
- Mag, magnitude.

5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The code saves the tidy data in the "tidydata.txt" within the working directory.
