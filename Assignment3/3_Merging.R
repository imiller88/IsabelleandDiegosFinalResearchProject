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

#eliminating countries that appear twice with different names, small islands that have no values for any of the variables...
CombinedVars <- CombinedVars[-c(651:709, 827:852, 879:917, 944:969, 977:1002, 1094:1119, 1348:1373, 2345:2383, 2312:2318, 326:351, 378:403, 469:494, 508:533, 2234:2259, 3250:3288, 3178:3210, 3074:3125, 2970:2995, 2820:2826, 2774:2806, 2644:2669, 2514:2539, 2091:2116, 2143:2155, 1993:2012, 1915:1940, 1882:1888, 1661:1686, 1563:1621, 1472:1497, 2592:2604, 2735:2747),] 

#saving final version of the dataset in a csv file
write.csv(CombinedVars, file="CombinedVars.csv")