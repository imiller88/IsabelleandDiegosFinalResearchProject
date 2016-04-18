library("ggmap")
library("maptools")
library("ggplot2")
library("rworldmap")
library("sp")
library('rworldmap')
library("dygraphs")



#view dataset
names(CombinedVars2) #list variables
str(CombinedVars2) #overview of dataset structure
table(CombinedVars2$year)


#boxplot by year
boxplot(pressfreedom ~ year, data = CombinedVars2, 
     xlab = "Year", las = 1,
     ylab = "Freedom Score",
     main = "Press Freedom Indicator")

boxplot(orgassfreedom ~ year, data = CombinedVars2, 
     xlab = "Year", las = 1,
     ylab = "Freedom Score",
     main = "Freedom of Organization and Association")

boxplot(CombinedVars2$ethnicfrac,
        ylab = "Degree of Fractionalization",
        main = "Distribution of Degrees of Ethnic Fractionalization")

#histograms of press freedom over time
CV2002 <- subset(CombinedVars2, year == 2002)
hist(CV2002$pressfreedom,
     breaks=10, #puts countries into bins
     xlim=c(100,1)) #reverse x axis

CV2005 <- subset(CombinedVars2, year == 2005)
hist(CV2005$pressfreedom, 
     breaks=10, 
     xlim=c(100,1)) 

CV2010 <- subset(CombinedVars2, year == 2010)
hist(CV2010$pressfreedom, 
     breaks=10, 
     xlim=c(100,1)) 

CV2014 <- subset(CombinedVars2, year == 2014)
hist(CV2014$pressfreedom, 
     breaks=10,
     xlim=c(100,1))

hist(CV2005$orgassfreedom)

#rworldmap maps
#2002
sPDF <- joinCountryData2Map( CV2002
                             ,joinCode = "ISO2"
                             ,nameJoinColumn = "iso2c")

#pressfreedom 2002
mapCountryData(sPDF, nameColumnToPlot='pressfreedom', mapTitle= 'Press Freedom 2002',
               colourPalette = c("heat"),
               catMethod = 'fixedWidth',
               numCats = 8,
               borderCol='black')

#ethnicfrac 2002 (higher = more fractionalized)
mapCountryData(sPDF, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization (2002)',
               colourPalette = c("magenta", "blue", "darkorange", "green"),
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

#2014
sPDF <- joinCountryData2Map( CV2014
                             ,joinCode = "ISO2"
                             ,nameJoinColumn = "iso2c")

#pressfreedom 2014
mapCountryData(sPDF, nameColumnToPlot='pressfreedom', mapTitle= 'Press Freedom 2014',
               colourPalette = c("heat"),
               catMethod = 'fixedWidth',
               numCats = 8,
               borderCol='black')

#ethnicfrac 2014
mapCountryData(sPDF, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization (2014)',
               colourPalette = c("magenta", "blue", "darkorange", "green"),
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')






