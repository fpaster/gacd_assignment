setwd("C:/Users/DE-84113/Desktop/Coursera/gettingAndCleaningData/assignment/UCI HAR Dataset/")

## 1. read data
#general
featurenames <- read.table("./features.txt")
labelnames <- read.table("./activity_labels.txt")

#traindata
trainsubjects <- read.table("./train/subject_train.txt")
trainfeatures <- read.table("./train/X_train.txt")
trainlabels <- read.table("./train/y_train.txt")

#testdata
testsubjects <- read.table("./test/subject_test.txt")
testfeatures <- read.table("./test/X_test.txt")
testlabels <- read.table("./test/y_test.txt")

## 2. merge data
trainblock <- cbind(trainsubjects, trainfeatures, trainlabels)
testblock <- cbind(testsubjects, testfeatures, testlabels)
data <- rbind(trainblock, testblock)

#set column names
featurenames$V2 <- gsub("\\(\\)", "", featurenames$V2)
featurenames$V2 <- gsub("-", ".", featurenames$V2)
#featurenames
names(data) <- c("subject", as.character(featurenames$V2), "activity")

#replace identifiers with activity labels
data <- merge(data, labelnames, by.x="activity", by.y="V1", all=T)
colnames(data)[564] <- "activity"


## 3. extract only relevant columns
#get the column names
columnnames <- names(data)
#find all columns that are standard deviation
stdcols <- grep("std", columnnames)
#find all columns that are means
meancols <- grep("mean", columnnames)

#only include the subject nr, the std + mean columns and the label column
columnstoextract <- c(2, stdcols, meancols, 564)
data <- data[, columnstoextract]

## 4. dplyr
library(dplyr)
grouping <- group_by(data, subject, activity)
overview <- summarise_each(grouping, funs(mean))
write.table(overview, "output.txt", append=F, row.names=F)
