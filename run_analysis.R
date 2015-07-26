# Importing data and creating merged data set

setwd("c:/UCI HAR Dataset")
trainX <- read.table("c:/UCI HAR Dataset/train/x_train.txt") 
trainY <- read.table("c:/UCI HAR Dataset/train/y_train.txt") 
trainSub <- read.table("c:/UCI HAR Dataset/train/subject_train.txt") 
train<-cbind(trainX,trainY,trainSub)

testX <- read.table("c:/UCI HAR Dataset/test/X_test.txt") 
testY <- read.table("c:/UCI HAR Dataset/test/y_test.txt") 
testSub <- read.table("c:/UCI HAR Dataset/test/subject_test.txt") 
test<-cbind(testX,testY,testSub)

features <- read.table("c:/UCI HAR Dataset/features.txt") 
features[,2] <- as.character(features[,2]) 
merged <- rbind(train, test) 


#Extracting only the measurements on the mean and standard deviation for each measurement. 

features_mean_sd<- grep(".*mean.*|.*std.*", features[,2])
features_new <- features[features_mean_sd,2]


#Using descriptive activity names to name the activities in the data set

activity<- read.table("c:/UCI HAR Dataset/activity_labels.txt") 
activity[,2] <- as.character(activity[,2]) 


#Appropriate labels for the data set with descriptive variable names. 

names(merged)<-gsub("^t", "time", names(merged))
names(merged)<-gsub("^f", "frequency", names(merged))
names(merged)<-gsub("Acc", "Accelerometer", names(merged))
names(merged)<-gsub("Gyro", "Gyroscope", names(merged))
names(merged)<-gsub("Mag", "Magnitude", names(merged))
names(merged)<-gsub("BodyBody", "Body", names(merged))

# Creating and printing tidy dataset

library(plyr);
final<-aggregate(. ~subject + activity, merged, mean)
final<-final[order(final$subject,final$activity),]
write.table(final, file = "tidy.txt",row.name=FALSE)
