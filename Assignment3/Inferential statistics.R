library(plm)
#setting data as panel data
CombinedVars <- plm.data(CombinedVars, index=c("cname", "year"))
#linear regression with freedom of the press as DV
M1 <- lm(pressfreedom ~ ethnicfrac + Ginicoef + GDPpercapita + VoiceandAccountability + judindep + langfrac , data = CombinedVars)
summary(M1)
#linear regression with alternative DV - freedom of association and organization
M2 <- lm(orgassfreedom ~ ethnicfrac + Ginicoef + GDPpercapita + VoiceandAccountability + judindep + langfrac , data = CombinedVars)
summary(M2)

