# Get the data
##install.packages("aod")

library(aod)

mydata <-read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")


# Part: 1 check data 
head(mydata)

summary(mydata)

View(mydata)


# Part: 2 Check no of observations
nrow(mydata) # There are 400 observations


# Part: 3  Statistics 

# standard deviation
sd <- sapply(mydata [,-4], sd) # exclude rank as it is catgorical

sd

# mean
m <- sapply(mydata [,-4], mean)

m


# Part: 4 Data transformation

mydata$rank <- factor(mydata$rank)

mydata$rank


# Part 5: Logistoc Regression Model

glm.admit.fit = glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
summary(glm.admit.fit)


# Part: 6 

# This is standad one-hot encoding


# Part: 7

# All the variable z-values are large, and all the variable p values are small (<0.05) hence all the variable are statistically significant  


# Part: 8 

# Probabilities for training set 
admit.prob = predict(glm.admit.fit, type = "response")
head(admit.prob)


# Part: 9 

admit.pred = rep(1,400) # vector 1-4000
admit.pred[admit.prob<0.5]=0 # convert raw probabilities for classes  
head(admit.pred)


# Part: 10

# Confusion Matrix
table(admit.pred, mydata$admit)


# Part: 11

# get the mean values in each class
newdata1 <- with(mydata, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))

# get the prediction (probabilities) values (glm = general linear model)
newdata1$admit1.prob = predict(glm.admit.fit, newdata = newdata1, type = "response")

# display values
newdata1

# new vector 
newdata1$admit1.pred = rep(1,4)

# convert raw probabilities to class + add extra column
newdata1$admit1.pred[newdata1$admit1.prob<0.5]=0

# display data
newdata1
