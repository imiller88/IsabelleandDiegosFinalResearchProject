getwd
setwd("/Users/Diegotab/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3")
#1. Gathering data from Quality of Government Standard Dataset 
URL <- 'http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv'
temp <- tempfile()
download.file(URL, temp)
QoGData <- read.csv(gzfile(temp, "qog_std_ts_jan16.csv"))
unlink (temp)

#2. Subsetting (selection of years and variables)
QoGData <- QoGData[-c(14281:14350, 11621:11690, 13931:14000, 3221:3290, 14631:14770, 14351:14420, 14421:14490, 14071:14140, 13231:13300, 4691:4830, 11761:11970),] 
#Countries deleted: France(-1962), Yemen South, Yemen North, Vietnam, Czechoslovaquia, Vietnam North, Vietnam South, Malaysia (-1965), Cyprus (-1974), Yugoslavia, USSR, East Germany, West Germany, Sudan
QoGDatareduced <- subset(QoGData, year>2001 & year<2015, select=c("cname", "year", "fh_aor", "fh_fotpsc", "al_ethnic", "al_language", "wef_ji"))

#2.Gathering WGI data
download.file("http://databank.worldbank.org/data/download/WGI_csv.zip",
              temp, mode="wb")
unzip(temp, "WGI_Data.csv")
wgi_allyears <- read.table("WGI_Data.csv", 
                 sep=",",skip=2, header=T)

#3. Gathering WDI data (package)
library (WDI)
Gini <- WDI(indicator="SI.POV.GINI")
GDPcapita <- WDI(indicator="NY.GDP.PCAP.CD")


