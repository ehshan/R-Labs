
# Create the matrix

distance <-c(3.4, 1.8, 4.6, 2.3, 3.1, 5.5, .7, 3.0, 2.6, 4.3, 2.1, 1.1, 6.1, 4.8, 3.8)

damage <- c(26.1, 17.8, 31.3, 23.1, 27.5, 36.0, 14.1, 22.3, 19.6, 31.3, 24.0, 17.3, 43.2, 36.4, 26.1)

fd <- cbind(distance, damage)

# Basic Plot
plot(distance, damage)
