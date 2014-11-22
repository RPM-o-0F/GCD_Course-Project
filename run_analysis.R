# Load required libraries
library(reshape2)

# Set working directory for file download
setwd("~/R/Getting and Cleaning Data Class/Class Project")

# Set the file location to the url variable
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the file and name it dataset.zip
# Method = "curl" required for linux download via https
download.file(url,"dataset.zip", method = "curl")

# Unzip file into sub folder named dataset of the working directory 
unzip("dataset.zip", exdir ="dataset")



# Set working directory for extracted file access
setwd("~/R/Getting and Cleaning Data Class/Class Project/dataset/UCI HAR Dataset")

# Load data files x_test.txt and x_train.txt in order to create a combined primary dataset
x_test <- read.table("test/X_test.txt", quote="\"")
x_train <- read.table("train/X_train.txt", quote="\"")

# Load features.txt to be used to generate the labels for the primary dataset
features <- read.table("features.txt", quote="\"", stringsAsFactors=FALSE)

# Subset the variable name and transpose the column into a row so they can be passed to the colnames function
labels <- t(features[2])

# Apply labels to the columns to facilitate row binding and meet the required of the assignment
# 4. Appropriately labels the data set with descriptive variable names.
colnames(x_test) <- labels
colnames(x_train) <- labels

# Bind test and train data together to create the primary dataset as required by the assignment
# 1. Merges the training and the test sets to create one data set.
all_data <- rbind(x_test, x_train)

# Clean up memory to conserve resources - remove unnecessary data frames
rm(x_test)
rm(x_train)

# Create subset of data as required by the assignment - results in 79 columns of data
# 2. Extracts only the measurement variable names that include mean and standard deviation.
keep_cols <- grep("mean|std", labels)
all_data <- all_data[,keep_cols]

# Load data files y_test.txt and y_train.txt in order to create a combined activity column
y_test <- read.table("test/y_test.txt", quote="\"")
y_train <- read.table("train/y_train.txt", quote="\"")

# Load activity_labels.txt to be used to add a  descriptive activity name to the data in the column
activity_labels <- read.table("activity_labels.txt", quote="\"")

# Use a for loop to cycle through the y_test and y_train data files and replace the activity indicator with the activity name
# 3. Uses descriptive activity names to name the activities in the data set
for(i in 1:length(y_test[,1])){
        y_test[i,1] <- as.character(activity_labels[y_test[i,1],2])
}
for(i in 1:length(y_train[,1])){
        y_train[i,1] <- as.character(activity_labels[y_train[i,1],2])
}

# Apply a label to the activity columns to facilitate row binding and meet the required of the assignment
# 4. Appropriately labels the data set with descriptive variable names.
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"

# Bind the activity columns
activity <- rbind(y_test, y_train)

# Clean up memory to conserve resources - remove unnecessary data frames
rm(y_test)
rm(y_train)

# Load data files subject_test.txt and subject_train.txt in order to create a combined subject column
subject_test <- read.table("test/subject_test.txt", quote="\"")
subject_train <- read.table("train/subject_train.txt", quote="\"")

# Apply a label to the subject columns to facilitate row binding and meet the required of the assignment
# 4. Appropriately labels the data set with descriptive variable names.
colnames(subject_test) <- "Volunteer"
colnames(subject_train) <- "Volunteer"

# Bind the subject columns
volunteer <- rbind(subject_test, subject_train)

# Clean up memory to conserve resources - remove unnecessary data frames
rm(subject_test)
rm(subject_train)

# Combine the additoinal columns activity and volunteer to the primary dataset
all_data <- cbind(activity, all_data)
all_data <- cbind(volunteer, all_data)

# Set working direcotry to class project directory for output
setwd("~/R/Getting and Cleaning Data Class/Class Project")

# This is the dataset meets the first 4 requirements of the assignment
# Write out the tidy dataset to a text file
write.table(all_data, file = "tidy._dataset.txt", row.names = FALSE)

# Using the above dataset created above, the rest of the program creates the tidy dataset defined in step 5

# Establish measure variables
# Segregate the melt id labels from the list of column names
id_labels <- c("Volunteer", "Activity")
column_labels <- setdiff(colnames(all_data), id_labels)

# melt all_data and prepare for recast
all_melt <- melt(all_data, id = id_labels, measure.vars = column_labels)

# Find the result by recasting the data by Volunteer and Activity
# use mean function against devined variables from melt function
result <- dcast(all_melt, Volunteer + Activity ~ variable, mean)

# Write out the second tidy dataset as required by the assignment
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(result, file = "tidy_dataset2.txt", row.names = FALSE)
