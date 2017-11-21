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
na.omit(titanic3)


# Part 3: Split data 

set.seed(1)

# split the data in half

# indices 
train_index <- sample(nrow(titanic3), nrow(titanic3)/2)

# assign data
train <- titanic3[train_index, ]
test <- titanic3[-train_index, ]

# target variable from text set 
actual <- titanic3[-train_index, "survived01"]

actual



