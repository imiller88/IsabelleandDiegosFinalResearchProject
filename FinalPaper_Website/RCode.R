load("workspacefinal.RData")

library("ggmap")
library("maptools")
library("ggplot2")
library("rworldmap")
library("sp")
library("dygraphs")
library("stargazer")
library("knitr")
library("plm")

#### PREPARING DATA ####

#checking for NAs
#Returns TRUE if there are any NAs in the variable vector
any(is.na(CombinedVars2$Ginicoef))  

#returns the number of NAs in the vector
sum(is.na(CombinedVars2$Ginicoef))


#check for NAs
sum(is.na(CV2002$Ginicoef)) #160 NA
sum(is.na(CV2005$Ginicoef)) #99 NA
sum(is.na(CV2008$Ginicoef)) #95 NA
sum(is.na(CV2010$Ginicoef)) #93 NA
sum(is.na(CV2014$Ginicoef)) #160 NA

#drop rows that are NA in column 7 (ginicoef)
CV08_Gini <- CV2008[complete.cases(CV2008[,7]),]
CV10_Gini <- CV2010[complete.cases(CV2010[,7]),]

#combine 2008 and 2010 by row
CV08_10 <- rbind(CV08_Gini,CV10_Gini)

#declare panel data
CV08_10 <- plm.data(CV08_10, index=c("cname", "year"))



#### DESCRIPTIVE STATS ####

## histograms ##

