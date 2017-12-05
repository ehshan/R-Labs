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



# Part 5: Perform k-means with 2 clusters, and 100 starting points

set.seed(1)

dat_k2_100 <- kmeans(dat,2, nstart = 100)

dat_k2_100$cluster

dat_k2_100$tot.withinss

# Same value for total sum of squares

plot(dat, col =(dat_k2_100$cluster +1) , main = "K-Means result with 2 clusters", pch = 20, cex = 2)

# Same resulting clusters


# Part 6: Find best K value

# initialise vector to hold results
totWithinSS = rep(0,15)

# capture total sum of squares for all k values 1-15
for(i in 1:15){
  set.seed(1)
  totWithinSS[i] = kmeans(dat,i,nstart = 100)$tot.withinss
}


# Part 7: Plot results and find optimal value

plot(1:15, totWithinSS, type = "b", xlab="Number of Clusters",
     ylab = "Within groups sum of squares",
     main = "Assessing the Optimal Number of Clusters with the Elbow Method",
     pch = 20, cex = 2)
