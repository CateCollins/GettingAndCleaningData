# README
Cate Collins  
February 28, 2016  
# Using R Script run_analysis.R

1. Download data from the following location:   
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip (extract) the folder "UCI HAR Dataset" to the current working directory. 
3. This file utilizes the dplyr package for data transformations. If the dplyr package is not installed currently, install it first before running the run_analysis.R script.
4. Locate the R script file run_analysis.R and source it.

# Notes

The script file run_analysis.R takes data downloaded from the above source, applies data transformations, and then creates a separate tidy data set containing the average mean and standard deviation measurements associated with a each subject performing a set of six (6) different activities.

It then reads in the following .txt files from the source listed above.

* activity_labels.txt
* features.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt

# Code Book

A complete description of the variables, data, and transformations performed can be found in the file CodeBook.md
