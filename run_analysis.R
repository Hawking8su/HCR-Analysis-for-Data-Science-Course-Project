rm(list=ls())
library(dplyr)

setwd("E:/R/C3/course_project")

activity_labels <- read.table("./dataset/activity_labels.txt", sep = " ")
features <- read.table("./dataset/features.txt",sep = " ")
## Reading test data and label
x_test <- read.table("./dataset/test/X_test.txt" ) # relative 
y_test <- read.table("./dataset/test/y_test.txt")
## Reading training data label
x_train <- read.table("./dataset/train/X_train.txt")
y_train <- read.table("./dataset/train/y_train.txt")

## Merges the training and test datasets and labels
mergeData <- rbind(x_test, x_train)
mergeLabel <- rbind(y_test, y_train)
rm(x_test,x_train, y_test, y_train)

## Assign variable names to datasets
names(mergeData) <- features[,2]
rm(features)
extractData <- mergeData[,grepl("mean()|std()", names(mergeData))]

