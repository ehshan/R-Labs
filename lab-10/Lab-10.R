# Clear enviroment
rm(list = ls())

# Explore the datset

?USArrests

USArrests

# List all rows headers
states = row.names(USArrests)

states


# List all column headers
names(USArrests)


# Part 1: Calculate the mean and variance of each column

# Calculate the means
apply(USArrests, 2, mean)

# calculate the variance
apply(USArrests, 2, var)
