### Getting and Cleaning Data Course Project ###

# run_analysis.R works as follows:
# 1. Downloads and unzips the dataset
# 2. Merges the training and the test sets to create one data set
# 3. Extracts only the measurements on the mean and standard deviation for each 
#    measurement
# 4. Uses descriptive activity names to name the activities in the data set
# 5. Appropriately labels the data set with descriptive variable names
# 6. Creates a second, independent tidy data set  
#    with the average of each variable for each activity and each subject
# 7. Export the tidyData set (tidyData.txt)



filename <- "getdata_dataset.zip"

# 1. Download and unzip the data set
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}


# 2. Merge the training and the test sets to create one data set.

# Read in the train and test data
features       = read.table('UCI HAR Dataset/features.txt'); 
activityLabels = read.table('UCI HAR Dataset/activity_labels.txt'); 
subjectTrain   = read.table('UCI HAR Dataset/train/subject_train.txt'); 
xTrain         = read.table('UCI HAR Dataset/train/x_train.txt'); 
yTrain         = read.table('UCI HAR Dataset/train/y_train.txt'); 
subjectTest    = read.table('UCI HAR Dataset/test/subject_test.txt'); 
xTest          = read.table('UCI HAR Dataset/test/x_test.txt'); 
yTest          = read.table('UCI HAR Dataset/test/y_test.txt'); 

# Assign column names to the train and test data
colnames(activityLabels)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";
colnames(subjectTest)   = "subjectId";
colnames(xTest)         = features[,2]; 
colnames(yTest)         = "activityId";

# Create the training data set by combining yTrain, subjectTrain, and xTrain
trainingData = cbind(yTrain,subjectTrain,xTrain);

# Create the test data set by combining the xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest);

# Create one united data set by combining the training and test data sets
unitedData = rbind(trainingData,testData);

# Create a vector for the column names from the unitedData, which will be used 
# to select the wanted mean() & stddev() columns
colNames  = colnames(unitedData); 



# 3. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & 
# stddev() columns and FALSE for others
logicalVector = (grepl("activity..",colNames) | 
                 grepl("subject..",colNames) | 
                 grepl("-mean..",colNames) & !
                 grepl("-meanFreq..",colNames) & !
                 grepl("mean..-",colNames) | 
                 grepl("-std..",colNames) & !
                 grepl("-std()..-",colNames));

# Subset the unitedData table based on the logicalVector to keep only wanted columns
unitedData = unitedData[logicalVector==TRUE];



# 4. Use descriptive activity names to name the activities in the data set

# Merge the unitedData set with the acitivityType table 
# to include descriptive activity names
unitedData = merge(unitedData,activityLabels,by="activityId",all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(unitedData); 



# 5. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("\\()","",colNames[i])
        colNames[i] = gsub("-std$","StdDev",colNames[i])
        colNames[i] = gsub("-mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","time",colNames[i])
        colNames[i] = gsub("^(f)","freq",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
        colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
        colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
        colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
        colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the unitedData set
colnames(unitedData) = colNames;



# 6. Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 

# Create a new table, unitedDataNoActivityType without the activityType column
unitedDataNoActivityType  = unitedData[,names(unitedData) != 'activityType'];

# Summarizing the unitedDataNoActivityType table to include just the mean of 
# each variable for each activity and each subject
tidyData    = aggregate(unitedDataNoActivityType[,names(unitedDataNoActivityType) != c('activityId','subjectId')],
                        by = list(activityId = unitedDataNoActivityType$activityId,
                                subjectId = unitedDataNoActivityType$subjectId),mean);

# Merging the tidyData with activityLabels to include descriptive acitvity names
tidyData    = merge(tidyData,activityLabels,by='activityId',all.x=TRUE);

# 7. Export the tidyData set 
write.table(tidyData, 'UCI HAR Dataset/tidyData.txt',row.names=TRUE,sep='\t');


