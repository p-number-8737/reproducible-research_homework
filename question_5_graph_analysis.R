#Script for question 5 analysis:

#counting the number of columns and row in the dataset
data <- read.csv("/cloud/project/question-5-data/Cui_etal2014.csv")
summary(data)
nrow(data)
#33 rows
ncol(data)
#13 columns

#filter for any NA or non-finite values before log transforming
data <- data[data$Virion.volume..nm.nm.nm. > 0 & data$Genome.length..kb. > 0, ]

#applying the logarithmic transformation to data
data$log_V <- log(data$Virion.volume..nm.nm.nm.)
data$log_L <- log(data$Genome.length..kb.)

#fit the linear model to the transformed data
model <- lm(log_V ~ log_L, data = data)

#summary of the model provides alpha (estimate for Log_L) and beta (intercept)
summary(model)
#alpha = 1.5152
#beta = 7.0748 

#back-transform data
exp(7.0748)
#beta = 1181.807

ggplot(data, aes(x = log_L, y = log_V)) + 
  geom_point() +  #plot the actual data points
  geom_smooth(method = "lm", color = "blue", fill = "grey80") +  #adds linear regression line with 95% confidence interval
  theme_bw() +  
  xlab("log [Genome length (kb)]") +  #label for x-axis
  ylab("log [Virion volume (nm3)]") + #label for y-axis
  xlim(c(2, 8)) +  #set x-axis limits
  ylim(c(9, 20)) #set y-axis limits


#calculating the volume of dsDNA virus from 300 genome length
alpha <- 1.5152
beta <- 1181.807
genome_length_kb <- 300
virion_volume_nm3 <- beta * genome_length_kb^alpha
virion_volume_nm3
#answer = 6697006 nm3
