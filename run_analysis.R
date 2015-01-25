## Read the six datasets X_test, Y_test, subject_test, 
## X_train, Y_train, subject_train...
dtrainX<-read.table("./UCI HAR Dataset/train/X_train.txt")
dtrainY<-read.table("./UCI HAR Dataset/train/Y_train.txt")
dtrainS<-read.table("./UCI HAR Dataset/train/subject_train.txt")
dtestX<-read.table("./UCI HAR Dataset/test/X_test.txt")
dtestY<-read.table("./UCI HAR Dataset/test/Y_test.txt")
dtestS<-read.table("./UCI HAR Dataset/test/subject_test.txt")
## ...and combines them in a single data frame "d"
dtest<-cbind(dtestX,dtestY,dtestS)
dtrain<-cbind(dtrainX,dtrainY,dtrainS)
d<-rbind(dtest,dtrain)

## Read the name of the features...
feat<-read.table("./UCI HAR Dataset/features.txt", sep=" ")
## ...and assign them to the column names in "d"
col <-as.character(feat[,2])
make.names(col, unique=TRUE)
colnames(d)<- c(col,"act","subject")

## Select the "mean()" and "std()" columns...
## ...and the activity and subject columns
idx_m <-grep("-mean()", col)
idx_s <-grep("-std()", col)
dsel<-d[,c(idx_m,idx_s,562,563)]

## Read the name of the activities...
activ<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")
## ...convert activity codes into activity names...
act_names<-activ$V2[dsel$act]
## ...and add them into a new column "act_labels
dsel2<-cbind(dsel,act_names)
## Replace "-" in the column names by "_"
col<-gsub("-", "_", names(dsel2))
colnames(dsel2)<-make.names(col, unique=TRUE)

