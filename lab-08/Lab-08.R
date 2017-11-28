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
test_lables <- labels[-train, ]


# Part 1: Load SVM Library


# Part 2: Linear SVM with cost = 1


# Part 3: Report Results


# Part 4: Linear SVM Plot


# Part 5: Prediction on Linear Model


# Part 6: Linear Models with cost 0.01 & 0.00001


# Part 7: Find Optimal Model


