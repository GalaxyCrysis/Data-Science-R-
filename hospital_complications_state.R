library(ggplot2)
#import health data complications by state

data <- read.csv("Complications-State.csv",header = TRUE)
#since we cant just use the dataframe we have to create lists
#we decide to analyse the data for alabama hospitals
alabama_better <- data$Number.of.Hospitals.Worse[which(data$State=="AL")]
alabama_worse <- data$Number.of.Hospitals.Better[which(data$State=="AL")]

#the variables in our 2 lists are characters so we need to transform them
counter <-0
list <- list()
for(i in alabama_better){if(i != "Not Available"){list[counter]<- strtoi(i); counter <- counter+1}}
alabama_better <- unlist(list)

counter <-0
list <- list()
for(i in alabama_worse){if(i != "Not Available"){list[counter]<- strtoi(i); counter <- counter+1}}
alabama_worse <- unlist(list)

#now we can get the statistics like median, mean etc for 
#better hospitals and worse hospitals
worse_summary <- summary(alabama_worse)
better_summary <- summary(alabama_better)

#now we compare both by correlation
alabama_pear <- cor(alabama_better,alabama_worse,method = "pearson")
alabama_spear <- cor(alabama_better,alabama_worse,method="spearman")

#now see all states and too few hospitals by pressure sores
pressure_sores <- data.frame(data$State[which(data$Measure.Name == "Pressure sores")],
                             data$Number.of.Hospitals.Too.Few[which(data$Measure.Name == "Pressure sores")],
                             row.names = c("State","Hospital"))
#get map data for mapping
