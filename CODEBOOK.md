fileURL - the web address for the zip file necessary for the assignment
dateDownloaded - the date the zip file was downloaded

MeasurementsFile - reading in what the 561 measurements were
Measurements - converting MeasurementsFile to a vector to be used as column headers later on

testData - reading in the test data set
testLabels - reading in the numeric codes for the activities in the test data set
testSubjects - reading in the numeric codes for the subjects in the test data set
testComplete - combining testData, testLabels, and testSubjects into 1 data frame

trainingData - reading in the training data set
trainingLabels - reading in the numeric codes for the activities in the training data set
trainingSubjects - reading in the numeric codes for the subjects in the training data set
trainingComplete - combining trainingData, trainingLabels, and trainingSubjects into 1 data frame

CombinedData - combining testComplete and trainingComplete into 1 data frame

labels - reading in what the numeric codes represent for the activities
LabeledData - adding the activity names to CombinedData

meansDF - extracting the columns in CombinedData that have the term mean in the name
stdDF - extracting the columns in CombinedData that have the term std in the name
infoDF - extracting the column with the activity names and subjects from CombinedData
filteredDF - combining meansDF, stdDF, and infoDF into 1 data frame

tidyData - grouping filteredDF by subject and activity and performing the mean on each column
