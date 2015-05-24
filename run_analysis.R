library(downloader)     ## load package to use unzip function

## download files from internet and create folder in working directory if it doesn't already exist
if (!file.exists("./CourseProject3")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download(fileURL, dest = "CourseProject3.zip", mode = "wb")
        unzip("CourseProject3.zip", exdir = "./CourseProject3")
        dateDownloaded <- date()
}

## read in column labels and convert to vector
MeasurementsFile <- read.table("./CourseProject3/UCI HAR Dataset/features.txt")
Measurements <- MeasurementsFile[, 2]

## read in test data with column labels and combine files
testData <- read.table("./CourseProject3/UCI HAR Dataset/test/X_test.txt", col.names = Measurements)
testLabels <- read.table("./CourseProject3/UCI HAR Dataset/test/Y_test.txt", col.names = "Test Codes")
testSubjects <- read.table("./CourseProject3/UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
testComplete <- cbind(testData, testLabels, testSubjects)

## read in training data with column labels and combine files
trainingData <- read.table("./CourseProject3/UCI HAR Dataset/train/X_train.txt", col.names = Measurements)
trainingLabels <- read.table("./CourseProject3/UCI HAR Dataset/train/Y_train.txt", col.names = "Test Codes")
trainingSubjects <- read.table("./CourseProject3/UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
trainingComplete <- cbind(trainingData, trainingLabels, trainingSubjects)

## merge test and training data
CombinedData <- rbind(testComplete, trainingComplete)

## convert codes to actual labels in Combined Data using activity_labels file
labels <- read.table("./CourseProject3/UCI HAR Dataset/activity_labels.txt", col.names = c("Test Codes", "Test Labels"))
LabeledData <- merge(CombinedData, labels, all = TRUE)

## filter LabeledData to only include mean and standard deviation columns with subject and test labels
meansDF <- LabeledData[, grepl("mean", names(LabeledData), ignore.case = TRUE)]
stdDF <- LabeledData[, grepl("std", names(LabeledData), ignore.case = TRUE)]
infoDF <- LabeledData[, 563:564]
filteredDF <- cbind(meansDF, stdDF, infoDF)

## calculate means of variables by subject and activity
tidyData <- aggregate(filteredDF[,1:86],by=list(filteredDF$Subject, filteredDF$Test.Labels), FUN=mean)

## create output file
write.table(tidyData, file = "./CourseProject3FinalData.txt", row.names = FALSE)