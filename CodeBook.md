Getting and Cleaning Data Course Project

Code book that describes the variables, the data, and any transformations or work that you performed to clean up the data
1. Script loads and merges X_train.txt and X_test.txt to dataset data, Y_train.txt and y_test.txt to dataset label,
   subject_train.txt and subject_test.txt to dataset subject.
2. Next, extracts only the measurements on the mean and standard deviation for each measurement. This is done using grep 
   and gsub functions. 
3. Uses descriptive activity names to name the activities in the data set and saves to table activity_labels.
4. Binds subject, label, data to dataset tidyData that will later be written to tidy_data.txt.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject and 
   saves to dataset average_data.
6. Writes datasets tidy_data and average_data to tidy_data.txt and average_data.txt in local repository.
   