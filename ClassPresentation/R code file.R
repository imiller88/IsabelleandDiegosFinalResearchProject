load("workspacefinal.RData")
library("rworldmap")
library("stargazer")

#pressfreedom 2002
mapCountryData(sPDF, nameColumnToPlot='pressfreedom', mapTitle= '',
               colourPalette = c("darkgreen", "green", "yellow", "orange", "darkorange", "red"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               catMethod = 'fixedWidth',
               numCats = 6,
               borderCol='black')

#pressfreedom 2014
mapCountryData(sPDF, nameColumnToPlot='pressfreedom', mapTitle= '',
               colourPalette = c("darkgreen", "green", "yellow", "orange", "darkorange", "red"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               catMethod = 'fixedWidth',
               numCats = 6,
               borderCol='black')

#ethnicfrac 2002 (higher = more fractionalized)
mapCountryData(sPDF, nameColumnToPlot='ethnicfrac', mapTitle= '',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

#ethnicfrac 2014
mapCountryData(sPDF, nameColumnToPlot='ethnicfrac', mapTitle= '',
               colourPalette = c("light green", "green", "dark green", "black"),
               oceanCol = 'lightblue',
               missingCountryCol='white',
               catMethod = 'fixedWidth',
               numCats = 4,
               borderCol='black')

CV2008 <- subset(CombinedVars2, year == 2008)
CV2010 <- subset(CombinedVars2, year == 2010)

M1_2008 <- lm(pressfreedom ~ ethnicfrac + Ginicoef + ethnicfrac:Ginicoef + GDPpercapita + langfrac + judindep, data = CV2008)

M2_2010 <- lm(pressfreedom ~ ethnicfrac + Ginicoef + ethnicfrac:Ginicoef + GDPpercapita + langfrac + judindep, data = CV2010)

labels_IVs <- c("Ethnic Fractionalization", "Gini coefficient", "Ethnicfrac*Gini", "GDP per capita", "Judicial Independence", "Linguistic Fractionalization", ("Intercept"))
label_DV <- c("Freedom of the press")

stargazer::stargazer(M1_2008, M2_2010, dep.var.labels=label_DV, covariate.labels = labels_IVs, title = "Regression Results: Year 2008 (1) and Year 2010 (2)", digits = 2, type = "latex", header = FALSE, font.size = "tiny")
