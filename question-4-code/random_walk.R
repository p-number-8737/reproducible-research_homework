#Script for simulating reproducible Brownian motion

#install.packages("ggplot2")
#install.packages("gridExtra")

#load packages required for simulations
library(ggplot2)
library(gridExtra)

#set a random seed for reproducibility which will be used as starting points in the random number generation for each step
set.seed(123) 

#create a random walk function to represent Brownian motion
random_walk  <- function (n_steps) {
  
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  
  df[1,] <- c(0,0,1) #sets start of the walk from the origin (0,0) at t = 1
  
  for (i in 2:n_steps) {
    
    h <- 0.25 #sets a fixed step distance
    
    angle <- runif(1, min = 0, max = 2*pi) #using the random seed means runif() will reproduce the same random numbers
    
    df[i,1] <- df[i-1,1] + cos(angle)*h
    
    df[i,2] <- df[i-1,2] + sin(angle)*h
    
    df[i,3] <- i
    
  }
  
  return(df)
  
}

#generate a data frame for walk 1 and produce a plot
data1 <- random_walk(500)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

#generate a data frame for walk 2 and produce a plot
data2 <- random_walk(500)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

#arrange plot1 and plot2 side by side
grid.arrange(plot1, plot2, ncol=2)
