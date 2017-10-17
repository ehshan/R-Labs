# Sampling Q1


rm(list = ls())

x <- c(10, 2, 15, 6, 4, 9, 12, 11, 3, 0, 12, 10, 9, 7, 11, 10, 8, 5, 10, 6)

# A
# Length
l <- length(x)
l

# B
# Sum
s <- sum(x)
s

# C
# Mean
mean <- mean(x)
mean

# D
# Median
median <- median(x)
median

# E
# Mode
mode <- names(sort(-table(x)))[1]
mode

# F
# Quantile Ranges
q <- quantile(x)
q

# G
# Variance
v <- var(x)
v

# H
# Standard Deviation
s <- sd(x)
s


# Distrbutions Q2

# 10 observations
y <- rnorm(10, mean, 1)
y

# A
# Commands not possible - vectors not same length
cov(x,y)
cor(x,y)

# B&C
# Covariance of x&y
cov <- cov(x,y)
cov

# Correlation of x&y
cor <-cor(x,y)
cor

# D
set.seed(63)
y <- rnorm(10, mean, 1)
y




