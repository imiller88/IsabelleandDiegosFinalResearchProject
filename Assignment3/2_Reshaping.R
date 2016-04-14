#create new dataset omitting years 1996, 1998, 2000
wgi <- wgi_allyears[c(1,2,3,4,8,9,10,11,12,13,14,15,16,17,18,19,20)] #keep columns
wgi <- wgi[-c(2)]

#rename columns
library(plyr)

head(wgi[, 1:2])
names(wgi)
colnames(wgi)[1] <- "cname"
colnames(wgi)[2] <- "variable"

# "long" format - data frame columns are variables and rows are specific observations

library("tidyr")

head(dd[, 1:5])

