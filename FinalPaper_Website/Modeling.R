library(plm)

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



#OLS 2008
OLS08 <- plm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
               data = CV08_Gini, model="pooling", index=c("cname"))
summary(OLS08)

#OLS 2008 with organizational freedom
OLS08_org <- plm(orgassfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
                       data = CV08_Gini, model="pooling", index=c("cname"))
summary(OLS08_org)

#OLS 2010
OLS10 <- plm(pressfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
               data = CV10_Gini, model="pooling", index=c("cname"))
summary(OLS10)

#OLS 2010 with organizational freedom
OLS10_org <- plm(orgassfreedom ~ ethnicfrac * Ginicoef + GDPpercapita + langfrac + judindep, 
                 data = CV10_Gini, model="pooling", index=c("cname"))
summary(OLS10_org)

#multicollinearity is HUGE between ethnicfrac and interaction variable, but to be expected
vif(OLS08)
vif(OLS10)

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



