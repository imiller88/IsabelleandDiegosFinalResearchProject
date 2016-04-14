getwd
setwd("/Users/Diegotab/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3")
#1. Gathering Quality of Government Standard Dataset 
URL <- 'http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv'
temp <- tempfile()
download.file(URL, temp)
QoGData <- read.csv(gzfile(temp, "qog_std_ts_jan16.csv"))
unlink (temp)

mywars <- c("cname", "year")
QoGDatareduced <- QoGData[mywars]

#2.Gathering data from World Governance Indicators
URL2 <- ""

download.file("http://databank.worldbank.org/data/download/WGI_csv.zip",
              temp, mode="wb")
unzip(temp, "WGI_Data.csv")
dd <- read.table("WGI_Data.csv", 
                 sep=",",skip=2, header=T)



