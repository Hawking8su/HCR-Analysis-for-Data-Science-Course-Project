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

## Reading label names and feature table
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ")
features <- read.table("./UCI HAR Dataset/features.txt",sep = " ")
## Reading test data and label
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt" )
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## Reading training data label
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Merges the training and test datasets and labels
mergeData <- rbind(x_test, x_train)
mergeLabel <- rbind(y_test, y_train)
mergeSubject <- rbind(subject_test, subject_train)
rm(x_test,x_train, y_test, y_train, subject_test, subject_train)

## Assign variable names to datasets
names(mergeData) <- features[,2]
names(mergeSubject) <- "subjectIndex"
names(mergeLabel) <- "labelIndex"
names(activity_labels) <- c("labelIndex", "activityLabel")
rm(features)
extractData <- mergeData[,grepl("mean\\()|std\\()", names(mergeData))]

## Combine subjectIndex, labelIndex and extractData together
combineData <- cbind(mergeSubject,mergeLabel, extractData)
rm(mergeSubject, mergeLabel, mergeData, extractData)

## Match descriptive activity label name by labelIndex
## then drop labelIndex
HCRData <- merge(activity_labels,combineData,
                 by = "labelIndex", all = TRUE)
HCRData <- subset(HCRData, select= -c(labelIndex))
rm(activity_labels, combineData)

## Create a dataset with the average of each variable for
## each activity and each subject.
Act_Sub_avg <- group_by(HCRData, activityLabel, subjectIndex) %>%
                summarise_all(mean)

##Write HCRData and Act_Sub_avg into separate txt files.
write.table(HCRData, file="HCRData.txt", col.names = TRUE, row.names = FALSE)
write.table(Act_Sub_avg, file="Avg_HCRData_for_Act_Sub.txt", col.names = TRUE, row.names = FALSE)
