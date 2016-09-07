library(DBI)
library(RMySQL)
library(ggplot2)
library(xts)
library(TTR)

#connect to database
connection <- dbConnect(RMySQL::MySQL(),dbname="stocks", user ="root",password="password")

#get data from the apple table
rows <- dbSendQuery(connection,"SELECT closep,openp,date FROM apple")
apple_data <- dbFetch(rows, n = -1)

#or get data from local file of my workstation
apple <- read.csv("apple.txt",header = TRUE)

#convert numbers to date. As my data are numeric Ill use the numeric function
apple$date <- as.Date(as.character(apple$date),format="%Y%m%d")

#plot the data
ggplot(data=apple, aes(x=date,y=closep,group=1))+ 
  geom_line(colour="red",linetype="dashed",size=1.7)
  
#now i wanna compare openp and closep so we plot both at the same time
components <-  decompose(apple)
ts.plot(components)

#now i wanna plot the average with TTR MA function
moving_average <- SMA(apple$closep,n=15)
apple <- rbind(applee, moving_average)
ggplot(data=apple, aes(date))
+ geom_line(aes(y=closep),colour="red",linetype="dashed",size=1.7)
+ geom_line(aes(y=moving_average), colour="blue", linetype="dashed", size=1.7)

#statistics
#print statistics of closed price of the stock
print(summary(apple$closep))

#correlation
print(cor(apple$closep,apple$openp,method="spearman"))
print(cor(apple$closep,apple$openp,method="pearson"))

#probability distributions
print(pnorm(apple$closep))

#time series analysis
print(acf(apple$closep,plot=FALSE))
#autoregressive model
arg <- ar(apple$closep)
prediction <- predict(arg, n.ahead=4)
#plot the prediction
ts.plot(apple, prediction$pred)


