getwd
setwd("/Users/Diegotab/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3")
#1. Gathering data from Quality of Government Standard Dataset 
URL <- 'http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv'
temp <- tempfile()
download.file(URL, temp)
QoGData <- read.csv(gzfile(temp, "qog_std_ts_jan16.csv"))
unlink (temp)

#2. Subsetting (selection of years and variables)
QoGDatareduced <- subset(QoGData, year>2001, select=c("cname", "year", "fh_aor", "fh_fotpsc", "al_ethnic", "al_language", "wef_ji"))

#2.Gathering WGI data
download.file("http://databank.worldbank.org/data/download/WGI_csv.zip",
              temp, mode="wb")
unzip(temp, "WGI_Data.csv")
wgi_allyears <- read.table("WGI_Data.csv", 
                 sep=",",skip=2, header=T)

#3.Gathering WDI data
library (WDI)
Gini <- WDI(indicator="SI.POV.GINI")
GDPcapita <- WDI(indicator="NY.GDP.PCAP.CD")
