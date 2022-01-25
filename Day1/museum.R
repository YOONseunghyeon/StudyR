head(iris[,c(1:2)],6)
head(iris[,c(1,3,5)],6)
head(iris[,c("Sepal.Length","Species")],6)
head(iris[,c(1:5)],6)
head(iris[1:5,c(1:2)],6)
mus=read.csv(file="C://Sources//StudyR//부산광역시현대미술관 관람객 수20201231.csv",header=T)
str(mus)    ######구조파악
head(mus)
tmp=names(mus[1])
max(mus[,1])
summary(mus)

mus[,c(1,3)]            #####1번
head(mus[,c(2,3)],12)   ######2번
tail(mus[,c(1,3)],12)   ######3번
head(mus[,c(2,3)],12)   ######4번
install.packages("dplyr")
library(dplyr)
mus1=head(mus[!is.na(mus$관람객수),],3)
barplot(mus1)
df_mus1=mus1%>%group_by(월)
ggplot(data=df_mus1, aes(x=월, y = 관람객수)) + geom_col()
install.packages("ggplot2")
library(ggplot2)

