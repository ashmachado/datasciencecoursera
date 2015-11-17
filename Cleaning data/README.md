# Getting and Cleaning Data Assignment

##run_analysis.R

###Script Description : The script does the following getting and cleaning tasks- 
	1. Reads data from two data sets (training and test), which are in text format.
	2. Merges the data read from the data sets
	3. Attaches column names and Adds two new columns - Subject and Activity. 
	5. Extracts measurements on the mean and standard deviation for each measurement variable(column).
	6. Creates a independent tidy data set based on the average of each variable for each 
	   activity and each subject.
	
###Script process: 
	1. Checks if relevant R packages - sqldf, plyr, reshape and reshape2 - are loaded or not.
	   If not, loads the packages.
	2. Loads activity levels data, replaces the "-" character and names the columns. 
	3. Loads features data which will serve as the variable(column) names. Subsets only the feature names.
	   Refer to CodeBook.md for details. 
	4. Loads the Subjects data for both data sets, merges data and prefixes "Subject" to subject value
	5. Loads the training and test data sets and merges them. Adds features as column names.
	6. Loads the activity labels and joins with activity level(steps 2)
	7. Extract measurements on the mean and standard deviation for each measurement on the merged data set.
	8. Adds column Subjects and Activity to the extracted data set.
	9. From the data set extracted in step 8, creates a independent tidy data set with the 
	   average of each variable for each activity and each subject. 

###Script execution
	1. Set working directory in R to the location where run_analysis.R file exists 
	2. Type the command -  source("run_analysis.R") and click on Enter.
	3. Below print statements are displayed based on execution.
		[1] "Start of run_analysis.R execution"
		[1] "Data merge completed"
		[1] "Data extraction completed"
		[1] "Tidy Data set completed"
		[1] "Tidy Data written to file - tidydata.txt"
		[1] "End of run_analysis.R execution"
	
	
###Cleaned Data
Cleaned and tidied dataset exists in working dir folder with file name: tidydata.txt. 
It contains one row for each subject and activity combination with mean observation for 
each feature(variable) that was a mean or standard deviation reading from original data.