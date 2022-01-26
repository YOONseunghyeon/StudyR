df=read.csv("C:/Sources/StudyR/Day2/전국무인교통단속카메라표준데이터.csv",stringsAsFactors = TRUE)
df1 = df[,c(1:9)]

##결측치 패키지 naniar
naniar
install.packages('naniar') #naniar 패키지 설치
library(naniar) #naniar 패키지를 불러옵니다.
naniar::miss_case_summary(df) # case : 행 기준
naniar::miss_var_summary(df) # variable : 변수 기준
naniar::vis_miss(df) #결측치 시각화
savePlot("무인카메라결측치",type="png")

install.packages('VIM')s
library(VIM)
VIM::aggr(df)


install.packages('Amelia')
library(Amelia)
missmap(df)
