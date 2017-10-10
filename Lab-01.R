#VECTORS #Q1

#A
u1 <-seq(-10,0)
u2 <- seq(-10,0, length.out = 11)
u3 <- c(-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0)


#B
v1 <- seq(-0.1, by=0.5, length.out = 11)
v2 <- seq(-0.1, 4.9, length.out = 11)
v3 <- c(-0.1, 0.4, 0.9, 1.4, 1.9, 2.4, 2.9, 3.1, 3.9, 4.4, 4.9)

#C
#Sum
s <- u1+v1
#Product
p <- u1*v1

#D
u4 <- u1+1
v4 <-v1*0.8

#E
w <- c(u1, v1)
wl <- length(W)

#F
w1 <- w[c(14, 15, 16)]
w2 <- w[c(2, 5, 9, 21)]
w3 <- w[23]

#G
w4 <- w[3] <- 100
w5 <- replace(w, c(7, 15, 22), c(200, 300, 400) )

#H
rm(u1)

#I
rm(list = ls())

#MATRICES #Q2
B <- matrix(seq(1, by=2, length.out = 20), 4, 5, byrow = TRUE)
B1 <- B[c(2,4), c(2,3)]
