# Clear enviroment
rm(list = ls())

# Load data

library(dplyr)

rm(list = ls())

titanic3 = read.csv("..\\Week08\\titanic3.cSV", header = TRUE)


titanic3

titanic3=select(titanic3, -name, -ticket, -boat, -body, -home.dest, -cabin) %>% mutate(embarked = factor(embarked),sex = factor(sex), pclass=factor(embarked))

summary(titanic3)


# Part 1: Feature Transformation

# Convert numerical variable to catagorical 

titanic3$survived01 = as.factor(titanic3$survived)

append(titanic3$survived01, titanic3)


# Part 2: Build a forest

# install package
library(randomForest)

# remove rows with missing data
titanic.clean <- na.omit(titanic3)


# Part 3: Split data 

set.seed(1)

# split the data in half

# indices 
train_index <- sample(nrow(titanic.clean), nrow(titanic.clean)/2)

# assign data
train <- titanic.clean[train_index, ]
test <- titanic.clean[-train_index, ]

# target variable from text set 
actual <- titanic.clean[-train_index, "survived"]

actual01 <- titanic.clean[-train_index, "survived01"]



# Part 4: Build random forest model with continous target variable

set.seed(1)

rf.titanic <- randomForest(survived ~ . -survived01, data = train, mtry = 7,importance=TRUE)

# get predictions
prediction <- predict(rf.titanic, newdata = test)


# Assign classes
titanic.class = ifelse(prediction <= 0.5, "0", "1")

# error
mean(titanic.class != actual)

# confusion matrix for test error
#mean((prediction - actual) ^ 2)

# stats
rf.titanic


# Part 5: Random forest model with catgorial variable as target

set.seed(1)

rf.titanic01 <- randomForest(survived01 ~ . -survived, data = train, mtry = 7,importance=TRUE)

# get predictions
prediction01 <- predict(rf.titanic01, newdata = test, type="class")

# stats
rf.titanic01

# number of tree
rf.titanic01$ntree

# error
#mean(rf.titanic01$err.rate)

#errors
mean(prediction01 != actual01)


# Part 6: Variable Importance Plot

# Regression Model

importance(rf.titanic)

varImpPlot(rf.titanic)


# Classification Model

importance(rf.titanic01)

varImpPlot(rf.titanic01)

# Similar


# Part 7: Comparison of Error Rates

# The black line (madjority vote)

# vector for test error
error.mv = rep(0,200)

for (i in 1:200){
  
  set.seed(1)
 
  # new classification model
  rf.titanicC <- randomForest(survived01 ~ . -survived, data = train, mtry = 7,importance=TRUE, ntree = i)
  
  # get predictions
  predictionC <- predict(rf.titanicC, newdata = test, type = "class")
  
  error.mv[i] <- mean(predictionC != actual01)
}


# blue line 

# vector for test error
error.ave = rep(0,200)

for (j in 1:200){
  
  
  set.seed(1)
  # new classification model
  rf.titanicR <- randomForest(survived ~ . -survived01, data = train, mtry = 7,importance=TRUE, ntree = j)
  
  # get predictions
  predictionR <- predict(rf.titanicR, newdata = test)
  
  predctionR.class = ifelse(predictionR<=0.5, "0", "1")
  
  error.ave[j] <- mean(predctionR.class != actual)  
  
  #error.ave[i] <- mean((predictionR - actual) ^ 2)
}


# black line
plot(error.mv, xlab="Number of Data sets", ylab="Test Error Rate ", type="l"
     )

#blue line
lines(error.ave, col="blue")

# add red line
abline(h=error.mv[1],lty=2,col="red")


# Part 8: Experiments with number of predictors at tree splits 

# vector for mtry vaulues 
error.preds <- rep(0,7)

for (i in 1:length(error.preds)){
  
  rf.titanicM <- randomForest(survived01 ~ . -survived, data = train, mtry = i,importance=TRUE)
  
  predictionM <- predict(rf.titanicM, newdata = test, type="class")
  
  error.preds[i] <- mean(predictionM != actual01)
  
}


plot(error.preds, type="b", xlab="mtry", ylab="Test MSE")


# Part 9: Errors vs ntrees 

plot(0,ylab="Test Error", xlab="Number of Trees", main="Random Forest", xlim=c(1,540), ylim =c(0.17,0.25))

# Matrix instead of dataframe
errors.trees <- matrix(nrow=7, ncol=500 )


for (i in 1:7){

  
  for (j in 1:500) {
    
    set.seed(1)

    rf.titanicLoop <- randomForest(survived01 ~ . -survived, data = train, mtry = i,ntree = j ,importance=TRUE)    
    
    predictionLoop <- predict(rf.titanicLoop, newdata = test, type="class")
    
    errors.trees[i, j] <- mean(predictionLoop!= actual01)
    
    
  }
  
  lines(errors.trees[i, ],col=i,type="l")
 
}

legend(title="mtry","topright",c("1","2","3","4","5","6","7"),lty=rep(1,7),col=1:7)

