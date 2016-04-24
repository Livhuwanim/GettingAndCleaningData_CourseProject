
## Run_Analysis.r Script
##
#### Assume you working on the right directory with the files

##
## dir<-"C:/Users/vhagu/Downloads/R/R_CD_Project"
## setwd(dir)
## features<-read.table("features.txt",stringsAsFactors=FALSE)
## testSet<-read.table("X_test.txt",stringsAsFactors=FALSE)
## trainingSet<-read.table("X_train.txt",stringsAsFactors=FALSE)

## colnames(testSet)<-c(features[,2])
## colnames(trainingSet)<-c(features[,2])

## subject_test<-read.table("subject_test.txt")
## subject_train<-read.table("subject_train.txt")
## colnames(subject_test)<-"subjectNo"
## colnames(subject_train)<-"subjectNo"

## testSet<-cbind(testSet,subject_test)
## trainingSet<-cbind(trainingSet,subject_train)

## 

## activityTrain<-read.table("y_train.txt")
## activityTest<-read.table("y_test.txt")
## colnames(activityTrain)<-"ActivityNo"
## colnames(activityTest)<-"ActivityNo"


## testSet<-cbind(testSet,activityTest)
## trainingSet<-cbind(trainingSet,activityTrain)
##
## instances<-nrow(testSet)+nrow(trainingSet) ##10299 instances as per UCI repository
## completeDataSet<-rbind(testSet,trainingSet)

## dataVariables<-colnames(completeDataSet)
## meanVar<-meanVar<-grep("mean()",dataVariables,fixed=TRUE) ## fixed to also include brackets to avoid meanfreq brackets to avoid any other variables with mean in the niddle
## stdVar<-grep("std()",dataVariables,fixed=TRUE) ## includes th symbols
## meanStdVar<-c(meanVar,stdVar) ## contain combined list
## 
##
## meanStdVar<-sort(meanStdVar) ## Sort vector
## head(meanStdVar,n=10)
## dataExtract<-completeDataSet[,c(meanStdVar,562,563)] ## Extract of Mean and Std, SubjectNo and ActivityNo
## 


## activity<-read.table("activity_labels.txt")
## colnames(activity)<-c("ActivityNo","activityName")
## dataExtract<-merge(dataExtract,activity,by.x="ActivityNo",by.y="ActivityNo")


## tidy<-aggregate(dataExtract[,c(2:67)],by=list(dataExtract$activityName,dataExtract$subjectNo),FUN="mean",na.rm=TRUE)

## NAming the columns

## tidyColNames<-colnames(tidy[,c(3:68)]) 
## tidyColNames<-gsub("()","",tidyColNames,fixed=TRUE)
## 
## colnames(tidy)<-c("activityName","subjectNo",tidyColNames)
## write.table(tidy,file="tidydata.csv",sep=",",row.names=FALSE)



















## Extracting certaing columns, use the colnames and the then look up coulumns with certain traits
## use grep or gsub varioations to test inclusin of a certain string.