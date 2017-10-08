#######################################################################################################
## File : run_analysis.R
## Author : Sudipto Mitra
## Overview:
## R Script file for Coursera Assigment on Getting & Cleaning data 
## Script Will get data and perform the various operations needed for the assignment 
## Refer to Readme file and 
## Operation that will be done
## Get Data by downloading and unzipping file 
## 1. Merges the training and the test sets to create one data set.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
library(dplyr)

######################################################################################################

# Download and Unzip File

######################################################################################################

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"


if (!file.exists(zipfile)) {
       download.file(fileurl, zipfile , method = "curl")
}

unzip(zipfile)


#####################################################################################################

# Read Data
#setwd("./UCI HAR Dataset")

# read training data
values_train <- read.table("train/X_train.txt",header = FALSE)
activity_train <- read.table("train/y_train.txt",header = FALSE)
subject_train <- read.table("train/subject_train.txt",header = FALSE)

# read test data
values_test <- read.table("test/X_test.txt",header = FALSE)
activity_test <- read.table("test/y_test.txt",header = FALSE)
subject_test <- read.table("test/subject_test.txt",header = FALSE)

#read features 
# features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
dataFeaturesNames <- read.table("features.txt",header = FALSE,as.is = TRUE)

# read activity labels
activityLabels <- read.table("activity_labels.txt", header = FALSE)
#colnames(activities) <- c("activityId", "activityLabel")

######################################################################################################

# 1. Create and bind data sets 

######################################################################################################

dataSubject <- rbind(subject_train,subject_test)
dataActivity <- rbind(activity_train, activity_test)
dataFeatures <- rbind(values_train,values_test)

dataActivity[, 1] <- activityLabels[dataActivity[, 1], 2]

#set names to variables

names(dataSubject) <- c("subject")
names(dataActivity) <-  c("activity")
names(dataFeatures) <- dataFeaturesNames$V2

#Merge columns to get final data frame

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

#############################################################################################################

#Extracts only the measurements on the mean and standard deviation for each measurement
#Subset Name of Features by measurements on the mean and standard deviation
# Need to take name of features with "mean()" or "std()"

#############################################################################################################

#Subset the data frame Data by seleted names of Features
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
Data <- subset(Data,select = selectedNames)

#############################################################################################################

## Appropriately labels the data set with descriptive variable names

#############################################################################################################

names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))

#############################################################################################################

# Output the tidydata.txt file 


##############################################################################################################
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.names = FALSE)


