# Readme
The script is split into 4 parts:
1. reading the data
2. merging the different data tables together to a table
3. subsetting to only relevant data
4. creating the second dataset of means

1.
reading the data is split into general data (features+labels), training data and testing data.

2.
merging the data together is done with rbind and cbind commands and column names are set. Furthermore the feature names given are simplyfied to avoid "()" and "-" in the columnnames. Finally the activity identifiers are replaced by the activity names (with the merge function)

3.
Part 3 deals with the requirement: *"2. Extracts only the measurements on the mean and standard deviation for each measurement."*
Only the featurecolumns that have "std" or "mean" as part of their name are taken into the relevant dataset.

4.
Part 4 creates the asked tidy data set by grouping the table after "subject" and "activity" and then calculates the mean of each feature after those groups.