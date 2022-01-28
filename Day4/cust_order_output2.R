df <- read.csv("C:/Users/admin/Desktop/부성순강사님자료/CUST_ORDER_OUTPUT2.csv",header=TRUE)
tail(df)
#rm(list = ls())
df <- df[df$SEX != "*",] 
head(df,10)
sex1 <- subset(df, select=c(ORDER_DATE,SEX,QTY))
sex1
install.packages('lubridate')
library(lubridate)
sex2 <- cbind(sex1, month=month(sex1$ORDER_DATE))
head(sex2,5)
install.packages(‘Reshape2')
library(reshape2)
dcast(sex2, SEX ~ month,value.var=“QTY",sum)
