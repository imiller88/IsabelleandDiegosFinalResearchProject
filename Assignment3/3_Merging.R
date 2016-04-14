#columns must have the same name and be in the same order for merging
Ginic <- Ginic[c("iso2c", "cname", "year", "Ginicoef")]
GDPccapita <- GDPccapita[c("iso2c", "cname", "year", "GDPpercapita")]

WDIcombined <- merge(Ginic, GDPccapita,by=c("iso2c","year","cname"), all = TRUE)

gatheredest <- gatheredest[c("iso2c", "cname", "year", "VoiceandAccountability")]


CombinedVars <- merge(WDIcombined, gatheredest,by=c("iso2c","year","cname"), all = TRUE)
