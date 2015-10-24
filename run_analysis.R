library(data.table)
library(dplyr)

## read files
	FeaturesList<-read.table("features.txt",sep = " ",header = FALSE,colClasses = c("NULL", NA), col.names = c("","Measurement"))

	XTest<-read.table("test/X_test.txt", col.names = FeaturesList$Measurement, check.names = FALSE)
	XTrain<-read.table("train/X_train.txt", col.names = FeaturesList$Measurement, check.names = FALSE)
	SubjectTest<-read.table("test/subject_test.txt")
	SubjectTrain<-read.table("train/subject_train.txt")
	yTest<-read.table("test/y_test.txt")
	yTrain<-read.table("train/y_train.txt")

## merge test and training set
	XSet<-rbindlist(list(XTest, XTrain))
	SubjectSet<-rbindlist(list(SubjectTest, SubjectTrain))
	ySet<-rbindlist(list(yTest, yTrain))

## Set proper column names to subject and y sets
	colnames(SubjectSet)[1]<-"Subject"
	colnames(ySet)[1]<-"Activity"
	
## Setup activity lables
	ActivityLabels<-read.csv("activity_labels.txt", sep = " ", header = FALSE,colClasses = c("NULL", NA), col.names = c("","Activity"))
	ySet$Activity<-factor(ySet$Activity, labels = ActivityLabels$Activity)
## Remove unnecessary columns from XSet, only leave those containing "mean()" and "std()"
	XSet<-select(XSet, contains("mean()"),contains("std()"))
	MergedSet<-bind_cols(SubjectSet, ySet, XSet)
	SummaryDF<-MergedSet%>%group_by(Subject, Activity)%>%summarise_each(funs(mean))
	write.table(SummaryDF, "TidyDataSetWideFormat.txt", row.names = FALSE)
	LongSummary<-gather(SummaryDF, key=variable, value=measurement, 3:68)
	write.table(LongSummary, "TidyDataSetLongFormat.txt", row.names = FALSE)
	