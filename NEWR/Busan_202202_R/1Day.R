install.packages("readxl")
library(readxl)
setwd("C:/Sources/StudyR/NEWR/Busan_202202_R")
getwd()

exam= read.csv("./Data/csv_exam.csv")
View(head(exam))
str(exam)
summary(exam)
mpg = as.data.frame(ggplot2::mpg)
mpg
install.packages("dplyr")
library( )

df_raw = data.frame(var1 = c(1,2,1),
                    var2 = c(2,3,2))
# 복사본 만들기
df_new= df_raw 
#데이터 프레임의 변수명 수정
df_new = rename(df_new, v2 = var2)
df_new
df_raw


# 파생변수 (컬럼) 만들기 -> 데이터 준비하기
df = data.frame(var1=c(4,3,8),
                var2=c(2,6,1))
df$var_sum=df$var1+df$var2
df$var_sum=10
df

mpg
mpg$total = (mpg$cty+mpg$hwy)/2
# 통합 연비 변수 생성
head(mpg)
mean(mpg$total)
#요약 통계량 산출
summary(mpg$total)
# 히스토그램 생성
hist(mpg$total)

#20이상이면 pass, 그렇지 않으면 fail 부여
mpg$test = ifelse(mpg$total >= 20, "pass", "fail")

# 데이터 컨트롤 -> 중첩 조건문을 활용하여 -> 통합연비 등급 변수 추가하기
  
mpg$grade = ifelse(mpg$total >=30,"A",
                   ifelse(mpg$total>=20,"B","C"))
table(mpg$grade)
qplot(mpg$grade)
install.packages("ggplot2")
library(ggplot2)

head(mpg)


#midwest 내장데이터 
################################1번
midwest = as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)
################################2번
total = midwest$poptotal
asian = midwest$popasian
################################3번
midwest$totasian = asian/total*100
hist(midwest$totasian)
################################4번
midwest$mean_totasian= mean(midwest$totasian)
midwest$totasian1=ifelse(midwest$totasian > midwest$mean_totasian, "large", "small")
################################5번
table(midwest$totasian1)
qplot(midwest$totasian1)


#############################dplyr 함수

#조건에 맞는 데이터만 추출하기 - filter
# exam = read.csv("csv_exam.csv") 
exam
# exam에서 class가 1인 경우만 추출하여 출력
exam %>% filter(class==1)
# 1반이면서 수학 점수가 50점 이상인 경우(and), | 는 or 의미 
exam %>% filter(class==1 & math >= 50)
exam %>% filter(math >90 | english <70)

# %in% 기호 이용하기
exam %>% filter(class%in% c(1,3,5))

# 추출한 행으로 데이터 만들기
class1 = exam %>% filter(class==1)
class2 = exam %>% filter(class==2)
mean(class1$math)
mean(class2$math)

# R에서 사용하는 기호들은 왼쪽이 기준이다
# < 은 왼쪽이 기준으로하고 오른쪽에 값을 넣는다

# mpg 데이터를 이용해서 분석 문제를 해결
#############################1번
displ4=mpg %>% filter(displ<=4)
mean(displ4$hwy)
displ5=mpg %>% filter(displ>=5)
mean(displ5$hwy)
########4이하인 자동차가 고속도로 연비 평균적으로 더 높음
##############################2번
man1=mpg %>% filter(manufacturer=="audi")
man2=mpg %>% filter(manufacturer=="toyota")
mean(man1$cty)
mean(man2$cty)
#################################도요타의 평균연비가 더높음
##############################3번
man3=mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(man3$hwy)
########################## 쉐보레 포드 혼다 세 회사의 고속도로 연비(hwy) 의 합산평균은
##########################  22.50943

# Select
exam %>% select(class, math, english)
# 특정 컬럼 제외
exam %>%  select(-math)

#dplyr 함수 조합하기
exam %>%  filter(class==1 ) %>%  select(english)
exam %>% select(id, math) %>%  head


#######################mpg 데이터 분석
########################1번
new_mpg=mpg %>% select(class,cty)
str(new_mpg)
########################2번
class1=new_mpg%>% filter(class=="suv")
class2=new_mpg%>% filter(class=="compact")
mean(class1$cty)
mean(class2$cty)
##########################compact의 연비가 더높음 20.12766으로로























