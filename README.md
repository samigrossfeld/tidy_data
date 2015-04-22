## Getting and Cleaning Data
### Description
The raw data is data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
  [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

The compress data is in [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

R script called run_analysis.R that does the following :
 1. Download and decompress the zip into ./data/UCI HAR Dataset/ directory
 2. Merge the train sets and test sets for the subject(subjuct_train.txt,subject_test.txt),
    the activity(y_train.txt,y_test.txt) and the measurement(X_train.txt,X_test.txt)
 3. Use the feature.txt file as an header for the measurements
 4. Map the numeric activity into descriptive label using the activity_labels.txt
 5. Merge the subject, activity and measurement tables into one table.
 6. Extracts only the measurements on the mean and standard deviation for each measurement
 7. Label the data set with descriptive variable names ( CamelCase notation) saved to reduce.tidy.txt
 8. Create a new tidy data with the average of each variable for each activity and each subject saved to
    reduce.tidy.mean.txt

### Content

- CodeBook.md
- README.md
- run_analysis.R