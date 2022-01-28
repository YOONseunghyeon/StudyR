########################
rm(list=ls())
ls()
df=read.csv("C:/Sources/StudyR/Day2/전국무인교통단속카메라표준데이터.csv",stringsAsFactors = TRUE)
df1 = df[,c(1:9)]
write.csv(df1,'작업자료.csv')
df=read.csv('작업자료.csv',stringsAsFactors = TRUE)
str(df)