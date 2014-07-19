#1. Merges the training and the test sets to create one data set.
#read and merge data
train <- read.table("./data/train/X_train.txt")
dim(train)
head(train)
summary(train)
test <- read.table("./data/test/X_test.txt")
dim(test)
head(test)
summary(test)
data <- rbind(train, test)
dim(data)

#read and merge label
train <- read.table("./data/train/y_train.txt")
head(train)
table(train)
test <- read.table("./data/test/y_test.txt") 
table(test) 
head(test)
label <- rbind(train, test)
dim(label)

#read and merge subject
train <- read.table("./data/train/subject_train.txt")
head(train)
table(train)
test <- read.table("./data/test/subject_test.txt")
head(test)
table(test)
subject <- rbind(train, test)
dim(subject)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")
head(features)
dim(features)  
selectedIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(selectedIndices) 
data <- data[, selectedIndices]
names(data) <- gsub("-", "", features[selectedIndices, 2])
names(data) <- gsub("\\(\\)", "", names(data))
dim(data)

#3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./data/activity_labels.txt")
head(activity_labels)
dim(activity_labels)
a <- activity_labels[label[, 1], 2]
label[, 1] <- a
names(label) <- "Activity"
head(label)

#4. Appropriately labels the data set with descriptive variable names. 
names(subject) <- "Subject"
tidyData <- cbind(subject, label, data)
dim(tidyData) 
head(tidyData)
summary(tidyData)

#5. Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject. 
n <- length(table(subject))
m <- dim(activity_labels)[1]
nCol <- dim(tidyData)[2]
averageData <- as.data.frame(matrix(NA, nrow=n*m, ncol=nCol))
colnames(averageData) <- colnames(tidyData)
row <- 1
for(i in 1:n) {
  for(j in 1:m) {
    averageData[row, 1] <- sort(unique(subject)[, 1])[i]
    averageData[row, 2] <- activity_labels[j, 2]
    bool1 <- i == tidyData$Subject
    bool2 <- activity_labels[j, 2] == tidyData$Activity
    averageData[row, 3:nCol] <- colMeans(tidyData[bool1&bool2, 3:nCol])
    row <- row + 1
  }
}

#writes datasets to disk
write.table(tidyData, "tidy_data.txt")
dim(tidyData) 
head(tidyData)
summary(tidyData)
write.table(averageData, "average_data.txt") 
dim(averageData) 
head(averageData)
summary(averageData)
