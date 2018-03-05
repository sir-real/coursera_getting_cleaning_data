#Package Includes
library(dplyr)

# Step 1 - Getting and Merging the Data

featuredata <- read.table("./UCI HAR Dataset/features.txt")
featuredata <- as.character(featuredata[,2])

xtraindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytraindata <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttraindata <- read.table("./UCI HAR Dataset/train/subject_train.txt")

colnames(ytraindata) <- "Activity"
colnames(subjecttraindata) <- "Volunteer"
colnames(xtraindata) <- featuredata

xtestdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytestdata <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttestdata <- read.table("./UCI HAR Dataset/test/subject_test.txt")

colnames(ytestdata) <- "Activity"
colnames(subjecttestdata) <- "Volunteer"
colnames(xtestdata) <- featuredata

traindata <- data.frame(subjecttraindata, ytraindata, xtraindata, check.names = F)
testdata <- data.frame(subjecttestdata, ytestdata, xtestdata, check.names = F)

alldata <- rbind(traindata, testdata)

#Extracting the desired column indeces - Mean & Standard Deviation

newdataindex <- grep("volunteer|activity|mean|std", tolower(colnames(alldata)))
newdata <- alldata[newdataindex]

#Step 3 - Uses Descriptive Activity Names to Name the Activities in the Data Set
#Step 4 - Appropriately labels the data set with descriptive variable names
activitydata <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activitydata) <- c("LabelId", "Activity")
activitylabels <- as.character(activitydata$Activity)
newdata$Activity <- activitylabels[newdata$Activity]

colnames(newdata) <- gsub("fBody", "Body", colnames(newdata))
colnames(newdata) <- gsub("tBody", "Body", colnames(newdata))
colnames(newdata) <- gsub("\\.", " ", colnames(newdata))
colnames(newdata) <- gsub("\\   ", " ", colnames(newdata))

#Step 5 - From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- aggregate(.~Activity+Volunteer, newdata, mean)
write.table(tidydata, "tidydata.txt", row.names = F)

#Reading it back
readtidydata <- read.table("./tidydata.txt")
print(head(readtidydata))
