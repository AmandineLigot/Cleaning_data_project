# Introduction #

The data are obtained via this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This analysis takes the data fom the following dataset:

Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


# Presentation of the original data set #

For either the test set or training set, there are 561 columns gathering the following information:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

**Features are normalized and bounded within [-1,1]. So none of the variables have units.**

# Analysis of the data set#

The aim of this analysis is to create a tidy data set that gathers the average of each chosen variables in function of the subject and the activity.
The analysis is made with **run_analysis.R**. The script should be copied in the folder named "UCI HAR Dataset" in order to be able to run.

## First step ##

The first part is to read all the following text files: 

- 'features.txt': List of all features. It will be used to name the columns of the data sets.

- 'activity_labels.txt': Links the class labels with their activity name. It is matrix of 6 lines and 2 columns.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels. It is given the subject number for each lines.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels. It is given the subject number for each lines.

And then bind the training set and test test to get one data.frame named **tot_data**. It contains 561 columns and 10299 rows.
After that, the activity labels and the subject labels were put all together in one matrix called **tot**. It has two coloumns called Subject and Activity  and 10299 rows.

## Second step ##

For the rest ofthe analysis we are only interested by the measurements on the mean and standard deviation for each measurement.
To do that the function *grepl* is used in order to eliminate all the columns that do not contain the name *mean* or *std*.
A second step is needed in order to remove the columns that have the name *meanFreq*. This was removed because it gave information about the mean frequency that was used for the measurements but nothing about the mean of the measurement itself.
At the end, the matrix **tot_data** contains 66 columns and 10299 rows.

## Third step ##

Then the **tot** matrix was added to the data set (**tot_data**). In that way, information about the subjects and the activity were together with the measurements. It was added with the function cbind() in such a way that the columns Subject and Activity are the first two columns.
The **tot_data** was then rearranged in ascending order of Subject and Activity.
Because the activity label is at that point only numbers between 1 to 6, a *for* loop was constructed in order to replace these numbers by the actual activity description. This description can be found in the table **activity**.

## Fourth step ##

Because the variables names were not really explicit, some part of them was changed.

 * All the variables that begin by "t" were changed to "Time"
 * All the variables that begin by "f" were changed to "Freq"
 * A few variables contained a typo: there were two times "Body" in the variable name. This was rectified by putting only one time "Body" in the variable name.
 * All the variables that contain "mean" were changed to "Mean"
 * All the variables that contain "std" were changed to "Std"
 * All the points are removed
 * Then to use the lecture, underscores were used in between words

The variables name look like this after this step : **Time_Body_Acc_Mean_X**

## Fifth step ##

The data set was grouped by Subject and Activity. After this step the data set is called **grouped**.
Using this grouped data set, the average of each measurement was calculated for each subject and each activity. After this step the data set contains 68 columns and 180 rows.
This data set is then written in a text file named **tidy_set.txt**. This is the output of the script.

# Structure of tidy_set.txt #

## Variables names' definition ##

In this part, the structure of the output file is explained.
At first, we will summarize the definition of all the token used in the variables names.

Token         | Definition
------------- | -------------
Time          | Measurement based on "time" domain.They were captured at a constant rate of 50 Hz.Then they were                    filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of                20 Hz to remove noise.
Freq          | Measurement based on "frequency" domain.They were obtained by applying a Fast Fourrier Transform                     (FFT) to the time-based signals
Body          | Signal based on the body of a subject. It is derived from the time-based signals obtained by the accelerometer of the phone.
Gravity       | Signal based on gravity. It is the second signal derived from the data obtain from the phone's accelerometer
Acc           | Data obtained by the phone's accelerometer
Gyro          | Data obtained by the phone's gyroscope
Jerk          | Derivation in time of the body linear acceleration and the angular speed in order to obtain a Jerk signal
Mag           | Magnitude of the signals calculated using the Euclidean norm
X/Y/Z         | The signals obtained by the phone's accelerometer and gyroscope are 3-axial data: X, Y and Z
Mean          | Average of the signal
Std           | Standard deviation of the signal

**All the variables of the tidy_set are without units because the calculation was made from data that were normalized.**

## Variables list ##

You can find below the extensive list of the variables from tidy_set.txt. The values in the table (except of course for the first two colum) are the average of the measurements for each subject and each activity.

Column number | Variable name | Characterirtics
------------- | ------------- | ---------------
1             | Subject       | Integer between 1 and 30 representing the person who performed the experiment
2             | Activity      | Text label giving the type of activity performed by the subject.They are the following: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
3-5          | Time_Body_Acc_Mean| Each column is for each axes X, Y  and Z
6-8          | Time_Body_Acc_Std| Each column is for each axes X, Y  and Z
9-11         | Time_Gravity_Acc_Mean| Each column is for each axes X, Y  and Z
12-14        | Time_Gravity_Acc_Std| Each column is for each axes X, Y  and Z
15-17        | Time_Body_Acc_Jerk_Mean| Each column is for each axes X, Y  and Z
18-20        | Time_Body_Acc_Jerk_Std| Each column is for each axes X, Y  and Z
21-23        | Time_Body_Gyro_Mean| Each column is for each axes X, Y  and Z
24-26        | Time_Body_Gyro_Std| Each column is for each axes X, Y  and Z
27-29        | Time_Body_Gyro_Jerk_Mean| Each column is for each axes X, Y  and Z
30-32        | Time_Body_Gyro_Jerk_Std| Each column is for each axes X, Y  and Z
33           | Time_Body_Acc_Mag_Mean|
34           | Time_Body_Acc_Mag_Std|
35           | Time_Gravity_Acc_Mag_Mean|
36           | Time_Gravity_Acc_Mag_Std|
37           | Time_Body_Acc_Jerk_Mag_Mean|
38           | Time_Body_Acc_Jerk_Mag_Std|
39           | Time_Body_Gyro_Mag_Mean|
40           | Time_Body_Gyro_Mag_Std|
41           | Time_Body_Gyro_Jerk_Mag_Mean|
42           | Time_Body_Gyro_Jerk_Mag_Std|
43-45        | Freq_Body_Acc_Mean| Each column is for each axes X, Y  and Z
46-48        | Freq_Body_Acc_Std| Each column is for each axes X, Y  and Z
49-51        | Freq_Body_Acc_Jerk_Mean| Each column is for each axes X, Y  and Z
52-54        | Freq_Body_Acc_Jerk_Std| Each column is for each axes X, Y  and Z
55-57        | Freq_Body_Gyro_Mean| Each column is for each axes X, Y  and Z
58-60        | Freq_Body_Gyro_Std| Each column is for each axes X, Y  and Z
61           | Freq_Body_Acc_Mag_Mean|
62           | Freq_Body_Acc_Mag_Std|
63           | Freq_Body_Acc_Jerk_Mag_Mean|
64           | Freq_Body_Acc_Jerk_Mag_Std|
65           | Freq_Body_Gyro_Mag_Mean|
66           | Freq_Body_Gyro_Mag_Std|
67           | Freq_Body_Gyro_Jerk_Mag_Mean|
68           | Freq_Body_Gyro_Jerk_Mag_Std|



