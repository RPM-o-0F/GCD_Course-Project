CodeBook.md
==================
### Required Libraries
* **reshape2**



### Utilized Working Directories
* **~/R/Getting and Cleaning Data Class/Class Project**
    + destination for file download and extraction
    + directory structure is expected to be in place
* **~/R/Getting and Cleaning Data Class/Class Project/dataset/UCI HAR Dataset**
    + working directory for loading files after unzipping of original data file
    + directory structure from /dataset down is created during unzip
* **~/R/Getting and Cleaning Data Class/Class Project**
    + working directory for program output



### Files Utilized from Downloaded Dataset
In order of program execution
working directory: ~/R/Getting and Cleaning Data Class/Class Project/dataset/UCI HAR Dataset

* **/test/X_test.txt**
    + This file represents the 30% of the overall measurements data that was partitioned as test data
* **/train/X_train.txt**
    + This file represents the 70% of the overall measurements data that was partitioned as train data
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
    + integer vector used to hold subset of column names containing mean and std
* **y_test**
    + temporary data frame to hold y_test.txt data
    + 2947 observations
    + 1 variable
* **y_train**
    + temporary data frame to hold y_train.txt data
    + 7352 observations
    + 1 variable
* **activity_labels**
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
    + defined for use as id argument in melt function
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
    + 180 observations
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
    + adding volunteer column to all_data data frame via column bind
* **all_melt <- melt(all_data, id = id_labels, measure.vars = column_labels)**
    + melt of all_data using id of volunteer and activity and measure variables of all other columns in the previously subsetted data set
* **result <- dcast(all_melt, Volunteer + Activity ~ variable, mean)**
    + recasting of data using mean function against variables defined in melt function


   
### Program Output

* **dataset.zip**
    + downloaded project data file
    + 59.7 MB
* **tidy_dataset.txt**
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
    
### Original Dataset README.txt file
**The downloaded dataset includes a README.txt file that is essentially a codebook for the original data:**

==================================================================  
Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
==================================================================  
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universit? degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  
==================================================================  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
