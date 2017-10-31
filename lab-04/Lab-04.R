# Get the data
##install.packages("aod")

library(aod)

mydata <-read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")


# Part: 1 check data 
head(mydata)

summary(mydata)

View(mydata)