View(CombinedVars2)

#imputation of missing values
install.packages("missForest")
library(missForest)
CombinedVars2.mis <- prodNA(CombinedVars2, noNA=0.1)
summary (CombinedVars2.mis)
CombinedVars2.imp <- missForest(CombinedVars2.mis)
View(CombinedVars2.imp)
