load("/GitHub/IsabelleandDiegosFinalResearchProject/Assignment3/workspacefinal.RData")

View(CombinedVars2)

##run a simple GLM regression for 2008 (year with more Ginicoef)
CV2008 <- subset(CombinedVars2, year == 2008)

M1_2008 <- lm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, data = CV2008)
summary(M1_2008)

M2_2008 <- lm(pressfreedom ~ ethnicfrac + Ginicoef + GDPpercapita + langfrac + judindep, data = CV2008)
summary (M2_2008)

M3_2008 <- lm(pressfreedom ~ ethnicfrac * GDPpercapita + Ginicoef + langfrac + judindep, data = CV2008)
summary (M3_2008)

M4_2008 <- lm(pressfreedom ~ ethnicfrac * GDPpercapita  + langfrac + judindep, data = CV2008)
summary (M4_2008)

M3_2008 <- lm(orgassfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, data = CV2008)
summary(M3_2008)


M1_2010 <- lm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, data = CV2010)
summary(M1_2010)
