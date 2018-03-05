Files used in the project

FEATURE
========
1. features.txt -> Several features in the experiment like Body Acceleration mean, Angular Velocity etc. Around 561 features are given.
- The Feature Text file is loaded into R (using read.table()) as a table
- The Feature Data is created by just extracting the second column of the Feature table

TRAINING DATA
==============
2. x_train.txt, y_train.txt, subject_train.txt
- x_train.txt contains observations from 70% of the volunteers (The Number of Volunteers is 30). It contains the observations of the 561 features
- y_train.txt contains the ID of the Activities corresponding to the observations.
- subject_train.txt contains the ID of the Volunteers (70% of them) who participated. 
- x_train.txt is loaded into R as a table, "xtraindata"
- y_train.txt is loaded into R as a table, "ytraindata"
- subject_train.txt is loaded into R as a table, "subjecttraindata"
- The Column Name of ytraindata is changed to "ACTIVITY".
- The Column Name of subjecttraindata is changed to "VOLUNTEER"
- The Column Names of xtraindata is replaced by the Column names of Feature Data (From Step 1) so that the column names correspond to the appropriate Feature names (561 columns denoting each feature)

TEST DATA
=========
3. x_test.txt, y_test.txt, subject_test.txt
- x_test.txt is similar to x_train.txt. Its just that it has 30% of the Volunteers information. 
- x_test.txt, y_test.txt and subject_test.txt are loaded into R as tables namely, "xtestdata", "ytestdata", "subjecttestdata" similar to step 2.
- And the column name of ytestdata is changed to "ACTIVITY"
- The column name of subjecttestdata is changed to "VOLUNTEER"
- The column names of xtestdata is replaced by the column names of Feature Data (The column names denote the 561 features)

MERGE DATA
==========
4. "traindata", a data frame is created using "ytraindata", "xtraindata" and "subjecttraindata" (From Step 2)
5. "testdata", a data frame is created by using "ytestdata", "xtestdata" and "subjecttestdata" (From Step 3)
6. "alltestdata" is created by merging "traindata" and "testdata" using "rbind()" function
"alldata <- rbind(traindata, testdata)

EXTRACTING THE DESIRED INFO - MEAN AND STANDARD DEVIATION 
==========================================================
7. Index of the columns that has "Mean" and "Std"(Standard Deviation) in "alldata" (created in step 6) is retrieved using "grepl()" function
8. "newdata", a new data frame is now created by by having "Volunteers", "Activity" column from "alldata" and "Mean" and "Std" columns extracted in the previous step

GIVING DESCRIPTIVE NAMES TO THE COLUMNS
=======================================
9. "activity_labels.txt" is loaded into R as new table, "activitydata"
10. The column names of "activitydata" are changed to "Label Id" and "ACTIVITY"
11. The "Activity" column in "newdata (from Step 8) contains only Activity IDs (as numbers)
12. The Numbers in "Activity" column in the "newdata" is replaced by the Activity Label by matching it with the "Activity" column of "activitydata" table
13. Also the dots and spaces are removed and the column names of the newdata are fine tuned using gsub() function

GETTING THE FINAL TIDY DATA
============================
14. Using the "aggregate()" function from the "dplyr" package, a new data namely, "tidydata" is formed by grouping the Volunteer and the Activity column of the "newdata" and retrieving the mean of the other columns

"tidydata <- aggregate(.~Activity+Volunteer, newdata, mean)"

15. Using "write.table()" function this tidy data is written as new file, "tidydata.txt" in the same working directory where "run_analysis.R" is present.

