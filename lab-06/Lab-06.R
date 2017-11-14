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

