
# Create the matrix

distance <-c(3.4, 1.8, 4.6, 2.3, 3.1, 5.5, .7, 3.0, 2.6, 4.3, 2.1, 1.1, 6.1, 4.8, 3.8)

damage <- c(26.1, 17.8, 31.3, 23.1, 27.5, 36.0, 14.1, 22.3, 19.6, 31.3, 24.0, 17.3, 43.2, 36.4, 26.1)

fd <- data.frame(distance, damage)

# Basic Plot -  y is damage, x is distance
plot(distance, damage)

# Correlation 
cor(distance, damage)

# Part 1
# Build the model
# damage <- gradient(x) + intercept
fit <- lm(damage ~ distance)

#plot(fit)

# display model gradient and intercept
fit

# Part 2 & 3
# plot with regression line 
plot(distance, damage)
abline(fit)

# Part 4
summary(fit)

# Part 5
# The t-value t-is a measure of how many standard deviations our coefficient estimate is far away from 0
# T value far above 0 indicating a relationship exists 

# Likewise a small p-value indicates there is a relationship between distance and damage

# T & P values of data
#t.test(distance, damage)


# Part 6
# News values for distance (x)
newData <- c(0.5, 1.5, 2.5, 3.5)


# Predictions for new observations
predict(fit,data.frame(distance=newData, interval="confidence"))


# Part 7
# confidence level parameters for 95%
confint(fit, level=0.95)


# Part 8
# Predictions and confidence intervals for new data
predict(fit,data.frame(distance=(c(0.5, 3, 5))), interval="confidence")


# Part 9 
# Predictions and predictions intervals for new data
predict(fit,data.frame(distance=(c(0.5, 3, 5))), interval="prediction")


# Part 10
# Prediction intervals are always wider than confidence
