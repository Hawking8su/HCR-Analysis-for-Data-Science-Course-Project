rm(list=ls())
library(dplyr)

setwd("E:/R/C3/course_project")
## Download zip file if not exists
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset.zip")){
    download.file(zipUrl, destfile = "UCI HAR Dataset.zip")
}
## Unzip zip file if target directory didn't exist
if (!dir.exists("UCI HAR Dataset")){
    unzip("UCI HAR Dataset.zip")
}

## Reading label names and feature variable names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",sep = " ", header = FALSE)
## Reading test data and label
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE )
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
## Reading training data label
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

## Merges the training and test datasets
mergeData <- rbind(x_test, x_train)
mergeLabel <- rbind(y_test, y_train)
mergeSubject <- rbind(subject_test, subject_train)
rm(x_test,x_train, y_test, y_train, subject_test, subject_train)

## Use descriptive activity names to name the activities in the data set.
names(mergeData) <- features[,2]
names(mergeSubject) <- "subjectIndex"
names(mergeLabel) <- "labelIndex"
names(activity_labels) <- c("labelIndex", "activityLabel")
rm(features)

## Extract only the measurements on the mean and standard deviation for
## each measurement.
extractData <- mergeData[,grepl("mean|std", names(mergeData))]

## Appropriately label the data set with descriptive variable names.
combineData <- cbind(mergeSubject,mergeLabel, extractData)
HCRData <- merge(activity_labels,combineData,
                 by = "labelIndex", all = TRUE)
rm(mergeSubject, mergeLabel, mergeData, extractData, activity_labels, combineData)

## Create a second, independent tidy set with the average of each 
## variable for each activity and each subject.
tidyData <- group_by(HCRData, activityLabel, subjectIndex) %>%
                summarise_all(mean)

##Write tidyData into tidyData.txt files.
write.table(tidyData, file="tidyData.txt", col.names = TRUE, row.names = FALSE)
