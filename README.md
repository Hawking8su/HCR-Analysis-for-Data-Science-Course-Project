# Getting and Cleaning Data Course Project

## This repo includes the following files:

* 'README.md':

* 'CodeBook.txt': description of variables in tidyData.txt data set.

* 'run_analysis.R': this R script does the following steps:
    - Download and unzip source data if doesn't exist.
    - Read and merge test and training data sets to one data set.
    - Use descriptive activity names to name the activities in the data set.
    - Extract only the measurements on the mean and standard deviation for each measurement.
    - Appropriately label the data set with descriptive variable names.
    - Create a second, independent tidy set with the average of each variable for each activity and each subject.
    - Write the data set to the tidyData.txt file.

* tidyData.txt: independent tidy set with the average of each variable for each activity and each subject.
