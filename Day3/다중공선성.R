#cowsay패키지

install.packages('cowsay')
library(cowsay)
say('heoo', by='snowman')

#------------------------------------
#reshape2패키지

install.packages('reshape2')
library(reshape2)


---------------------------------------------------
tips
str(tips)
table(tips[,01])
plot(tips[,1])
plot(tips[,1],tips[,2])   # 비용 내는거에 대한 팁 금액
plot(tips$size,tips$total_bill)   # 테이블인원수에 대한 지불금액

str(tips)
colNum=c(1,2,7)     # 1.total_bill 2.tip 3. sex  4.smoker 
par(mfrow=c(3,1))   # 5.day 6. time 7. size

for (i in colNum){
   plot (tips[,i],main=names(tips)[i])
}

plot(iris[,3])

-------------------------------------------------------------------
mtcars
str(mtcars)
plot(mtcars[,c(1,3,5,6)]) # 1.mpg 2.cyl 3.disp 4.hp 5.drat 6.wt 7.qesc
                          # 8.vs  9.am 10.gear 11.carb 

#피어슨 상관계수 (-1~1사이값)
cor(mtcars[,c(1,3,5,6)])


# 머신러닝(기계학습)
## 독립변수들과 종속변수의 분석을 통한 예측,분류

### 독립변수(x)끼리는 상관도가 너무 높으면 안됨.
### 상관도가 너무 높은 경우를 다중 공선성 이라함.
### 다중공선성 VIF(분산팽창지수)로 10 이상 나오는걸 의미
### 이런경우 X변수를 제거하고, VIF보고, X변수 제거하고 VIF보고

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mtcars, histogram=TRUE, pch=19)


tmp=tips[,c(2,1,7)]
chart.Correlation(tmp, histogram=TRUE, pch=19)





