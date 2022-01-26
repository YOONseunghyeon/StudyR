########################
rm(list=ls())
ls()
df=read.csv("C:/Sources/StudyR/Day2/전국무인교통단속카메라표준데이터.csv",stringsAsFactors = TRUE)
df1 = df[,c(1:9)]
write.csv(df1,'작업자료.csv')
df=read.csv('작업자료.csv',stringsAsFactors = TRUE)
df=df[,-1]
str(df)
##########################################################################
#####################기술통계
#####################################################################33333
names(df)[2]    ; class(names(df)[2])
summary(df[,2])
data.frame(빈도수=summary(df[,7]))
##########################################################################
#####################기술통계
#####################################################################33333
####NA값 지우고
sum(is.na(df))
colName=names(df)
cnt=length(colName)
for (i in 1:cnt){
print(colNames=[i])
print(sum(is,na(df[,i])))

##결측치 패키지 naniar
naniar
install.packages('naniar') #naniar 패키지 설치
library(naniar) #naniar 패키지를 불러옵니다.
naniar::miss_case_summary(df) # case : 행 기준
naniar::miss_var_summary(df) # variable : 변수 기준
naniar::vis_miss(df) #결측치 시각화
