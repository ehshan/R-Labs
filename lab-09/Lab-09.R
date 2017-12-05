# Clear enviroment
rm(list = ls())

# K-means Clustering

# Load datset

# First we load the dataset, and define the subset 

library(datasets)
dat = attitude[,c(3,4)]

# Examine data
?attitude




# Part 1: Plot data

plot(dat, main = "% of favourable responses to Learning and Privilege", pch = 20, cex = 2)


# Part 2: Perform k-means with 2 clusters, and a single starting point

set.seed(1)

dat_k2_1 <- kmeans(dat,2, nstart = 1)

dat_k2_1$cluster


# Part 3: Calcualte the total within clusters sum of squares (SOS for all clusters)

dat_k2_1$tot.withinss


# Part 4: Plot the Clustering results

plot(dat, col =(dat_k2_1$cluster +1) , main = "K-Means result with 2 clusters", pch = 20, cex = 2)
