health care data from https://data.medicare.gov/


library(ggplot2)
#import health data complications by state

data <- read.csv("Complications-State.csv",header = TRUE)
#since we cant just use the dataframe we have to create lists
#we decide to analyse the data for alabama hospitals
alabama_better <- data$Number.of.Hospitals.Better[which(data$State=="AL")]
alabama_worse <- data$Number.of.Hospitals.Worse[which(data$State=="AL")]

#the variables in our 2 lists are not numeric we need to transform them
alabama_better <- sapply(alabama_better, as.numeric)
alabama_worse <- sapply(alabama_worse, as.numeric)

#now we can get the statistics like median, mean etc for 
#better hospitals and worse hospitals
worse_summary <- summary(alabama_worse)
better_summary <- summary(alabama_better)

#now we compare both by correlation
alabama_pear <- cor(alabama_better,alabama_worse,method = "pearson")
alabama_spear <- cor(alabama_better,alabama_worse,method="spearman")


