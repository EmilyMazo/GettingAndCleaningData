train <- read.table("X_train.txt")
train_lables <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
features <- read.table("features.txt")
colnames(train) <- features[,2]
train <- cbind(subject_train, train)
train <- cbind(train_lables, train)
t_label <- train[, 1]
t_label <- as.factor(t_label)
t_label <- revalue(t_label, c("1"="WALKING", "2"="WALKING_DOWNSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING"))
train[, 1] <- t_label
colnames(train)[1] <- "Activity"

test_lables <- read.table("y_test.txt")
test <- read.table("X_test.txt")
subject_test <- read.table("subject_test.txt")
colnames(test) <- features[,2]
test <- cbind(subject_test, test)
test <- cbind(test_lables, test)
test_label <- test[, 1]
test_label <- as.factor(test_label)
test_label <- revalue(test_label, c("1"="WALKING", "2"="WALKING_DOWNSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING"))
test[, 1] <- test_label
colnames(test)[1] <- "Activity"

data <-rbind(train, test)
colnames(data)[2] <- "Subject"
std <- data[, grep("[Ss]td", names(data))]
mean <- data[, grep("[Mm]ean", names(data))]
data_tidy <- cbind(data$Activity, data$Subject, std, mean)
colnames(data_tidy)[1] <- "Activity"
colnames(data_tidy)[2] <- "Subject"
aggdat <- aggregate(. ~ Subject + Activity, data = data_tidy, FUN="mean")
write.table(aggdat, file = "tidy_data.csv")