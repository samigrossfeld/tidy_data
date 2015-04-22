library(dplyr)

if (!file.exists("data")) {
    dir.create("data")
}

    # data source address
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    # download and unzip data source
if (!file.exists("./data/samsung.zip")) {    
    download.file(fileUrl, destfile = "./data/samsung.zip", method = "curl")
    dateDownloaded <- date()
    unzip ("./data/samsung.zip", exdir = "./data")
}

    # read data files 
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

    # merge the rows of test and train data sets
x_merge <- rbind(x_test, x_train)
y_merge <- rbind(y_test, y_train)
sub_merge <- rbind(sub_test, sub_train)

    # headers assign for the three data sets into on data set

colnames(sub_merge) <- "id" 
colnames(y_merge) <- "activity"
feature_names <- read.table("./data/UCI HAR Dataset/features.txt")
colnames(x_merge) <- feature_names$V2

data_set <- cbind(sub_merge, y_merge, x_merge)
    # Extracts only the measurements on the mean and standard deviation for each measurement
tidy_data_set <- data_set[c("id", "activity", colnames(data_set)[grepl("std|mean",colnames(data_set))])]
    #Uses descriptive activity names to name the activities in the data set
activity_set <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_set) <- c("activity", "activity-lable")
    # set tidy data set with enumrated activity lable 
tidy_data_set$activity <- activity_set[tidy_data_set[,"activity"],][,"activity-lable"]

    #lable data set with descriptive variable names
colnames(tidy_data_set) <- sub("\\(\\)","", names(tidy_data_set))
colnames(tidy_data_set) <- sub("^f","Freq", names(tidy_data_set))
colnames(tidy_data_set) <- sub("^t","Time", names(tidy_data_set))
colnames(tidy_data_set) <- gsub("-","", names(tidy_data_set))
colnames(tidy_data_set) <- gsub("std","Std", names(tidy_data_set))
colnames(tidy_data_set) <- gsub("mean","Mean", names(tidy_data_set))

#reduce1 <- group_by(tidy_data_set, id, activity) %>% summarise_each(funs(mean))
reduce2 <- ddply(tidy_data_set, c("id","activity"), numcolwise(mean))
write.table(tidy_data_set, file = "reduce.tidy.txt", row.names = FALSE)
write.table(reduce2, file = "reduce.tidy.mean.txt", row.names = FALSE)







