#1. Setting working directory for both computers
getwd
try(setwd("/Users/Diegotab/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3"), silent = TRUE)
try(setwd("/Users/isabellemiller/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3"), silent =TRUE)
#1. Gathering data from Quality of Government Standard Dataset 
URL <- 'http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv'
temp <- tempfile()
download.file(URL, temp)
QoGData <- read.csv(gzfile(temp, "qog_std_ts_jan16.csv"))
unlink (temp)

#2.Gathering WGI data
download.file("http://databank.worldbank.org/data/download/WGI_csv.zip",
              temp, mode="wb")
unzip(temp, "WGI_Data.csv")
wgi_allyears <- read.table("WGI_Data.csv", 
                           sep=",",skip=2, header=T)
unlink (temp)

#3. Gathering WDI data (package)
library (WDI)
Gini <- WDI(indicator="SI.POV.GINI")
GDPcapita <- WDI(indicator="NY.GDP.PCAP.CD")


####CLEAN & RESHAPE DATASET FOR MERGE: voice and accountability variable (world governance indicators)
#create new dataset omitting years 1996, 1998, 2000
wgi <- wgi_allyears[c(1,2,3,4,8,9,10,11,12,13,14,15,16,17,18,19,20)] #keep columns
wgi <- wgi[-c(2)] #remove country code
wgi <- data.frame(wgi)

#rename columns
library(dplyr)
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

colnames(gatheredest)[3] <- "VoiceandAccountability"

gatheredest <- gatheredest[order(gatheredest$cname,
                                 gatheredest$year), ] #order by country code before year

#Assign iso2c codes from country.name
library(countrycode)

gatheredest$iso2c <- countrycode(gatheredest$cname, origin = 'country.name',
                                 destination = 'iso2c', warn = TRUE) #Kosovo not matched



####CLEAN & RESHAPE DATASET FOR MERGE: GDP per capita & GINI
GDPccapita <- GDPcapita[-c(1:238),] #eliminating regional values
colnames(GDPccapita)[3] <- "GDPpercapita"
colnames(GDPccapita)[2] <- "cname"
GDPccapita <- GDPccapita[order(GDPccapita$cname,
                               GDPccapita$year), ] #order by country code before year

Ginic <- Gini[-c(1:238),] #eliminating regional values 
colnames(Ginic)[3] <- "Ginicoef"
colnames(Ginic)[2] <- "cname"
Ginic <- Ginic[order(Ginic$cname,
                     Ginic$year), ]




####CLEAN AND RESHAPE DATASET FOR MERGE: quality of governance variables
#Deleting countries that appear in the dataset but do not exist anymore, e.g.: East Germany, USSR
QoGData <- QoGData[-c(14281:14350, 11621:11690, 13931:14000, 3221:3290, 14631:14770, 14351:14420, 
                      14421:14490, 14071:14140, 13231:13300, 4691:4830, 11761:11970),] 
#Countries deleted: France(-1962), Yemen South, Yemen North, Vietnam, Czechoslovaquia, Vietnam North, 
#Vietnam South, Malaysia (-1965), Cyprus (-1974), Yugoslavia, USSR, East Germany, West Germany, Sudan
QoGDatareduced <- subset(QoGData, year>2001 & year<2015, select=c("cname", "year", "fh_aor", 
                                                                  "fh_fotpsc", "al_ethnic", 
                                                                  "al_language", "wef_ji"))
#Assign iso2codes from country.name
QoGDatareduced$iso2c <- countrycode(QoGDatareduced$cname, origin = 'country.name',
                                    destination = 'iso2c', warn = TRUE) 
#Serbia and Montenegro, Tibet not matched

#rename variables - make sure dplyr is loaded (but not plyr)
QoGDatareduced <- rename  (QoGDatareduced,
                           orgassfreedom = fh_aor,
                           pressfreedom = fh_fotpsc,
                           ethnicfrac = al_ethnic,
                           langfrac = al_language,
                           judindep = wef_ji)



#columns must have the same name and be in the same order for merging
Ginic <- Ginic[c("iso2c", "cname", "year", "Ginicoef")] #reordering
GDPccapita <- GDPccapita[c("iso2c", "cname", "year", "GDPpercapita")] #reordering

WDIcombined <- merge(Ginic, GDPccapita,by=c("iso2c","year","cname"), all = TRUE)

gatheredest <- gatheredest[c("iso2c", "cname", "year", "VoiceandAccountability")] #reordering


#reorder
QoGDatareduced <- QoGDatareduced[c("iso2c", "cname", "year", "orgassfreedom", "pressfreedom",
                                   "ethnicfrac", "langfrac", "judindep")]

#combine WDI and VoiceandAccountability
CombinedVars <- merge(WDIcombined, gatheredest,by=c("iso2c","year","cname"), all = TRUE)
#Combine all - ONLY RUN ONCE or it duplicates variables
CombinedVars <- merge(CombinedVars, QoGDatareduced,by=c("iso2c","year","cname"), all = TRUE)

#eliminating countries that appear twice with different names, small islands that have no values for 
#any of the variables...
CombinedVars <- CombinedVars[-c(651:709, 827:852, 879:917, 944:969, 977:1002, 1094:1119, 1348:1373, 
                                2345:2383, 2312:2318, 326:351, 378:403, 469:494, 508:533, 2234:2259, 
                                3250:3288, 3178:3210, 3074:3125, 2970:2995, 2820:2826, 2774:2806, 
                                2644:2669, 2514:2539, 2091:2116, 2143:2155, 1993:2012, 1915:1940, 
                                1882:1888, 1661:1686, 1563:1621, 1472:1497, 2592:2604, 2735:2747),] 



####POST-MERGE CLEANING

#reorder to put dependent variables first
CombinedVars <- CombinedVars[c("iso2c", "cname", "year", "pressfreedom", "orgassfreedom", "ethnicfrac",
                               "Ginicoef", "GDPpercapita", "VoiceandAccountability", "langfrac", 
                               "judindep")] 

#check NAs for each variable
#drop NAs for pressfreedom and ethnicfrac
colSums(is.na(CombinedVars)) 

CombinedVars2 <- CombinedVars[!is.na(CombinedVars$pressfreedom), ] #omit NAs just for that variable
#creates a new vector that omits all rows for which it is not TRUE
CombinedVars2 <- CombinedVars2[!is.na(CombinedVars2$ethnicfrac), ]

#code year as numeric
CombinedVars2$year <- as.numeric(as.character(CombinedVars$year))

#code as panel data
CombinedVars2 <- plm.data(CombinedVars2, index=c("cname", "year"))

#Create Excel sheet with final dataset
write.csv(CombinedVars2, file="FinalDataset.csv")
