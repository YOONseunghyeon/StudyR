#cowsay패키지

install.packages('cowsay')
library(cowsay)
say('heoo', by='snowman')

#------------------------------------
#reshape2패키지

install.packages('reshape2')
library(reshape2)




boxplot(tips$tip)
tt=subset(tips,tip<5)
summary(tt)


str(tips)
boxplot(tip~day,data=tt)


par(mfrow=c(2,2))
tmp=subset(tips,day=='Fri')
boxplot(tip~size,data=tips)
boxplot(tip~sex,data=tips)
boxplot(tip~smoker,data=tips)
boxplot(tip~time,data=tips)



par(mfrow=c(2,2))
tmp=subset(tips,day=='Sat')
boxplot(tip~size,data=tips)
boxplot(tip~sex,data=tips)
boxplot(tip~smoker,data=tips)
boxplot(tip~time,data=tips)



