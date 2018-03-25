The repo contains two files:

* run_analys.R
* CodeBook.md

**run_analysis.R** is used to analyse the data from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script should be copied in the folder named "UCI HAR Dataset" in order to be able to run.

This script will read the folowing data:

* features.txt
* x_train.txt
* subject_train.txt
* y_train.txt
* x_test.txt
* subject_test.txt
* y_test.txt
* activity_labels.txt

And it will generate a text file with the name **tidy_set.txt**. It is a matrix containing 180 lines and 68 columns.
It gathers the average of each variable for each subject and activity.
This file can be read with the following command: read.table("tidy_set.txt")

In **CodeBook.md**, you will be able to read about the variables description, the data used for the analysis and the transformations that were made to get to tidy_set.txt.


