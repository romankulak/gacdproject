# Clean up workspace
rm(list=ls())
# Download file if no exist
if (!file.exists("UCI HAR Dataset.zip")){
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "UCI HAR Dataset.zip",method = 'curl')
}
# Unzip file
if(file.exists("UCI HAR Dataset.zip")){
  unzip("UCI HAR Dataset.zip")
  print ("Unziped!")
}
# assign folder name to variable for later use 
maindir <- "UCI HAR Dataset"

# load labels and features
activLabels <- read.table(paste(maindir,"activity_labels.txt",sep="/"))
activLabels[,2] <- as.character(activLabels[,2])
features <- read.table(paste(maindir,"features.txt",sep="/"))
features[,2] <- as.character(features[,2])
featuresToUse <- grep(".*mean.*|.*std.*", features[,2])
featuresToUse.names <- features[featuresToUse,2]

# read the labels and data
xtest <- read.table(paste(maindir,"test/X_test.txt",sep="/"))[featuresToUse]
ytest <-read.table(paste(maindir,"test/y_test.txt",sep="/"))
subjectTest <- read.table(paste(maindir,"test/subject_test.txt",sep="/"))
testset <- cbind(subjectTest, ytest, xtest)

xtrain <- read.table(paste(maindir,"train/X_train.txt",sep="/"))[featuresToUse]
ytrain <-read.table(paste(maindir,"train/y_train.txt",sep="/"))
subjectTrain <- read.table(paste(maindir,"train/subject_train.txt",sep="/"))
trainset <- cbind(subjectTrain, ytrain, xtrain)

# Combine All
mainSet <- rbind(trainset,testset)
colnames(mainSet) <- c("subject", "activity", featuresToUse.names)

# subject and activity into factor
mainSet$activity <- factor(mainSet$activity, levels = activLabels[,1], labels = activLabels[,2])

# Group all observations 
mainSetMelted <-reshape2::melt(mainSet, id = c("subject", "activity"))
mainSetMean <- reshape2::dcast(mainSetMelted, subject + activity ~ variable, mean)

write.table(mainSetMean, "tidydataset.txt", row.names = FALSE, quote = FALSE)



