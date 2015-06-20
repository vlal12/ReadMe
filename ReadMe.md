---
title: "ReadMe"
output: html_document
---

```
Tidy-data-project--015
==================================================================
The aim of this project is to create a tidy data set from the data provided for the project, named as the UCI HAR Dataset. This data contains 3-axial linear acceleration and 3-axial angular velocity measurements from the accelerometer and gyroscope respectively for 30 subjects and 6 activities per subject. The provided data is not exactly raw; it has been pre-processed to remove noise. The actual data is contained in two folders, one for the training and one for the test measurements respectively.
In this project, we are required to combine the given sets of data and apply certain procedures to eventually extract a tidy data set. As has been covered in the lectures for this course, in tidy data (Wickham, Hadley. "Tidy data." Under review (2014).):
* Each variable forms a column
* Each observation forms a row
* Each type of observational unit forms a table

```
```
 Extracting tidy data
==================================================================
It involves writing an R script that does the following things:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


From the data link provided for the project, the data is downloaded and unzipped in the same folder containing the R script. This folder is made the current working directory for simplified access to all files. The only files considered are the subject_test and subject_train text files in their respective test and train folders. The inertial signal data are not considered here (reasons mentioned in the forum).
```

```
Here is a link for the script: 
https://github.com/vlal12/Tidy-data-project--015/blob/master/run_analysis.R

```
The script works in the following manner:

1. The script reads all the required files (in .txt format) using read.table() and stores them in individual data frames. This step is carried out for the X, Y and subject files in both test and train folders. 

2. Using cbind(), the data frames created in step 1 are combined to produce total_test and total_train data frames. The files are combined in the order (subject, y, x). Y here contains the activity numbers.

3. Using rbind(), the test and train data frames are joined together to make a "total" data frame.

4. The feature.txt file is read in with read.table() to extract the mean and standard deviation variables to be put in the tidy data set. A function is created for this purpose that employs a built-in grep() function. We require only the mean and std dev variables that correspond to the triaxial measurements, and not variables like meanFreq. The grep() function does exactly that, in matching the pattern and selecting all the relevant variables. All these variables are finally arranged in order using the arrange() function and put in a data frame named features_subset.

5. When the "total" data set was created (step 3) by appending the subject and activity columns to the actual data, the columns names in the "total" data frame became redundant, with the first three columns named as V1. So the "total" dataframe here is again broken in two: subset1 (subject and activity columns) and subset2 ( values for measurement variables), and functions carried out separately on both.

6. An "extract_features()" function is written that extracts the variable names from the subset2 corresponding to the feature names in the features_subset. The data frame formed using this function is named total_subset2, that contains the measurement values for all mean and standard deviation variables.

7. The activity numbers in subset1 are replaced by the character names associated with the respective numbers (given in the activity labels text file) using factor().

8. The subsets (subset1 with subject and activity labels and total_subset2 with mean and standard deviation values) are joined again using cbind() to form the total_subset dataframe.

9. The total_subset data set is arranged based on subject and then the function ddply() from package plyr is used to extract the tidy data set.

10. The data set obtained from the above step contains 180 observations (6 activities for each subject, 30 subjects in total) and 66 measurements (variables). It follows the principles of tidy data as it has one observation (average value for each activity for a subject) in every row and one variable per column. For refernce, here is a part of the output:
```

head(select(tidy_data), 1:5),10):

```
   Subject           Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1        1             LAYING          0.221598       -0.04051395         -0.113204
2        1             SITING          0.261238       -0.00130829         -0.104544
3        1           STANDING          0.278918       -0.01613759         -0.110602
4        1            WALKING          0.277331       -0.01738382         -0.111148
5        1 WALKING_DOWNSTAIRS          0.289188       -0.00991850         -0.107566
6        1   WALKING_UPSTAIRS          0.255462       -0.02395315         -0.097302
7        2             LAYING          0.281373       -0.01815874         -0.107246
8        2             SITING          0.277087       -0.01568799         -0.109218
9        2           STANDING          0.277911       -0.01842083         -0.105909
10       2            WALKING          0.276427       -0.01859492         -0.105500

```
```
The github repository created for this project contains the following files:

- 'README.md'

- 'run_analysis.R': Contains the code that creates the tidy data

- 'Codebook.md': List and details of all variables.
```

