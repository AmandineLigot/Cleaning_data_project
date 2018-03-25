run_analysis <- function() {

  library(dplyr)

  #retrieve the column names from the features.txt file
  col_title <- read.table("features.txt")  

  #read and store the data
  
  data_train <- read.table("train/X_train.txt", col.names = col_title[,2])
  data_test <- read.table("test/X_test.txt", col.names = col_title[,2])
  subject_train <- read.table("train/subject_train.txt", col.names = "Subject")
  subject_test <- read.table("test/subject_test.txt", col.names = "Subject")
  y_test <- read.table("test/y_test.txt", col.names = "Activity")
  y_train <- read.table("train/y_train.txt", col.names = "Activity")
  activity <- read.table("activity_labels.txt", col.names = c("activity number", "activity label"))
  
  
  #merge the two data sets by rows
  tot_data <- rbind(data_train, data_test)
  
  #bind the activity reference and the subject number in one matrix
  train <- cbind(subject_train,y_train)
  test <- cbind(subject_test, y_test)
  tot <- rbind(train, test)
  
  #extract columns of the mean and standard deviation for each measurement
  tot_data <- tot_data[ , grepl("mean|std", colnames(tot_data))]
  tot_data <- tot_data[ , !grepl("meanFreq", colnames(tot_data))]
  
  #add the data on subject and activity on the data set and rearrange the data in function of subject and activity
  tot_data <- cbind(tot, tot_data)
  tot_data <- arrange(tot_data, Subject, Activity)
  
  #label the activity: replace the numbers by the descriptive variable names
  for (i in 1:nrow(tot_data)) {
    for (j in 1:nrow(activity)) {
      if (tot_data[i,2] == activity[j,1]) {
        tot_data[i,2] <- as.character(activity[j,2])
        break
      }
      
    }
    
  }
  
  #rename the columns by more appropriate labels
  
  col <- colnames(tot_data)
  
  for (i in 1:length(col)) {
    
    if (grepl("^t", col[i])) {
      col[i] <- gsub("^t", "Time", col[i])
    } 
    if (grepl("f", col[i])) {
      col[i] <- gsub("^f", "Freq", col[i])
    } 
    if (grepl("BodyBody", col[i])) {
      col[i] <- gsub("BodyBody", "Body", col[i])
    }
    
    col[i] <- gsub("mean","Mean", col[i])
    col[i] <- gsub("std","Std", col[i])
    col[i] <- gsub("\\.","", col[i])
    col[i] <- gsub("([a-z])([A-Z])", "\\1_\\2", col[i])
  }
  
  colnames(tot_data) <- col
  
  #create a new set of data with the average of each data for each activity and each subject and write it in a text file
  grouped <- group_by(tot_data, Subject, Activity)
  grouped <- summarize_all(grouped, mean)
  
  write.table(grouped, "tidy_set.txt", row.names = FALSE)
}
  
  
  
  
  
  
  
