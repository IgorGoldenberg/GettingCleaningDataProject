#Project Script Description
#

Files are assumed to be downloaded and unpacked. If not, one can simply add download.file and unzip functions. 

We need features.txt to load names for measurement variables and activity_labels for activity names

dplyr and data.table packages used.

## Read data
- Read features list. 
- Read X files (X_test and X-train from test and train folders) using features list as column names
- Read subject files(subject_test and Subject_train from test and train folders). They contain volunteers that participated in each test
- Read y files (y_Test and y_train from test and train folders). They contain activity performed in ech test

## Merge Data
The order is arbitary, but it must be concistent across the set. RBindList from data.table is used for it's efficiency

- XTest and XTrain merged into XSet
- SubjectTest and SubjectTrain merged into SubjectSet
- yTest and yTrain merged into ySet

## Set column names

- Names for XSet frames are set during reading.
- name for ySet is "Activity"

## Data manipulation
- Remove columns that do not contain "mean()" or "std()" from XSet. That leaves 66 columns (see codebook.md for description)
- Join SubjectSet, ySet and xSet frames together, using bind_col
- using dplyr package group by activity and subject, then calculate average for every measurement.
- Resulting data frame has 180 observation of 68 columns
- Using gather convert Wide Set to long set (**Optional**)

The choice between long and wide format depends on the further use. long format is better for database maintanence as it offers higher level of normalization.
However, Wide format might be better for reporting and statistical analysis. It also take less space on he disk.  

