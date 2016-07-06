## Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
A full description of the data is available at the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The R script, `run_analysis.R`, does the following:

  - Download and unzip the dataset
  - Merges the training and the test sets to create one data set
  - Extracts only the measurements on the mean and standard deviation for each measurement
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names
  - Creates a second, independent tidy data set (`tidyData.txt`) with the average of each variable for each activity and each subject  

 Additional information about the variables, data and transformations can be found in the `CodeBook.md` file
