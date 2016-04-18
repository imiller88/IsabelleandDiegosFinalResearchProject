#declare panel data
library(plm)
CombinedVars <- plm.data(CombinedVars, index=c("cname", "year"))
#did the NAs stay?

#view dataset
names(CombinedVars) #list variables
str(CombinedVars) #overview of dataset structure

#reorder to put dependent variables first
CombinedVars <- CombinedVars[c("iso2c", "cname", "year", "pressfreedom", "orgassfreedom", "ethnicfrac",
    "Ginicoef", "GDPpercapita", "VoiceandAccountability", "langfrac", "judindep")] 

#check NAs for each variable
colSums(is.na(CombinedVars)) 
CombinedVars2 <- na.omit(CombinedVars) #create dataset that omits NAs

library(dygraphs)

#figure out how to do if year

