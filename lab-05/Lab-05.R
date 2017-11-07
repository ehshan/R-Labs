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
