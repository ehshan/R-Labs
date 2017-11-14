rm(list = ls())

install.packages("readr")
install.packages("dplyr")

library(readr)
library(dplyr)

library(Titanic)

titanic3 <- "https://goo.gl/At238b" %>%
  read_csv %>% # read in the data
  select(survived, embarked, sex, sibsp, parch, fare) %>%
  mutate(embarked = factor(embarked), sex = factor(sex))


# Part 1:  Feature transformation

titanic3$survived = as.factor(titanic3$survived)

titanic3$survived

titanic3

# Part 2: Build tree

library(tree)

dead = tree(titanic3$survived ~ titanic3$embarked + 
              titanic3$sex + titanic3$sibsp + titanic3$parch +
              titanic3$fare, titanic3)

summary(dead)

plot(dead)
text(dead)

# Predictors 
# titanic3$sex   titanic3$fare  titanic3$parch

dead

# Part 3: Sampling 

# a: Split data 

nrow(titanic3)

# Define the sample size (50% of dataset)
sample_size <- floor(0.75 * nrow(titanic3))


set.seed(1)

# Split data
train_index <- sample(seq_len(nrow(titanic3)), size = sample_size)


# Apply split to datset
train <- titanic3[train_index, ]
test <- titanic3[-train_index, ]

nrow(train)

train



