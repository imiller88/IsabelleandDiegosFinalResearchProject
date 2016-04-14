getwd
setwd("/Users/Diegotab/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3")
#1. Gathering data from Quality of Government Standard Dataset 
URL <- 'http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv'
temp <- tempfile()
download.file(URL, temp)
QoGData <- read.csv(gzfile(temp, "qog_std_ts_jan16.csv"))
unlink (temp)

#2. Subsetting (selection of years and variables)
QoGDatareduced <- subset(QoGData, year>2001, select=c("cname", "year", "fh_aor", "fh_fotpsc", "al_ethnic", "wdi_gini", "al_language", "wef_ji", "wdi_gdpcur"))

#2.Gathering data from World Governance Indicators
download.file("http://databank.worldbank.org/data/download/WGI_csv.zip",
              temp, mode="wb")
unzip(temp, "WGI_Data.csv")
wgi_allyears <- read.table("WGI_Data.csv", 
                 sep=",",skip=2, header=T)



