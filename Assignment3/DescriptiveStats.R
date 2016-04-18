#declare panel data
library(plm)
CombinedVars <- plm.data(CombinedVars, index=c("cname", "year"))
#did the NAs stay?

#view dataset
names(CombinedVars) #list variables
str(CombinedVars) #overview of dataset structure


library(dygraphs)

#figure out how to do if year

