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


