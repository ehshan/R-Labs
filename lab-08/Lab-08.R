# Clear enviroment
rm(list = ls())

# Generate Linearly Separable Data

# Set seed
set.seed(300)

# Observations
observations <- 100

# Features 
feaures <- 2

# Data points for each class
data_points <- observations * feaures

# Cluster means 
pos_mean <- 0
neg_mean <- 3 

postive = matrix(rnorm(data_points, mean = pos_mean), nrow = 100, ncol = 2)
negative = matrix(rnorm(data_points, mean = neg_mean), nrow = 100, ncol = 2)

labels <- c(rep(1, 100), rep(-1, 100))

obs <- rbind(postive, negative)

data <- data.frame(x = obs, y = as.factor(labels))

plot(obs, col=ifelse( labels > 0, 1, 2))
legend("topleft",c("Positive","Negative"),col=seq(2),pch=1,text.col=seq(2))

# Split data into training & test sets

set.seed(300)

train_indices <- sample(200, 200 * 0.7)

training_set <- data[train_indices, ]

test_obs <- obs[-train_indices, ]
test_labels <- labels[-train_indices]



# Part 1: Load SVM Library

#install.packages("e1071")
library(e1071)



# Part 2: Linear SVM with cost = 1

linear_fit_1 = svm(y~.,data = training_set, kernel = "linear",cost = 1)



# Part 3: Report Results

summary(linear_fit_1)

# The results shows that there are 12 spoort vetors



# Part 4: Linear SVM Plot

plot(linear_fit_1, training_set)

# The results show that there are 3 points close to the margin, 1 on the pink side, 2 on the blue



# Part 5: Predictions on Linear Model

# predictions
prediction_linear_1 = predict(linear_fit_1, newdata = test_obs)

# error calculation
mean(prediction_linear_1 != test_labels)


# Part 6: Linear Models with cost 0.01 & 100000

# a: cost = 0.01

# build model
linear_fit_001 = svm(y~.,data = training_set, kernel = "linear",cost = 0.01)

# summary 
summary(linear_fit_001)

# 92 support vectors

# plot
plot(linear_fit_001, training_set)

# similar boundray

# predictions
prediction_linear_001 = predict(linear_fit_001, newdata = test_obs)

# error calculation
mean(prediction_linear_001 != test_labels)

# same error rate


# b: cost = 1e5

# build model
linear_fit_1e5 = svm(y~.,data = training_set, kernel = "linear",cost = 1e5)

# summary 
summary(linear_fit_1e5)

# 8 support vectors

# plot
plot(linear_fit_1e5, training_set)

# Only 2 points close to boundary on pink side

# predictions
prediction_linear_1e5 = predict(linear_fit_1e5, newdata = test_obs)

# error calculation
mean(prediction_linear_1e5 != test_labels)

# same error 



# Part 7: Find Optimal Model

set.seed(1)

# range of cost values
costs <- c(0.001,0.01,0.1,1,5,10,100,1000,10000,1e5)

tuned_fit = tune(svm, y~., data = data ,kernel="linear",ranges=list(costs))


summary(tuned_fit)

# the optimal cost parameter is 0.001



# Generate Linear inseparable dataset


# Set seed
set.seed(300)

# half and half with different means
positive_1 <- matrix(rnorm((data_points/2), mean = pos_mean), nrow = 50, ncol = 2)
positive_2 <- matrix(rnorm((data_points/2), mean = neg_mean), nrow = 50, ncol = 2)

set.seed(300)
#negative_1 = matrix(c(rnorm((data_points/2), mean = neg_mean) + 2, ), nrow = 50, ncol = 2)
#negative_2 = matrix(c(rnorm((data_points/2), mean = pos_mean) - 2, ), nrow = 50, ncol = 2)


negative_1 = matrix(c(rnorm((data_points/2),mean = neg_mean) + 3,rnorm((data_points/2),mean = neg_mean)),nrow = 50,ncol = 2)
negative_2 = matrix(c(rnorm((data_points/2),mean = pos_mean) - 3,rnorm((data_points/2),mean = pos_mean)),nrow = 50,ncol = 2)

new_labels <- c(rep(1, 100), rep(-1, 100))

new_obs <- rbind(positive_1, positive_2, negative_1, negative_2)

new_data <- data.frame(x = new_obs, y = as.factor(new_labels))

plot(new_obs, col=ifelse(new_labels > 0, 1, 2))
legend("topleft",c("Positive","Negative"),col=seq(2),pch=1,text.col=seq(2))



# Split data into training & test sets (all variables have 'new' prefix)

set.seed(300)

new_train_indices <- sample(200, 200 * 0.7)

new_training_set <- new_data[new_train_indices, ]

new_test_obs <- obs[-new_train_indices, ]
new_test_labels <- labels[-new_train_indices]


# Part 8: SVM model with a radial kernel, gamma =1 and cost = 1.


non_linear_fit_1 = svm(y~.,data = new_training_set, kernel = "radial",gamma = 1, cost = 1)

# a: Summary

summary(non_linear_fit_1)

# 28 support vectors


# b: Plot 

plot(non_linear_fit_1, new_training_set)


# C: Test error

# predictions
prediction_non_linear_1 = predict(non_linear_fit_1, newdata = new_test_obs)

# error calculation
mean(prediction_non_linear_1 != new_test_labels)

# error of 0.5


# Part 9: SVM model with a radial kernel, gamma =1 and cost = 1e5.


# build model
non_linear_fit_1e5 = svm(y~.,data = new_training_set, kernel = "radial",gamma = 1,cost = 1e5)


# a: Summary

summary(non_linear_fit_1e5)

# 12 support vectors


# b: Plot 

plot(non_linear_fit_1e5, new_training_set)


# C: Test error

# predictions
prediction_non_linear_1e5 = predict(non_linear_fit_1e5, newdata = new_test_obs)

# error calculation
mean(prediction_non_linear_1e5 != new_test_labels)

# error of  0.4833333 - slight inprovement


# Part 10: Final optimal values for cost and gamma 

set.seed(1)

costs <- c(0.001,0.01,0.1,1,5,10,100,1000,10000,1e5)

gammas <- c(0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4)

tuned_radial <- tune(svm,y~.,data = new_training_set, kernel = "radial",ranges = list(cost = costs, gamma = gammas))

summary(tuned_radial)

# Best value for cost is 0.1

# Best value for gamma is 0.5


# Part 11: Test error on optimal model

prediction_optimal_radial = predict(tuned_radial$best.model, newdata = new_test_obs)
rrr
mean(prediction_optimal_radial != new_test_labels)

# Error of 0.5