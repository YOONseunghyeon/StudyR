mus=read.csv(file="C://Sources//StudyR//부산광역시현대미술관 관람객 수20201231.csv",header=T)
mus[,c(1,3)]            #####1번
head(mus[,c(2,3)],12)   ######2번
tail(mus[,c(1,3)],12)   ######3번
head(mus[,c(2,3)],12)   ######4번

mus[is.na(mus)]
table(is.na(mus[1])

par(mfrow=c(1,3))
index =1
barplot(table(is.na(mus[index])),main=names(mus)[index])
index=2
barplot(table(is.na(mus[index])),main=names(mus)[index])
index=3
barplot(table(is.na(mus[index])),main=names(mus)[index])