gini08hist <- qplot(Ginicoef, data=CV05_Gini, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() + 
  labs(title="Distribution of Available Gini Coefficients for 2008", x="Coefficient", y="Frequency")
gini08hist

gini10hist <- qplot(Ginicoef, data=CV10_Gini, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  labs(title="Distribution of Available Gini Coefficients for 2010", x="Inequality (low to high)", y="Frequency")
gini10hist

pressfree10hist <- qplot(pressfreedom, data=CV10_Gini, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() +
  labs(title="Press Freedom, 2010", x="Freedom (least to most free)", y="Countries in sample")
pressfree10hist

ethnicfrac10hist <- qplot(ethnicfrac, data=CV10_Gini, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() +
  labs(title="Ethnic Fractionalization, 2010", x="Ethnic Fractionalization, heterogenous to homogenous", 
       y="Countries in sample")
ethnicfrac10hist

ethnicfrac10hist_nogini <- qplot(ethnicfrac, data=CV2010, geom="histogram") + geom_histogram(aes(fill = ..count..)) +
  scale_x_reverse() +
  labs(title="Ethnic Fractionalization, 2010", x="Coefficient", y="Countries")
ethnicfrac10hist_nogini

## maps ##

iso08 <- joinCountryData2Map( CV08_Gini
                             ,joinCode = "ISO2"
                             ,nameJoinColumn = "iso2c")

iso08_nogini <- joinCountryData2Map( CV2008
                                     ,joinCode = "ISO2"
                                     ,nameJoinColumn = "iso2c")

iso10 <- joinCountryData2Map( CV10_Gini
                              ,joinCode = "ISO2"
                              ,nameJoinColumn = "iso2c")

iso10_nogini <- joinCountryData2Map( CV2010
                                     ,joinCode = "ISO2"
                                     ,nameJoinColumn = "iso2c")

#ethnic fractionalization 2008
mapCountryData(iso08_nogini, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization 2008 (Before)',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               addLegend = FALSE,
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

mapCountryData(iso08, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization 2008 (After)',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               addLegend = FALSE,
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')




#ethnic fractionalization 2010
mapCountryData(iso10_nogini, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization 2010 (Before)',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               addLegend = FALSE,
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

mapCountryData(iso10, nameColumnToPlot='ethnicfrac', mapTitle= 'Ethnic Fractionalization 2010 (After)',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               addLegend = FALSE,
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

mapCountryData(iso10, nameColumnToPlot='orgassfreedom', mapTitle= 'Press Freedom 2010',
               colourPalette = c("heat"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               catMethod = 'fixedWidth',
               numCats = 6,
               borderCol='black')




## scatter plots ##
ggplot2::ggplot(CV2008, aes(ethnicfrac, pressfreedom)) + geom_point() + geom_smooth() + theme_bw() + 
  ggtitle("Ethnic Frac & Press Freedom 2008") +
  xlab("Ethnic fractionalization") +
  ylab("Press Freedom") + scale_y_reverse()


ggplot2::ggplot(CV2010, aes(ethnicfrac, pressfreedom)) + geom_point() + geom_smooth() + theme_bw() + 
  ggtitle("Ethnic Frac & Press Freedom 2010") +
  xlab("Ethnic fractionalization") +
  ylab("Freedom of the press") + scale_y_reverse()


ggplot2::ggplot(CV10_Gini, aes(ethnicfrac, pressfreedom)) + geom_point() + geom_smooth() + theme_bw() + 
  ggtitle("Ethnic Frac & Press Freedom 2010") +
  xlab("Ethnic fractionalization") +
  ylab("Press Freedom") + scale_y_reverse()





#### MODELLING ####

#OLS 2008
OLS08 <- plm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
               data = CV08_Gini, model="pooling", index=c("cname"))
summary(OLS08)

#OLS 2008 with organizational freedom
OLS08_org <- plm(orgassfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
                       data = CV08_Gini, model="pooling", index=c("cname"))
summary(OLS08_org)

#OLS 2008 without gini (more data points)
OLS08_nogini <- plm(pressfreedom ~ ethnicfrac + GDPpercapita + langfrac + judindep, 
                    data = CV2008, model="pooling", index=c("cname"))
summary(OLS08_nogini)

#OLS 2010
OLS10 <- plm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
               data = CV10_Gini, model="pooling", index=c("cname"))
summary(OLS10)

#OLS 2010 with organizational freedom
OLS10_org <- plm(orgassfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
                 data = CV10_Gini, model="pooling", index=c("cname"))
summary(OLS10_org)

#OLS 2010 without gini (more data points)
OLS10_nogini <- plm(pressfreedom ~ ethnicfrac + GDPpercapita + langfrac + judindep, 
                    data = CV2010, model="pooling", index=c("cname"))
summary(OLS10_nogini)

#OLS 2010 with logged ethnic frac
OLS10_log <- plm(pressfreedom ~ log(ethnicfrac) + GDPpercapita + langfrac + judindep, 
                    data = CV2010, model="pooling", index=c("cname"))
summary(OLS10_log)

#multicollinearity is HUGE between ethnicfrac and interaction variable, but to be expected
vif(OLS08)
vif(OLS10)
vif(OLS08_nogini)
vif(OLS10_nogini)

#OLS 2008 omitting gini coef
OLS08_nogini <- plm(pressfreedom ~ ethnicfrac + GDPpercapita + langfrac + judindep,
                    data = CV2008, model="pooling", index=c("cname"))
summary(OLS08_nogini)
vif(OLS08_nogini) #here remarkably low VIF, including with langfrac - interesting

OLS08quad <- plm(pressfreedom ~ ethnicfrac^2 + GDPpercapita + langfrac + judindep,
                data = CV2008, model="pooling", index=c("cname"))
summary(OLS08quad)

OLS08quad <- plm(pressfreedom ~ ethnicfrac^2 + GDPpercapita + langfrac + judindep,
                 data = CV2008, model="pooling", index=c("cname"))
summary(OLS08quad)

#a bunch of random crap - feel free to delete
plot(CV2008)
lines(CV2008,predict(OLS08quad,CV2008)
lines(xvec,predict(lm2,data.frame(x=xvec)))

plot(CV08_Gini$pressfreedom, CV08_Gini$ethnicfrac, ylim=c(0,1))
plot(CV08_Gini$ethnicfrac, ylim=c(0,1))
plot(CV08_Gini$ethnicfrac^2, ylim=c(0,1))
plot(CV08_Gini$Ginicoef,ylim=c(20,80))


#end of random crap


#unsuccessful attempt at fixed effects
FE08_10 <- plm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + 
                 langfrac + judindep, data = CV2005, model="within", index=c("cname", "year"))



