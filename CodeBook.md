## Getting and Cleaning Data Course Project
### Description

This code book contains additional information about the variables, 
data and transformations used for the "Getting and Cleaning Data Course Project", 
which is part of Coursera's Data Science Specialization.

### Data source

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Data set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating 
the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into 
body acceleration and gravity. The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by 
calculating variables from the time and frequency domain.

### Attribute information

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

### Script information

- First, the data set is downloaded and unziped 
- Merging the training and the test sets to create one data set consists of the following steps:
      
    -  Reading in the train and test data
    -  Assigning column names to the train and test data
    -  Creating the training data set by combining `yTrain`, `subjectTrain`, and `xTrain`
    -  Creating the test data set by combining the `xTest`, `yTest` and `subjectTest` data
    -  Creating one united data set by combining the training and test data sets
    -  Creating a vector for the column names from the `unitedData`, which will be used to select the wanted `mean()` & `stddev()` columns
    
- Extracting only the measurements on the mean and standard deviation for each measurement consists of the following parts:

     - Creating a `logicalVector` that contains `TRUE` values for the `ID`, `mean()` & `stddev()` columns and `FALSE` for others
     - Subseting the `unitedData` table based on the `logicalVector` to keep only wanted columns
     
- Using descriptive activity names to name the activities in the data set included following steps:

     - Merging the `unitedData` set with the `acitivityType` table to include descriptive activity names
     - Updating the `colNames` vector to include the new column names after merge

- Appropriately labelling the data set with descriptive activity names required:

      - Cleaning up the variable names
      - Reassigning the new descriptive column names to the `unitedData` set
      
- From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject required:

      - Creating a new table, `unitedDataNoActivityType` without the `activityType` column
      - Summarizing the `unitedDataNoActivityType` table to include just the mean of each variable for each activity and each subject
      - Merging the `tidyData` with `activityLabels` to include descriptive acitvity names

- Finally, the `tidyData` set is exported 
 
### Variable information

- `features` contains a list of all features
- `subjectTrain`each row identifies the subject who performed the activity for each window sample
- `subjectTest`similar to `subjectTrain` for the test set 
- `activityLabels` links the class labels with their activity name
- `xTrain` contains the training set
- `yTrain` contains the training labels
- `xTest` contains the test set
- `yTest` contains the test labels
- `trainingData` contains the training data set by combining `yTrain`, `subjectTrain`, and `xTrain`
- `testData` contains the test data set by combining the `xTest`, `yTest` and `subjectTest` data
- `unitedData` contains the merged training and test data sets
- `unitedDataNoActivityType` contains a new table without the `activityType` column
- `tidyData` contains the average of each variable for each activity and each subject
