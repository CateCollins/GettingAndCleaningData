# Call necessary packages
library(dplyr)
# Read in all relevant data sources
# -----------------------------------------------------------------------
# Factors and labels - Links the class labels with their activity name.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# Column Names - List of all features.
features <- read.table("UCI HAR Dataset/features.txt")
# Observation identifier - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Data - Train set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
# Factors - Train labels
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
# Observation identifier - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Data - Test set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
# Factors - Test labels
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#----------------------------------------------------------------------
# Clean data - connect obsevations to variables
# Features are variable (column) names: Train and Test
# Subjects are observatins (row) names: Train and Test
# ---------------------------------------------------------------------
# Train set 
# Rename data set columns to feature names 
names(x_train) <- features[,2]
# Connect observations to data set
x_train <- bind_cols(subject_train, x_train)
# Rename the observation column
names(x_train)[1] <- "subject"
# Connect factors to observations
x_train <- bind_cols(y_train, x_train)
# Rename the test type column
names(x_train)[1] <- "activity"

# Test set 
# Rename data set columns to feature names
names(x_test) <- features[,2]
# Connect observations to variable data
x_test <- bind_cols(subject_test, x_test)
# Rename the observation column
names(x_test)[1] <- "subject"
# Connect factors to observations
x_test <- bind_cols(y_test, x_test)
# Rename the test type column
names(x_test)[1] <- "activity"

# ---------------------------------------------------------------------
#1.Merge x_train and x_test data sets to create one data set.
activity_measurement <- bind_rows(x_train, x_test, .id="subject_id")

#2.Extract only the measurements on the mean and standard deviation for each measurement.
activity_measurement <- select(activity_measurement, activity:subject, contains("mean"), contains("std"))

#3.Uses descriptive activity names to name the activities in the data set
# Convert activity column to factor
activity_measurement <- mutate(activity_measurement, subject=as.factor(subject), activity=(as.factor(activity)))
# Re-assign factors with factor label
levels(activity_measurement$activity) <- activity_labels[,2]

#4.Appropriately labels the data set with descriptive variable names.
# Remove unnecessary punctuation from column names
names(activity_measurement) <- gsub("[[:punct:]]", "", names(activity_measurement))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
activity_summary <- group_by(activity_measurement, activity, subject) %>%
    summarize_each(funs(mean))
write.csv(activity_summary, "activity_summary.csv", row.names = FALSE)
