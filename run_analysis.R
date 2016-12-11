## The code run_analysis.R takes the data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## of the accelerometer of the smartphone Samsung Galaxy S and produces a tidier data set as output
## Functionalities:
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement.
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names.
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#load packages
library(data.table)
library(dplyr)
library(tidyr)
library(plyr)

#download files
if(!file.exists("./data")){
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./dataset.zip",method = "curl")
#unzip files
unzip("./dataset.zip",exdir="data")}

# Reading subject files
DSubjectTrain <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "train", "subject_train.txt")))
DSubjectTest <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "test", "subject_test.txt")))

# Reading activity files
DActivityTrain <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "train", "Y_train.txt")))
DActivityTest  <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "test" , "Y_test.txt" )))

# Reading data files
DTrain <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "train", "X_train.txt" )))
DTest  <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "test" , "X_test.txt" )))

# Merge the train and test data in Activity and Subject filesby row binding 
#and rename variables "subject" and "activityNumber"
subjectfull<- rbind(DSubjectTrain, DSubjectTest)
setnames(subjectfull, "V1", "subject")
activityfull<- rbind(DActivityTrain, DActivityTest)
setnames(activityfull, "V1", "activityNumber")

#Merge train & test datasets by row binding
datamerg <- rbind(DTrain, DTest)

# Rename variables in datamerg according to the corresponding feature e.g.(V1 = "tBodyAcc-mean()-X")
dataFeatures <- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(datamerg) <- dataFeatures$featureName

# Set column names given activity labels
activityLabels<- tbl_df(read.table(file.path("./data/UCI HAR Dataset", "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNumber","activityName"))

# Merge subject, activity and train/test data together
subact<- cbind(subjectfull, activityfull)
datamerg <- cbind(subact, datamerg)

# Subset Name of Features by measurements on the mean and standard deviation
#i.e take Names of Features with “mean()” or “std()” in the file feature.txt and save it
subdataFeaturesNames<-dataFeatures$featureName[grep("mean\\(\\)|std\\(\\)", dataFeatures$featureName)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activityNumber" )
datamerg <- datamerg[, which(colnames(datamerg) %in% selectedNames)]  

##Add name of activity into datamerg
datamerg <- merge(activityLabels, datamerg , by="activityNumber", all.x=TRUE)
datamerg$activityName <- as.character(datamerg$activityName)

#Labels the data set with descriptive variable names.
names(datamerg)<-gsub("std()", "SD", names(datamerg))
names(datamerg)<-gsub("mean()", "MEAN", names(datamerg))
names(datamerg)<-gsub("^t", "time", names(datamerg))
names(datamerg)<-gsub("^f", "frequency", names(datamerg))
names(datamerg)<-gsub("Acc", "Accelerometer", names(datamerg))
names(datamerg)<-gsub("Gyro", "Gyroscope", names(datamerg))
names(datamerg)<-gsub("Mag", "Magnitude", names(datamerg))
names(datamerg)<-gsub("BodyBody", "Body", names(datamerg))

#Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject and save it in the file 'tidydata.txt'
Datanew<-aggregate(. ~subject + activityName, datamerg, mean)
Datanew<-Datanew[order(Data2$subject,Data2$activityName),]
write.table(Datanew, file = "tidydata.txt",row.name=FALSE)
