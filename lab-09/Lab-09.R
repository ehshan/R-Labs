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

plot(dat, col = (dat_k2_1$cluster +1) , main = "K-Means result with 2 clusters", pch = 20, cex = 2)



# Part 5: Perform k-means with 2 clusters, and 100 starting points

set.seed(1)

dat_k2_100 <- kmeans(dat,2, nstart = 100)

dat_k2_100$cluster

dat_k2_100$tot.withinss

# Same value for total sum of squares

plot(dat, col = (dat_k2_100$cluster +1) , main = "K-Means result with 2 clusters", pch = 20, cex = 2)

# Same resulting clusters


# Part 6: Find best K value

# initialise vector to hold results
totWithinSS <- rep(0,15)

# capture total sum of squares for all k values 1-15
for(i in 1:15){
  set.seed(1)
  totWithinSS[i] = kmeans(dat,i,nstart = 100)$tot.withinss
}

totWithinSS


# Part 7: Plot results and find optimal value

plot(1:15, totWithinSS, type = "b", xlab="Number of Clusters",
     ylab = "Within groups sum of squares",
     main = "Assessing the Optimal Number of Clusters with the Elbow Method",
     pch = 20, cex = 2)

# As we can see, we start to get diminsining returns from k = 6 onwards 


# Part 8: Plot the clusters for the optimal value fo k (K = 6)

set.seed(1)

dat_k6_100 <- kmeans(dat,6,nstart = 100)

plot(dat, col = (dat_k6_100$cluster +1) , main = "K-Means result with 6 clusters", pch = 20, cex = 2)




# Hierarchical Clustering

# Load dataset

DF <- read.csv("..\\week10\\Ch10Ex11.csv", header = FALSE)


# Part 1: Transposed dataset

DF <- t(DF)


# Part 2: Calculate the dissimilarity metric

# cor computes the correlation of *columns* so we need to take the transpose of DF
D = as.dist( 1 - cor(t(DF)))
D

DFcor =  1 - cor(t(DF)) 
DFcor


# Part 3: Calcualte the different models by linkage 

# a: Complete

complete_fit <-hclust(D, method = "complete")


# b: Average

average_fit <- hclust(D, method = "average")
  
# c: Single

single_fit <- hclust(D, method = "single")
  
# d: Centroid

centroid_fit <- hclust(D, method = "centroid")


# Part 4: Plot models

# split the plot space
par(mfrow=c(2,2))

# Plot models 

plot(complete_fit, main = "Complete Linkage",cex = 0.9)

plot(average_fit, main = "Average Linkage",cex = 0.9)

plot(single_fit, main = "Single Linkage",cex = 0.9)

plot(centroid_fit, main = "Centroid Linkage",cex = 0.9)



# Part 5: Confusion Matrix

# As there are 20 heathy and 20 unhealthy samples
# Labels will be - first 20 healthy, second 20 - unhealthy
actual_labels <- c(rep(0,20), rep(1,20))

# Cut the tree at 2

# Confusion matrix for complete link
print(table(predicted = cutree(complete_fit, k = 2 ), actual = actual_labels))

# Confusion matrix for average link
print(table(predicted = cutree(average_fit, k = 2 ), actual = actual_labels)) 

# Confusion matrix for single link
print(table(predicted = cutree(single_fit, k = 2 ), actual = actual_labels))

# Confusion matrix for controid link
print(table(predicted = cutree(centroid_fit, k = 2 ), actual = actual_labels))



# Part 6: Analysis

# Part 5 shows that results will depend on the type of linkage used