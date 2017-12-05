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


# Part 2: Perform k-means with 2 clusters

set.seed(1)

dat_k2 = kmeans(dat,2, nstart = 100)

dat_k2$tot.withinss
