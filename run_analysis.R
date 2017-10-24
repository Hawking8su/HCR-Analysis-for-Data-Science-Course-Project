rm(list=ls())
library(dplyr)

setwd("E:/R/C3/course_project")

activity_labels <- read.table("./dataset/activity_labels.txt", sep = " ")
features <- read.table("./dataset/features.txt",sep = " ")
## Reading test data
x_test <- read.table("./dataset/test/X_test.txt" ) # relative 
y_test <- read.table("./dataset/test/y_test.txt")
## Reading training data
x_train <- read.table("./dataset/train/X_train.txt")
y_train <- read.table("./dataset/train/y_train.txt")