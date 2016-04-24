
# Run_Analysis.r Script

# setting the working directory

 dir<-"C:/Users/vhagu/Downloads/R/R_CD_Project"
 setwd(dir)
 
# Read in the data from the files from the UCI data set
 
 features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
 testSet<-read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors=FALSE)
 trainingSet<-read.table("./UCI HAR Dataset/train/X_train.txt",stringsAsFactors=FALSE)
 

# Name the columns in the data sets testSet and trainingSet using descriptive 
# names from the fetures data set
 
 colnames(testSet)<-c(features[,2])
 colnames(trainingSet)<-c(features[,2])
 
# Read in the data about the subjects in the experiment
 
 subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
 subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
 
# Naming columns of the subject_test and subject_train
 
  colnames(subject_test)<-"subjectNo"
  colnames(subject_train)<-"subjectNo" 

# Adding the columns of the subjects to the testSet and trainingSet data
  
 testSet<-cbind(testSet,subject_test)
 trainingSet<-cbind(trainingSet,subject_train)

# Reading the activity files which contain activities performed

 activityTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
 activityTest<-read.table("./UCI HAR Dataset/test/y_test.txt")

# Naming the coulmn of the Activity data
 
 colnames(activityTrain)<-"ActivityNo"
 colnames(activityTest)<-"ActivityNo"

# Adding the activity column to the testSet and trainingSet data

 testSet<-cbind(testSet,activityTest)
 trainingSet<-cbind(trainingSet,activityTrain)

# Counting the number of instances to make sure it is the same
# as that reported on the data website link (10299 instances)
 
 instances<-nrow(testSet)+nrow(trainingSet)
 
# Combining the training and TEst data into one data set
 
 completeDataSet<-rbind(testSet,trainingSet)

# Getting the variable names from the complete data set

 dataVariables<-colnames(completeDataSet)

# Getting the column numbers that contain the pattern "mean()"
# for mean
 
 meanVar<-meanVar<-grep("mean()",dataVariables,fixed=TRUE)
 
# Getting the column numbers that contain the pattern "std()" 
# for standard deviation
 
 stdVar<-grep("std()",dataVariables,fixed=TRUE) 

# Combining the 2 vectors  of variables
 
 meanStdVar<-c(meanVar,stdVar)
 meanStdVar<-sort(meanStdVar)

# Extract of Mean and Std variables and the SubjectNo and ActivityNo variables

 dataExtract<-completeDataSet[,c(meanStdVar,562,563)] 

# Read the files containing the activity description and number

 activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
 colnames(activity)<-c("ActivityNo","activityName") # Naming the columns

# Merging the the Data extract with the activity data set
# to include the Activity name in the complete data set
 
 dataExtract<-merge(dataExtract,activity,by.x="ActivityNo",by.y="ActivityNo")

# Creating a tidy data set of the mean of the variables in
# the data extract summarised by the Activity name 
# and the Subject Number

 tidyData<-aggregate(dataExtract[,c(2:67)],by=list(dataExtract$activityName,dataExtract$subjectNo),FUN="mean",na.rm=TRUE)

# Getting the column names from the tidyData data set
# Columns 1 and 2 containg the grouping variables activityName and subjectNo

 tidyColNames<-colnames(tidyData[,c(3:68)]) 
 
# Removing the parentheses from the column names
 
 tidyColNames<-gsub("()","",tidyColNames,fixed=TRUE)

# Renaming the tidyData data set with the new column names

 colnames(tidyData)<-c("activityName","subjectNo",tidyColNames)

# Write the tidyData to a csv file
 
 write.table(tidyData,file="tidydata.csv",sep=",",row.names=FALSE)