## Groups the data by activity and subject
grouped <- group_by(dsel2, subject,act_names)
dsum<-summarise(grouped, mean_tBodyAcc_mean.._X=mean(tBodyAcc_mean.._X),
          mean_tBodyAcc_mean.._Y=mean(tBodyAcc_mean.._Y),
          mean_tBodyAcc_mean.._Z=mean(tBodyAcc_mean.._Z),
          mean_tGravityAcc_mean.._X=mean(tGravityAcc_mean.._X),
          mean_tGravityAcc_mean.._Y=mean(tGravityAcc_mean.._Y),
          mean_tGravityAcc_mean.._Z=mean(tGravityAcc_mean.._Z),
          mean_tBodyAccJerk_mean.._X=mean(tBodyAccJerk_mean.._X),
          mean_tBodyAccJerk_mean.._Y=mean(tBodyAccJerk_mean.._Y),
          mean_tBodyAccJerk_mean.._Z=mean(tBodyAccJerk_mean.._Z),
          mean_tBodyGyro_mean.._X=mean(tBodyGyro_mean.._X),
          mean_tBodyGyro_mean.._Y=mean(tBodyGyro_mean.._Y),
          mean_tBodyGyro_mean.._Z=mean(tBodyGyro_mean.._Z),
          mean_tBodyGyroJerk_mean.._X=mean(tBodyGyroJerk_mean.._X),
          mean_tBodyGyroJerk_mean.._Y=mean(tBodyGyroJerk_mean.._Y),
          mean_tBodyGyroJerk_mean.._Z=mean(tBodyGyroJerk_mean.._Z),
          mean_tBodyAccMag_mean..=mean(tBodyAccMag_mean..),
          mean_tGravityAccMag_mean..=mean(tGravityAccMag_mean..),
          mean_tBodyAccJerkMag_mean..=mean(tBodyAccJerkMag_mean..),
          mean_tBodyGyroMag_mean..=mean(tBodyGyroMag_mean..),
          mean_tBodyGyroJerkMag_mean..=mean(tBodyGyroJerkMag_mean..),
          mean_fBodyAcc_mean.._X=mean(fBodyAcc_mean.._X),
          mean_fBodyAcc_mean.._Y=mean(fBodyAcc_mean.._Y),
          mean_fBodyAcc_mean.._Z=mean(fBodyAcc_mean.._Z),
          mean_fBodyAcc_meanFreq.._X=mean(fBodyAcc_meanFreq.._X),
          mean_fBodyAcc_meanFreq.._Y=mean(fBodyAcc_meanFreq.._Y),
          mean_fBodyAcc_meanFreq.._Z=mean(fBodyAcc_meanFreq.._Z),
          mean_fBodyAccJerk_mean.._X=mean(fBodyAccJerk_mean.._X),
          mean_fBodyAccJerk_mean.._Y=mean(fBodyAccJerk_mean.._Y),
          mean_fBodyAccJerk_mean.._Z=mean(fBodyAccJerk_mean.._Z),
          mean_fBodyAccJerk_meanFreq.._X=mean(fBodyAccJerk_meanFreq.._X),
          mean_fBodyAccJerk_meanFreq.._Y=mean(fBodyAccJerk_meanFreq.._Y),
          mean_fBodyAccJerk_meanFreq.._Z=mean(fBodyAccJerk_meanFreq.._Z),
          mean_fBodyGyro_mean.._X=mean(fBodyGyro_mean.._X),
          mean_fBodyGyro_mean.._Y=mean(fBodyGyro_mean.._Y),
          mean_fBodyGyro_mean.._Z=mean(fBodyGyro_mean.._Z),
          mean_fBodyGyro_meanFreq.._X=mean(fBodyGyro_meanFreq.._X),
          mean_fBodyGyro_meanFreq.._Y=mean(fBodyGyro_meanFreq.._Y),
          mean_fBodyGyro_meanFreq.._Z=mean(fBodyGyro_meanFreq.._Z),
          mean_fBodyAccMag_mean..=mean(fBodyAccMag_mean..),
          mean_fBodyAccMag_meanFreq..=mean(fBodyAccMag_meanFreq..),
          mean_fBodyBodyAccJerkMag_mean..=mean(fBodyBodyAccJerkMag_mean..),
          mean_fBodyBodyAccJerkMag_meanFreq..=mean(fBodyBodyAccJerkMag_meanFreq..),
          mean_fBodyBodyGyroMag_mean..=mean(fBodyBodyGyroMag_mean..),
          mean_fBodyBodyGyroMag_meanFreq..=mean(fBodyBodyGyroMag_meanFreq..),
          mean_fBodyBodyGyroJerkMag_mean..=mean(fBodyBodyGyroJerkMag_mean..),
          mean_fBodyBodyGyroJerkMag_meanFreq..=mean(fBodyBodyGyroJerkMag_meanFreq..),
          mean_tBodyAcc_std.._X=mean(tBodyAcc_std.._X),
          mean_tBodyAcc_std.._Y=mean(tBodyAcc_std.._Y),
          mean_tBodyAcc_std.._Z=mean(tBodyAcc_std.._Z),
          mean_tGravityAcc_std.._X=mean(tGravityAcc_std.._X),
          mean_tGravityAcc_std.._Y=mean(tGravityAcc_std.._Y),
          mean_tGravityAcc_std.._Z=mean(tGravityAcc_std.._Z),
          mean_tBodyAccJerk_std.._X=mean(tBodyAccJerk_std.._X),
          mean_tBodyAccJerk_std.._Y=mean(tBodyAccJerk_std.._Y),
          mean_tBodyAccJerk_std.._Z=mean(tBodyAccJerk_std.._Z),
          mean_tBodyGyro_std.._X=mean(tBodyGyro_std.._X),
          mean_tBodyGyro_std.._Y=mean(tBodyGyro_std.._Y),
          mean_tBodyGyro_std.._Z=mean(tBodyGyro_std.._Z),
          mean_tBodyGyroJerk_std.._X=mean(tBodyGyroJerk_std.._X),
          mean_tBodyGyroJerk_std.._Y=mean(tBodyGyroJerk_std.._Y),
          mean_tBodyGyroJerk_std.._Z=mean(tBodyGyroJerk_std.._Z),
          mean_tBodyAccMag_std..=mean(tBodyAccMag_std..),
          mean_tGravityAccMag_std..=mean(tGravityAccMag_std..),
          mean_tBodyAccJerkMag_std..=mean(tBodyAccJerkMag_std..),
          mean_tBodyGyroMag_std..=mean(tBodyGyroMag_std..),
          mean_tBodyGyroJerkMag_std..=mean(tBodyGyroJerkMag_std..),
          mean_fBodyAcc_std.._X=mean(fBodyAcc_std.._X),
          mean_fBodyAcc_std.._Y=mean(fBodyAcc_std.._Y),
          mean_fBodyAcc_std.._Z=mean(fBodyAcc_std.._Z),
          mean_fBodyAccJerk_std.._X=mean(fBodyAccJerk_std.._X),
          mean_fBodyAccJerk_std.._Y=mean(fBodyAccJerk_std.._Y),
          mean_fBodyAccJerk_std.._Z=mean(fBodyAccJerk_std.._Z),
          mean_fBodyGyro_std.._X=mean(fBodyGyro_std.._X),
          mean_fBodyGyro_std.._Y=mean(fBodyGyro_std.._Y),
          mean_fBodyGyro_std.._Z=mean(fBodyGyro_std.._Z),
          mean_fBodyAccMag_std..=mean(fBodyAccMag_std..),
          mean_fBodyBodyAccJerkMag_std..=mean(fBodyBodyAccJerkMag_std..),
          mean_fBodyBodyGyroMag_std..=mean(fBodyBodyGyroMag_std..),
          mean_fBodyBodyGyroJerkMag_std..=mean(fBodyBodyGyroJerkMag_std..))

## Write summarised results in a file
write.table(dsum,"./UCI HAR Dataset/sum_data.txt",row.name=FALSE)