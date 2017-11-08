library("ggplot2")
# Clear enviroment 
#rm(list = ls())

# Load Data 
library(ISLR)

summary(Auto)

nrow(Auto)



# Part 1: Split data 

# Define the sample size (50% of dataset)
sample_size <- floor(0.5 * nrow(Auto))

set.seed(1)

# Split data 50/50
#train = sample(1:nrow (Auto), nrow(Auto)/2)
#train = sample(392, 196)
train_index <- sample(seq_len(nrow(Auto)), size = sample_size)


# Apply split to datset
train <- Auto[train_index, ]
test <- Auto[-train_index, ]

train



# Part 2: Build the linear model

lm.fit.train = lm(mpg~horsepower, data = train)

# For when train & test are not defined 
# lm.fit.train = lm(mpg~horsepower, data = Auto, subset = train)

# Model summary 
summary(lm.fit.train)



# Part 3: Estimate MSE in test set 

# ^ 2 to get the mean squared
mean((test$mpg-predict(lm.fit.train, test))^2)



# Part 4: A polynomial mode
lm.fit2.train = lm(mpg~poly(horsepower, 2), data = train)

mean((test$mpg-predict(lm.fit2.train, test))^2)# has a smaller test error

lm.fit3.train = lm(mpg~poly(horsepower, 3), data = train)

mean((test$mpg-predict(lm.fit3.train, test))^2)# has a smaller test error



# Part 5: Analysis 

# THe improvement from the linear model (1st degree) to the quadratic model (2nd) is dramatic >20%.
# The improvement from the quadratic to cubic (3r degree) is far less pronounced <1%.



# Part 6: Plot polynomial models 

rm(sample)

# Dataframe 
mse.degree <- data.frame( seed <- vector("integer", 100), degree <- vector("integer", 100), mse <- vector("double", 100))

# column names 
colnames(mse.degree) <- c("seed","degree", "mse")

# counter variable for loops
c <- 1

# for each seed
for (i in 1:10){
  
  set.seed(i)
  train_index <- sample(seq_len(nrow(Auto)), size = sample_size)
  
  # Apply split to datset
  train <- Auto[train_index, ]
  test <- Auto[-train_index, ]
  
  # for each degree
  for (j in 1:10) { 
    
    
    # fit model to j degree
    lm.fit.train <- lm(mpg~poly(horsepower, j), data = train)
    
    # Assign values to dataframe 
    mse.degree[c, 2] <- j
    mse.degree[c, 3] <- mean((test$mpg-predict(lm.fit.train, test))^2)
    mse.degree[c, 1] <- i
    
    # increment
    c <- c + 1

  }
  
}

# plot results 
ggplot(mse.degree, aes(degree, mse)) + geom_line(aes(colour = seed))



# Part 7: Leave-One-Out Cross Validation

# Fit a generalised linear model
glm.fit.train <- glm(mpg~horsepower, data = train)

# Get the intercep 
coef(glm.fit.train)

# load the boot library 
library(boot)

cv.error <- cv.glm(train, glm.fit.train)

cv.error$delta

# Put it in a loop 

deltas = vector("integer", 10)

for (i in 1:10){
  
  glm.fit.train <- glm(mpg~poly(horsepower, i), data = train)
  
  cv.error <- cv.glm(train, glm.fit.train)
  
  deltas[i] <- cv.error$delta[1]
  
}



# Part 8: Plot LOOCV

plot(seq(1:10), deltas, pch = 16, col="blue",  ylab="Mean Square Error", xlab="Degree of Polynomial", main="LOOCV")
lines(deltas, col="blue")



# Part 9: K-Folds Cross Validation

cv.errors <- vector("integer", 10)

for (i in 1:10){
  
  glm.fit.train <- glm(mpg~poly(horsepower, i), data = train)
  
  # get the first value from delta 1
  cv.errors[i] = cv.glm(train, glm.fit.train ,K=10 )$delta[1]
}


cv.errors



# Part 10: K-Folds single Plot

plot(seq(1:10), cv.errors, ylab="Mean Square Error", xlab="Degree of Polynomial", main="K-Folds Cross Validation")
lines(cv.errors, col="blue")




# Part 11: Plot K-Folds

# Vector to store results

plot(0,ylab="Mean Square Error", ylim = c(10,30), xlim= c(0,10), xlab="Degree of Polynomial", main="K-Folds Cross Validation")

kfold.errors <- matrix(nrow=10,ncol=10)

for(i in 1:10){
  
  set.seed(i)
  
  for(j in 1:10){
    
    glm.fit.train <- glm(mpg~poly(horsepower, j), data = train)
    
    kfold.errors[i, j] <- cv.glm(train, glm.fit.train ,K=10)$delta[1]
  
    }
  
  lines(kfold.errors[i, ],col=i)
}

legend(title = "degrees", "topleft",c("1","2","3","4","5","6","7","8","9","10"),lty=rep(1,10),col=1:10)



