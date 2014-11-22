run_analysis.R
==================
  
  
This is the repository for the Getting & Cleaning Data Course Project.

The purpose of the project is to demonstrate the ability to collect and prepare specified data into a tidy data format that is more descriptive and can be used for later analysis.

**This project utilizes the following dataset:**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
**The program expects the following directory structure is available to download and extract the working files.**

* **~/R/Getting and Cleaning Data Class/Class Project**
    + destination for file download and extraction

### From the Project Requirements:

**You should create one R script called run_analysis.R that does the following.**

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



### Overview of Steps Taken to Meet Project Requirements

1. Download and unzip the file into a working directory
2. Read in x_test.txt and x_train.txt as the basis for the combined dataset
    + The combined dataset is named all_data in the program
3. Read in the features.txt file and use the variable names contained within to name the columns of x_test and x_train data frames
    + Aids in combining the data frames together
    + Ultimately provides a descriptive name to each measurement column
4. Subset all_data to include only columns relating to mean or std (standard deviation)
5. Read in the y_test.txt and y_train.txt files 
6. Read in the activity_labels.txt file and using a for loop replace the activity id's with descriptive activity names
7. Name the column in y_test and y_train as "Activity" to aid in row bind
8. Row bind y_test and y_train representing a column of activities that can be later column bound to the all_data data frame
9. Read in the subject_test.txt and subject_train.txt files
10. Name the column in subject_test and subject_train as "Volunteer" to aid in row bind
11. Row bind subject_test and subject_train representing a column of subjects that can be later column bound to the all_data data frame
12. Column bind the activity and volunteer columns to all_data
    + At this stage all_data represents the requirements of steps 1 - 4
13. Using a list of column names, create the id and measurement variables required for the melt function
    + create a variable to hold the volunteer and activity column id's
    + create a variable to hold the list of all measurements
14. Use the melt function to prepare to recast the data
15. Use the dcast function with the mean function to create the result dataset
16. Write the data set out to a file


### Peer Review

I have commented the run_analysis.R source code to help identify where the project requirements are addressed.  
  
**Here is a reference for each project requirement to aid in peer evaluation:**

1. Merges the training and the test sets to create one data set. 
    + Lines 37 - 39
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
    + Lines 45 - 48
3. Uses descriptive activity names to name the activities in the data set  
    + Lines 57 - 64
4. Appropriately labels the data set with descriptive variable names.   
    + Lines 29 - 35; 66 - 69; 82 - 85 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + Lines 105 - 121  
    
### The repository includes:

* **README.md**
    + This readme file
* **run_analysis.R**
    + R code to meet the requirements of the project
* **CodeBook.md**
    + Markdown file that details the following elements of run_analysis.R
        + Required Libraries
        + Expected Working Directories
        + Files Utilized from Downloaded Dataset
        + Variables Utilized in run_analysis.R
        + Data Transformations
        + Program Output

