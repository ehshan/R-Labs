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


# Part 2: Analysis

# If we look at the mean table, we can see that there is around 3 times more rapes than murders,
# & around 8 times more assaults than rapes.

# When we consider the variance table, we notice that, for the 3 crimes, assault has by the largest variance,
# followed by rape. Generally the higher variance can be correlated higher mean crime rate. 

# We Should also note that the figures for Urban population have no real realationship with the crime averages
# as they are taken as a rate per 100000

# As assault has by far the largest values for both tables, scaling will be required before PCA to avoid it
# dominating it.


# Part 3: Principal Component Analysis

pca <- prcomp(USArrests, scale = TRUE)

pca
