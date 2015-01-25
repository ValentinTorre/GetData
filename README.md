# GetData Course Project

# run_analysis.R

This R script called run_analysis.R that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Merging data
A data frame is created for each of the three training files (x_train.txt, y_train.txt, subject_train.txt), and then combined in a single dataframe "dtrain" with 7352 observations and 563 variables
The same is done for the test files to create the "dtest" dataframe with 2947 observations and 563 variables.
They are then merged in a global dataframe "d" with 10299 rows and the same 563 columns.
The names of the first 561 columns is extracted from the features.txt file (read into the "feat" dataframe with the two other columns corresponding to the activities and the train subjects.

## Extracting mean and std columns
From the names in features.txt, the indexes of those including "-mean()" and "-std()" are selected to generate a new "dsel" dataframe with 81 variables (79 related to the mean and the standard deviation plus two other for the activities and the subjects).

## Using activity names
Activity names come from activity_labels.txt, read into the "activ" dataframe The second column (V2) contains the names, which is merged with the previous "dsel" dataframe into "dsel2" that now contains a new "act_names" column.

## Descriptive variable names
The column names of "dsel2" are initially the ones coming from "feat" as done in the first step of the project.
They are now modified to make them unique (this is required to further operate with them in the following steps).

## Creating tidy data set
Data in the "dsel2" dataframe is grouped by the values in the subject and "act_names" variables in a "dgrouped" dataframe.
Then, summarise function is used to calculate the mean of every variable (79) in "dgroup". The result dataframe "dsum" has 180 columns (6 activities x 30 subjects) and 81 columns (79 variables + activity name + subject index).

Finally, the "dsum" dataframe is writen in a txt file.






