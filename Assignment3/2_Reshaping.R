#create new dataset omitting years 1996, 1998, 2000
wgi <- wgi_allyears[c(1,2,3,4,8,9,10,11,12,13,14,15,16,17,18,19,20)] #keep columns
wgi <- wgi[-c(2)] #remove country code


#rename columns
library(plyr)

head(wgi[, 1:2])

colnames(wgi)[1] <- "cname"
colnames(wgi)[2] <- "variable"
colnames(wgi)[3] <- "variablecode"
colnames(wgi)[4] <- "2002"
colnames(wgi)[5] <- "2003"
colnames(wgi)[6] <- "2004"
colnames(wgi)[7] <- "2005"
colnames(wgi)[8] <- "2006"
colnames(wgi)[9] <- "2007"
colnames(wgi)[10] <- "2008"
colnames(wgi)[11] <- "2009"
colnames(wgi)[12] <- "2010"
colnames(wgi)[13] <- "2011"
colnames(wgi)[14] <- "2012"
colnames(wgi)[15] <- "2013"
colnames(wgi)[16] <- "2014"

#select variable of interest (voice and accountability)
wgi <- data.frame(wgi)
library(dplyr)
voiceandacc <- filter(wgi,wgi$variablecode == "VA.EST") #select out voice and accountability

# "long" format - data frame columns are variables and rows are specific observations

library("tidyr")



# Create ID for each observation and matching country codes
wgi_allyears <- mutate(wgi_allyears, ID = colnames(dd))
cc$iso2c <- countrycode(cc$wbcode, origin = "wb",destination = "iso2c", warn = TRUE)
cc$country <- countrycode(cc$iso2c, origin = "iso2c",destination = "country.name", warn = TRUE)