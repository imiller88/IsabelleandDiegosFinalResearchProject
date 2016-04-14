####CLEAN & RESHAPE DATASET FOR MERGE: voice and accountability variable (world governance indicators)
#create new dataset omitting years 1996, 1998, 2000
wgi <- wgi_allyears[c(1,2,3,4,8,9,10,11,12,13,14,15,16,17,18,19,20)] #keep columns
wgi <- wgi[-c(2)] #remove country code
wgi <- data.frame(wgi)

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
library(dplyr)
voiceandacc <- filter(wgi,wgi$variablecode == "VA.EST") #select out voice and accountability

##RESHAPING
# "long" format - data frame columns are variables and rows are specific observations
# reshape from "wide" to "long" format using tidyr package
library("tidyr")

head(voiceandacc[,1:5])

#create 2 new columns: year (key) and est (value) ; cname identifies subject - do not gather!
#therefore gather only columns 4-16
gatheredest <- gather(voiceandacc, year, est, 4:16)
gatheredest <- gatheredest[-c(2,3)] #variable and variable code are redundant
head(gatheredest)

gatheredest <- rename(gatheredest,
                      VoiceandAccountability=est)

gatheredest <- gatheredest[order(gatheredest$cname,
                           gatheredest$year), ] #order by country code before year

#Assign iso2c codes from country.name
library(countrycode)

gatheredest$iso2c <- countrycode(gatheredest$cname, origin = 'country.name',
                                 destination = 'iso2c', warn = TRUE) #Kosovo not matched



####CLEAN & RESHAPE DATASET FOR MERGE: GDP per capita & GINI
library (WDI)
Gini <- WDI(indicator="SI.POV.GINI")
GDPcapita <- WDI(indicator="NY.GDP.PCAP.CD")
GDPccapita <- GDPcapita[-c(1:238),] #eliminating regional values
Ginic <- Gini[-c(1:238),] #eliminating regional values 



####CLEAN AND RESHAPE DATASET FOR MERGE: quality of governance variables
#Assign iso2codes from country.name
QoGDatareduced$iso2c <- countrycode(QoGDatareduced$cname, origin = 'country.name',
                                 destination = 'iso2c', warn = TRUE) 
#Serbia and Montenegro, Tibet, North Yemen not matched

