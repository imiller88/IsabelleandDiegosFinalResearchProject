#declare panel data
library(plm)
CombinedVars2 <- plm.data(CombinedVars2, index=c("cname", "year"))
#did the NAs stay?

#view dataset
names(CombinedVars2) #list variables
str(CombinedVars2) #overview of dataset structure


library(dygraphs)
library(networkD3)

hist(CombinedVars2$pressfreedom, year==2005,
     main = "Press Freedom Indicator",
     ylab = "Press Freedom Score",
     xlab = "Number of Countries")

#boxplot by year
plot(pressfreedom ~ year, data = CombinedVars2, 
     xlab = "Year", las = 1,
     ylab = "Freedom Score",
     main = "Press Freedom Indicator")

plot(orgassfreedom ~ year, data = CombinedVars2, 
     xlab = "Year", las = 1,
     ylab = "Freedom Score",
     main = "Freedom of Organization and Association")

CV2002 <- subset(CombinedVars2, year == 2002)
hist(CV2002$pressfreedom,
     breaks=10,
     xlim=c(100,1))

CV2005 <- subset(CombinedVars2, year == 2005)
hist(CV2005$pressfreedom, 
     breaks=10, #equal numbers of countries in each range except top range
     xlim=c(100,1)) #reverse x axis

CV2010 <- subset(CombinedVars2, year == 2010)
hist(CV2010$pressfreedom, 
     breaks=10, #more countries move down
     xlim=c(100,1)) 

CV2014 <- subset(CombinedVars2, year == 2014)
hist(CV2014$pressfreedom, 
     breaks=10,
     xlim=c(100,1))

hist(CV2005$orgassfreedom)

