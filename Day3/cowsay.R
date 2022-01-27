install.packages('cowsay')
library(cowsay)

say('heoo', by='snow') 
for (byName in byNameList){
       say('heoo', by=byName)
}
for (index in len(byNameList)){
       say('heoo', by=byName in byNameList[index])
}

#--------------------------------------------------------------------------
install.packages('reshape2')       ####명목형변수 : 집계할 데이터셋만 가지고있는 변수
library(reshape2)
# 자료 파악 : 변수의 성격과 해설
# total_bill : 전체지불비용
# tip : tip비용
# sex : 성별(
# smoker : 흡연석/비흡연석
# day : 요일
# time : 방문시간
# size : 방문인원

sum(is.na(tips))

###############################################################################
######## 가설과 검증
########
###############################################################################
################통계가설
#1번가설 : 성별에 따르는 tips의 비용은 같다
#              0가설(==귀무가설)
#              검증을 통헤서 비용은 같다 -> 귀무가설 채택
#              비용이 다르다 => 귀무가설 기각/ 대립가설 채택
#              pvalue통해서 확인함.(통계에서는)
# 일반적인 가설검증은 데이터집계를 통해서 비교

table(tips[,3])  # 성별의 빈도수, 전체데이터에서 발생횟수
str(tips)

table(tips[,4])  # 성별의 빈도수, 전체데이터에서 발생횟수 (for 구문으로)
for (i in 3:7){
print(paste('---',names(tips)[i],'---')) 
print(table(table(tips[,i])))  
}

#rm(list = ls())



din=subset(tips,time=='Dinner')
lun=subset(tips,time=='Lunch')

table(tips$time)
table(din$day)
table(lun$day)
head(din)

colMeans(din[c('total_bill','tip','size')])
colMeans(lun[c('total_bill','tip','size')])

colSums(din[c('total_bill','tip','size')])
colSums(lun[c('total_bill','tip','size')])
str(tips)

par(mfrow=c(2,1))
plot(din$tip)    # 누가 겁나 많이 줬는지 확인하기위해
plot(lun$tip)

summary(lun)
tmp=subset(lun, tip>=4)
tmp=subset(tips,tips$day=='Fri')
table(tmp$size)
---------------------------------------------------------------------------------

성별에 따른 tip의 차이가 없다

# tips 성별별 빈도수 확인
table(tips$sex)

S.M=subset(tips,sex=='Male')
S.F=subset(tips,sex=='Female')

summary(S.F)
summary(S.M)

par(mfrow=c(2,1))
plot(S.M$tip,main='F sum of Tips')    # 누가 겁나 많이 줬는지 확인하기위해
plot(S.F$tip,main='M sum of Tips')

par(mfrow=c(2,1))
plot(S.M$size,main='M - size')    # 누가 겁나 많이 줬는지 확인하기위해
plot(S.F$size,main='F - size')


