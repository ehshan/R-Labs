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
