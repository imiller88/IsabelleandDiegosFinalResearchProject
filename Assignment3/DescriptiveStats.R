names(CombinedVars)
#reorder to put dependent variables first
CombinedVars <- CombinedVars[c("iso2c", "cname", "year", "pressfreedom", "orgassfreedom", "ethnicfrac",
    "Ginicoef", "GDPpercapita", "VoiceandAccountability", "langfrac", "judindep")] 
#check NAs & summary statistics
summary(CombinedVars)

library(plm)
#setting data as panel data
CombinedVars <- plm.data(CombinedVars, index=c("cname", "year"))
#did the NAs stay?



#figure out how to do if year

