library("ggmap")
library("maptools")
library("ggplot2")
library("rworldmap")
library("sp")
library("dygraphs")
library("stargazer")
library("knitr")
library("plm")

#Descriptive statistics
#view dataset
names(CombinedVars2) #list variables
str(CombinedVars2) #overview of dataset structure
table(CombinedVars2$year)

#create subsets
CV2002 <- subset(CombinedVars2, year == 2002)
CV2005 <- subset(CombinedVars2, year == 2005)
CV2010 <- subset(CombinedVars2, year == 2010)
CV2014 <- subset(CombinedVars2, year == 2014)
pressfreedomss <- CombinedVars2[c(1,2,3,4)]
orgassfreedomss <- CombinedVars2[c(1,2,3,5)]

#create table
summary(CombinedVars2)

table1 <- summary(CombinedVars2[c(4,6,7)])
kable(table1, align = 'c', digits = 2, 
      caption = 'Measures of Central Tendency')

#simple R boxplots by year
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

#simple R histograms of press freedom over time
hist(CV2002$pressfreedom,
     breaks=10, #puts countries into bins
     xlim=c(100,1)) #reverse x axis

hist(CV2005$pressfreedom, 
     breaks=10, 
     xlim=c(100,1)) 

hist(CV2010$pressfreedom, 
     breaks=10, 
     xlim=c(100,1)) 

hist(CV2014$pressfreedom, 
     breaks=10,
     xlim=c(100,1))

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


#histograms - Gini coefficients 2005 and 2010
gini2005hist <- qplot(Ginicoef, data=CV2005, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() +
  labs(title="Distribution of Available Gini Coefficients for 2005", x="Coefficient", y="Frequency")
gini2010hist <- qplot(Ginicoef, data=CV2010, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() +
  labs(title="Distribution of Available Gini Coefficients for 2010", x="Coefficient", y="Frequency")


#boxplots - freedom of press and organizational freedom by year
bppressfreedom <- ggplot(pressfreedomss, aes(x=year, y=pressfreedom)) + geom_boxplot(fill="lightblue") + 
  labs(title="Distribution of Freedom of Press Scores by Year",x="Year", y = "Freedom Score")+
  theme_classic()

bporgassfreedom <- ggplot(orgassfreedomss, aes(x=year, y=orgassfreedom)) + geom_boxplot(fill="lightblue") + 
  labs(title="Distribution of Organization Freedom Scores by Year",x="Year", y = "Freedom Score")+
  theme_classic()

#scatter plots with ggplot2
ggplot2::ggplot(CombinedVars2, aes(ethnicfrac, pressfreedom)) + geom_point() + geom_smooth() + theme_bw() + ggtitle("Ethnic Frac-Freedom of the Press Correlation") +
  xlab("Ethnic fractionalization") +
  ylab("Freedom of the press")

##Inferential statistics
#setting data as panel data
CombinedVars2 <- plm.data(CombinedVars2, index=c("cname", "year"))
#OLS regression
M1 <- plm(pressfreedom ~ ethnicfrac + Ginicoef + GDPpercapita + VoiceandAccountability + 
            judindep + langfrac , data = CombinedVars2, model="pooling", index=c("cname", "year"))
#Fixed effects
M2 <- plm(pressfreedom ~ ethnicfrac + Ginicoef + GDPpercapita + VoiceandAccountability + 
            judindep + langfrac , data = CombinedVars2, model="within", index=c("cname", "year"))
