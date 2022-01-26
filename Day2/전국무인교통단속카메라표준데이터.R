df=read.csv("C:/Sources/StudyR/Day2/전국무인교통단속카메라표준데이터.csv"
head(df)
str(df)
barplot(table(df$시도명))


## 01 , 03 , 10 ,9
tmp=subset(df, 시도명== '9')
str(tmp)




# # 시군구명이 과연 ' 서초구' 만 있나
summary(factor(tmp$소재지지번주소))
table(tmp$소재지지번주소)
unique(tmp$소재지지번주소)



#################################################
##데이터 형 변환
#### 1. character를 factor로 변환
####시도명, 시군구명, 도로종류, 도로노선번호, 도로노선명 
#### 
####2. 숫자를 factor로 변환하는 파생변수
##### 설치연도, 제한속도 (평균 설치연도, 평균 제한속도 필요할수 있다)
###########################################################################
df$시도명=factor(df$시도명)
df$시군구명=factor(df$시군구명)
df$도로노선번호=factor(df$도로노선번호)
summary(df)
str(df)
levels(df$시도명)

### 3. 필요한 컬럼만 모아서 별도의 데이터셋 제작
### 첫번째 불필요한 컬럼을 제거함으로서 수행속도를 높임
### 두번째 분석하고자 하는 내용에 맞게끔 새로운 데이터 프레임 구성
names(df)

df1=df[,c(2,3,4,7,11,13,14,16)]
str(df1)
df2=df[,c(10,11,13,14)]  #위경도로 지도 그리고 싶다면
### 4. 조건에 맞는 자료만 필터링 해서 새로운 데이터셋 제작
#### subset으로
str(df1)

# 미션, 단속구분을 unique하게 받아봄
unique(df1$단속구분)
names(df1)

# subset을 이용해 단속구분이 1인 자료만 필터링 해보기
단속1=(subset(df,단속구분=='1'))
str(단속1)

# subset을 이용하여서 제한속도가 50인 자료만 필터링
제한=subset(df,제한속도==50)    #type:int
str(제한)


### 5. 자료셋을 새로 제작해서 csv로 저장하기

unique(df1$시도명)
부산=subset(df1,시도명=='부산광역시')
unique(부산$시군구명)

sido=unique(df1$시도명)
sido[1]
length(sido)

index=1
select='경기도'
tmp=subset(df1,시도명==sido[index])
head(tmp)
head(rownames(tmp))

fileName=paste(sido[index],'.csv',sep='')
writer.csv(tmp,fileNaeme)

sido=unique(df1$시군구명)
cnt=length(sido)
index==2
for (index in 1:cnt){
 tmp=subset(df1,시군구명==sido[index])
