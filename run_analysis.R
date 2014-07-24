## Usage:
## source("run_analysis.R")
## run_analysis()
## 
## Steps:
## 1. Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
run_analysis <- function() {
  # load all necessary data 
  test_data <- read.table("../data/test/X_test.txt", header=FALSE)
  test_subject <- read.table("../data/test/subject_test.txt", header=FALSE)
  test_activity <- read.table("../data/test/y_test.txt", header=FALSE)
  train_data <- read.table("../data/train/X_train.txt", header=FALSE)
  train_subject <- read.table("../data/train/subject_train.txt", header=FALSE)
  train_activity <- read.table("../data/train/y_train.txt", header=FALSE)
  features <- read.table("../data/features.txt", header=FALSE)
  activities <- read.table("../data/activity_labels.txt", header=FALSE)
  
  # 1. merge both data sets
  full_data <- rbind(test_data, train_data)
  
  # 2. extract only mean and standard deviation
  colnames(full_data) <- c(as.character(features[,2]))
  mean_cols <- grep("mean()", colnames(full_data), fixed=TRUE)
  sd_cols <- grep("std()",colnames(full_data),fixed=TRUE)
  # keep entries that include mean() and std()
  filtered_data <- full_data[, c(mean_cols,sd_cols)]
  
  # 3. uses descriptive activity names to name the activities in the data set
  merged_activities <- rbind(test_activity, train_activity)
  final_data <- cbind(merged_activities, filtered_data)
  # rename first column
  colnames(final_data)[1] <- "Activity"
  activities[,2] <- as.character(activities[,2])
  # loop through data frame and lookup activity name
  for(i in 1:nrow(final_data)) {
    # elememt at row i, column 1
    final_data[i, 1] <- activities[final_data[i,1], 2]
  }

  # 4. labels the data set with descriptive variable names
  var_namens <- colnames(final_data)
  for (i in 1:length(var_namens)) {
    var_namens[i] <- sub("mean\\(\\)", "Mean", var_namens[i]) 
    var_namens[i] <- sub("std\\(\\)", "StandardDeviation", var_namens[i]) 
    var_namens[i] <- sub("^t", "Time.", var_namens[i]) 
    var_namens[i] <- sub("^f", "Frequency.", var_namens[i]) 
    var_namens[i] <- gsub("-", ".", var_namens[i])
  }
  
  colnames(final_data) <- var_namens
  
  # 5. Creates a second, independent tidy data set with the average of each 
  # variable for each activity and each subject
  full_subject <- rbind(test_subject, train_subject)
  final_data <- cbind(full_subject, final_data)
  colnames(final_data)[1] <- "Subject"
  
  # https://class.coursera.org/getdata-005/forum/thread?thread_id=23
  tidy_data <- aggregate( final_data[, 3] ~ Subject+Activity, data=final_data, FUN="mean" )
  for(i in 4:ncol(final_data)) {
    tidy_data[,i] <- aggregate( final_data[,i] ~ Subject+Activity, data=final_data, FUN="mean" )[,3]
  }
  colnames(tidy_data) <- colnames(final_data)
  
  write.table(tidy_data, file="FinalTidyData.txt")
}

