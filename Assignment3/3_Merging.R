#columns must have the same name and be in the same order for merging
Ginic <- Ginic[c("iso2c", "cname", "year", "Ginicoef")] #reordering
GDPccapita <- GDPccapita[c("iso2c", "cname", "year", "GDPpercapita")] #reordering

WDIcombined <- merge(Ginic, GDPccapita,by=c("iso2c","year","cname"), all = TRUE)

gatheredest <- gatheredest[c("iso2c", "cname", "year", "VoiceandAccountability")] #reordering

#reorder
QoGDatareduced <- QoGDatareduced[c("iso2c", "cname", "year", "orgassfreedom", "pressfreedom",
                                   "ethnicfrac", "langfrac", "judindep")]

#ONLY RUN ONCE or it duplicates variables
CombinedVars <- merge(CombinedVars, QoGDatareduced,by=c("iso2c","year","cname"), all = TRUE)
CombinedVars <- CombinedVars[-c(7:11)] 
