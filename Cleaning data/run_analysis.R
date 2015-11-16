##You should create one R script called run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.

## Load relavent packages.
if(!require(sqldf)) {
  install.packages("sqldf")
  library(sqldf)  
}
if(!require(plyr)){
  install.packages("plyr")
  library(plyr)
}
if(!require(reshape)){
  install.packages("reshape")
  library(reshape)
}
if(!require(reshape2)){
  install.packages("reshape2")
  library(reshape2)
}


## Load activity and label data and assign columnnames as labels and activityname
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityLabel [,2] <- sub("_", " ", activityLabel[,2])
colnames(activityLabel) <- c("label", "Activity")

## Load features(column names) only. Serial numbers column from the file is to be excluded. 
feature <- read.table("./UCI HAR Dataset/features.txt")
feature <- feature [,2]

## Load subjects for both training and test data and merge them and give Subject text
trainingsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
mergedSubjects <- rbind(trainingsubjects,testsubjects)
mergedSubjects <- mutate(mergedSubjects, Subject = paste("Subject",mergedSubjects$V1))

##Load Training data
trainingdata <- read.table("./UCI HAR Dataset/train/X_train.txt")

## Load Training labels - which will be row labels for training data
trainingLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")

##Load Test data
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Load Test labels - which will be row labels for Test data
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")

##Merges the training and the test sets to create one data set.
mergeddata <- rbind(trainingdata, testdata)

##Add features as Column name to the merged data
colnames(mergeddata) <- feature

## Merging the labels for both data sets and then assigning activity name to lables 
## by performing a join with activitylabel
mergeddatalabel <- rbind(trainingLabel,testLabel)
colnames(mergeddatalabel) <- c("label")
mergedactivityDF <- join(x = mergeddatalabel,y = activityLabel,match = "first",by = c("label"))

##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Extract measurements on the mean and standard deviation for each measurement.
extractdata <- mergeddata[,grep("mean|std", colnames(mergeddata), value = TRUE)]

## Including the subject and activity names and as the first column of the merged cleaned data and 
## renaming the subject and activity columns. This has to be done after the extraction step
extractdata <- cbind(mergedSubjects[,2], mergedactivityDF [,2], extractdata)
colnames(extractdata)[1] <-  c("Subject")
colnames(extractdata)[2] <-  c("Activity")

##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.
datamelt <- melt(extractdata, id.vars = c("Subject","Activity"))
extractdatamean <- dcast(datamelt, formula = Subject + Activity ~ variable, mean)

##Write to tidydata text file.
write.table(extractdatamean, file = "tidydata.txt", row.names = FALSE)

##Remove all objects
rm(list = ls())
