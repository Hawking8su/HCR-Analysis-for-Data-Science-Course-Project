rm(list=ls())
library(dplyr)

setwd("E:/R/C3/course_project")

activity_labels <- read.table("./dataset/activity_labels.txt", sep = " ")
features <- read.table("./dataset/features.txt",sep = " ")
## Reading test data and label
x_test <- read.table("./dataset/test/X_test.txt" ) 
y_test <- read.table("./dataset/test/y_test.txt")
subject_test <- read.table("./dataset/test/subject_test.txt")
## Reading training data label
x_train <- read.table("./dataset/train/X_train.txt")
y_train <- read.table("./dataset/train/y_train.txt")
subject_train <- read.table("./dataset/train/subject_train.txt")

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
