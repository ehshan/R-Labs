# Clear enviroment 
rm(list = ls())

# Load Data 
library(ISLR)

summary(Auto)

nrow(Auto)


# Part 1: Split data 

# Define the sample size (50% of dataset)
sample_size <- floor(0.5 * nrow(Auto))

set.seed(1)

# Split data 50/50
#train = sample(1:nrow (Auto), nrow(Auto)/2)
#train = sample(392, 196)
train_index <- sample(seq_len(nrow(Auto)), size = sample_size)

# Apply split to datset
train <- Auto[train_index, ]
test <- Auto[-train_index, ]

train

# Part 2: Build the linear model

# Part 2: Build the linear model
lm.fit.train = lm(mpg~horsepower, data = train)

# For when train & test are not defined 
# lm.fit.train = lm(mpg~horsepower, data = Auto, subset = train)

# Model summary 
summary(lm.fit.train)

# Part 3: Estimate MSE in test set 

# ^ 2 to get the mean squared
mean((test$mpg-predict(lm.fit.train, test))^2)

# Part 4: A polynomial mode
lm.fit2.train = lm(mpg~poly(horsepower, 2), data = train)

mean((test$mpg-predict(lm.fit2.train, test))^2)# has a smaller test error

lm.fit3.train = lm(mpg~poly(horsepower, 3), data = train)

mean((test$mpg-predict(lm.fit3.train, test))^2)# has a smaller test error

# Part 5: Analysis 

# THe improvement from the linear model (1st degree) to the quadratic model (2nd) is dramatic >20%.
# The improvement from the quadratic to cubic (3r degree) is far less pronounced <1%.


