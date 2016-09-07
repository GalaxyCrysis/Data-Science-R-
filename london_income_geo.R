library(tmap);
library(dplyr);
library(rgdal);

#we load the spatial data from our workstation
london <- readOGR(dsn = "data", layer="LondonBoroughs");
#next we load the data for each borough via csv
#data are from http://data.london.gov.uk/dataset/london-borough-profiles
boroughs <- read.csv("data/london-borough-profiles");
#delete first row because of characters
boroughs <- boroughs[-1,];

#first Im interested in the income so lets get the median income
#since the data are not numeric we first have to convert them
boroughs<- sapply(boroughs, as.numeric);
print(median(boroughs$V42));

#map spatial data
#first we have to join both dataframes london and boroughs
#we look if the boroughs are the same in both datasets
print(london$name %in% boroughs$V2);
#after that we have to rename the colum name of v2 to name
boroughs <- rename(boroughs, name = V2);

#now we can use the dplyr method left_join to join both datasets
london@data <- left_join(london@data, boroughs);

#now we can look a the map with qtm function from tmap
qtm(london, "V42");

#now we wanna see the boroughs where income is > 40000
selection <- boroughs$V42 > 40000;
#now plot 
plot(london, col = "grey");
plot(london[selection,], col = "turquoise", add = TRUE);
