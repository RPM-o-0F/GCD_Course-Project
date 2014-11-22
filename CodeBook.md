---
title: "Project Codebook"
output: html_document
---
### Required Libraries
* **reshape2**



### Expected Working Directories
* **~/R/Getting and Cleaning Data Class/Class Project**
    + destination for file download and extraction
* **~/R/Getting and Cleaning Data Class/Class Project/dataset/UCI HAR Dataset**
    + working directory for loading files after unzipping of original data file
* **~/R/Getting and Cleaning Data Class/Class Project**
    + working directory for program output



### Files Utilized from Downloaded Dataset
In order of program execution

* **/test/X_test.txt**
    + This file represents the 30% of the overall measurements data that was partitioned as test data
* **/train/X_train.txt**
    + This file represents the 70% of the overall measurements data that was partioned as train data
* **features.txt**
    + This file contains a list of all of the variables of the measurement data
* **/test/y_test.txt**
    + This file contains identification of the activity for all observations in the test partition
* **/train/y_train.txt**
    + This file contains identification of the activity for all observations in the train partition
* **/activity_labels.txt**
    + This file contains descriptive activity values and names that correspond to the observations in y_test.txt and y_train.txt
* **/test/subject_test.txt**
    + This file contains subject values that correspond to the observations in y_test.txt
* **/train/subject_train.txt**
    + This file contains subject values that correspond to the observations in y_train.txt



### Variables Utilized in run_analysis.R

* **url**
    + url of the data file location
    + used in the download function
* **x_test**
    + temporary data frame to hold the x_test.txt data
    + 2947 Observations
    + 561 variables
* **x_train**
    + temporary data frame to hold to x_train.txt data
    + 7352 observations
    + 561 variables
* **features**
    + data frame to hold the features.txt data
    + 561 observations
    + 2 variables
* **labels**
    + matrix that contains the transposed values from the second variable of the features data frame
    + 561 character values
* **all_data**
    + data frame that represents the primary working dataset throughout the program
    + 10999 observations - final state
    + 81 variables - final state
* **keep_cols**
    + intiger vector used to hold subset of column names containing mean and std
* **y_test**
    + temporary data frame to hold y_test.txt data
    + 2947 observations
    + 1 variable
* **y_train**
    + temporary data frame to hold y_train.txt data
    + 7352 observations
    + 1 variable
* **activitiy_labels**
    + descriptive activity names
    + 6 observations
    +2 variables
* **i**
    + iteration variable
* **activity**
    + combined activity column
    + 10299 Observations
    + 1 variable
* **subject_test**
    + temporary data frame to hold subject_test.txt
* **subject_train**
    + temporary data frame to hold subject_train.txt
* **volunteer**
    + combined subject column
* **id_labels**
    + defined for use as id arument in melt function
    + identification of labels to be removed from entire list of column names
* **column_labels**
    + defined for use as measures argument in melt function
    + list of all column names except for the activity and volunteer names
* **all_melt**
    + temporary data frame for use with dcast
    + 813621 observations
    + 4 variables
* **result**
    + final data frame
    + 180 oberservations
    + 81 variables
   
   
   
### Data Transformations

* **labels <- t(features[2])**
    + transposed, second variable
    + used to create labels for all_data data frame
* **colnames(x_test) <- labels**
    + labels added to x_test to facilitate rbind
* **colnames(x_train) <- labels**
    + labels added to x_train to facilitate rbind
* **all_data <- rbind(x_test, x_train)**
    + create primary dataset via row bind
* **all_data <- all_data[,keep_cols]**
    + subsetting of all_data to just include data columns containing mean and std
* **y_test[i,1] <- as.character(activity_labels[y_test[i,1],2])**
    + Converts the activity values (1:6) of y_test to a descriptive activity name
* **y_train[i,1] <- as.character(activity_labels[y_train[i,1],2])**
    + Converts the activity values (1:6) of y_train to a descriptive activity name
* **colnames(y_test) <- "Activity"**
    + label added to y_test to facilitate rbind
* **colnames(y_train) <- "Activity"**
    + label added to y_train to facilitate rbind
* **activity <- rbind(y_test, y_train)**
    + create activity column via row bind
* **colnames(subject_test) <- "Volunteer"**
    + label added to subject_test to facilitate rbind
* **colnames(subject_train) <- "Volunteer"**
    + label added to subject_train to facilitate rbind
* **volunteer <- rbind(subject_test, subject_train)**
    + create volunteer column via row bind
* **all_data <- cbind(activity, all_data)**
    + adding activity column to all_data data frame via column bind
* **all_data <- cbind(volunteer, all_data)**
    + additng volunteer column to all_data data frame via column bind
* **all_melt <- melt(all_data, id = id_labels, measure.vars = column_labels)**
    + melt of all_data using id of volunteer and activity and measure variables of all other columns in the previously subsetted data set
* **result <- dcast(all_melt, Volunteer + Activity ~ variable, mean)**
    + recasting of data using mean function agains variables defined in melt function


   
### Program Output

* **dataset.zip**
    + downloaded project data file
    + 59.7 MB
* **tidy._dataset.txt**
    + the initial tidy data frame
    + Represents each measurement for each subject and activity
    + no units have changed
    + 9.4 MB
* **tidy_dataset2.txt**
    + the final tidy data frame
    + represents the average of each variable for each subject and activity
    + no units have changed
    + uploaded as required in step 5 of the project
    + 261.4 KB
   
    