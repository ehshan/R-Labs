# Clear enviroment
rm(list = ls())

# Load data

library(dplyr)

rm(list = ls())

titanic3 = read.csv("..\\Week08\\titanic3.cSV", header = TRUE)


titanic3

titanic3=select(titanic3, -name, -ticket, -boat, -body, -home.dest, -cabin) ti%>% mutate(embarked = factor(embarked),sex = factor(sex), pclass=factor(embarked))

summary(titanic3)


# Part 1: Feature Transformation

# Convert numerical variable to catagorical 

titanic3$survived01 = as.factor(titanic3$survived)

append(titanic3$survived01, titanic3)


# Part 2: Build a forest

# install package
library(randomForest)

# remove rows with missing data
titanic.clean <- na.omit(titanic3)


# Part 3: Split data 

set.seed(1)

# split the data in half

# indices 
train_index <- sample(nrow(titanic.clean), nrow(titanic.clean)/2)

# assign data
train <- titanic.clean[train_index, ]
test <- titanic.clean[-train_index, ]

# target variable from text set 
actual <- titanic.clean[-train_index, "survived"]

actual01 <- titanic.clean[-train_index, "survived01"]



# Part 4: Build random forest model 

rf.titanic <- randomForest(survived ~ . -survived01, data = train, mtry = 7,importance=TRUE)

# get predictions
prediction <- predict(rf.titanic, newdata = test)

# confusion matrix for test error
mean((prediction - actual) ^ 2)
