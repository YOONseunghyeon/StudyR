library(readxl)
library(dplyr)
library(ggplot2)
#rm(list=ls())
mpg = as.data.frame(ggplot2::mpg)

# 시계열 그래프 만들기  - 년도별 실업률
ggplot(data = economics, aes(x= date, y = unemploy))+ geom_line()
head(economics)

# psavert(개인저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다.
# 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.
ggplot(data = economics, aes(x= date, y = psavert))+ geom_line()

# 상자 그림 만들기
ggplot(data = mpg, aes(x = drv, y = hwy))+ geom_boxplot()

# class(자동차종류)가 "compact", "subcompact","suv"인 자동차의 cty(도시 연비)가
# 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만드세요
class_mpg = mpg %>% filter(class %in% c("compact", "subcompact","suv"))
ggplot(data = class_mpg, aes(x = class, y = cty))+ geom_boxplot()


#############################################################################
# 데이터 분석 프로잭트
install.packages("foreign")
library(foreign)    # SPSS 파일 로드  
library(readxl)     # 엑셀파일 불러오기
library(dplyr)      # 전처리
library(ggplot2)    # 시각화

# 데이터 불러오기
raw_welfare = read.spss(file = "./Koweps_hpc10_2015_beta1.sav",
                        to.data.frame = T)

setwd("C:/Sources/StudyR/NEWR/Busan_202202_R/Data")
getwd()

# 복사본 만들기
welfare =raw_welfare
dim(welfare)  # 데이터 갯수
summary(welfare)
welfare$h10_g3

# 변수명 변경
welfare <- rename(welfare,
                  sex= h10_g3,             # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드

head(welfare)
str(welfare)
head(welfare$birth)
head(welfare$age)

table(is.na(welfare$income))
class(welfare$sex)               # numeric = 숫자값
table(welfare$sex)           # 이상치 확인  
welfare$sex = ifelse(welfare$sex ==  9, NA , welfare$sex) #--이상치 결측 처리
table(is.na(welfare$sex))   # 결측치 확인

# 성별 항목 이름 부여
welfare$sex = ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex) # 빈도 확인 막대그래프 qplot

#월급 변수 검토 및 전처리
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)+xlim(0,1000)
welfare$income = ifelse(welfare$income %in% c(0,9999),NA , welfare$income)
table(is.na(welfare$income))

# 성별 월급 평균표 만들기
sex_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income=mean(income))
ggplot(data=sex_income,aes(x=sex,y=mean_income))+geom_col() 

#나이 변수 검토 및 전처리
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

#2)전처리
#결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

#3)파생변수 만들기-나이
welfare$age <- 2015- welfare$birth +1         # 나이
summarise(welfare$age)
qplot(welfare$age)

class(welfare$age)
#)나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)

#2)그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

################################################################################
# 연령대에 따른 월급 차이
# 어떤 연령대의 월급이 가장 많을까?
# 파생변수 만들기 - 연령대
welfare = welfare %>% 
  mutate(ageg= ifelse(age<30, "young",
                      ifelse(age<=59, "middle","old")))
table(welfare$ageg)
qplot(welfare$ageg)

# 연령에 따른월급 차이 분석하기
 # 연령대별 월급 평균표 만들기
ageg_income = welfare %>% filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income=mean(income))
ageg_income

# 그래프 그리기
ggplot(data= ageg_income, aes(x = ageg, y = mean_income)) + geom_col()+
  scale_x_discrete(limits = c("young","middle","old"))

# 연령대 및 성별 월급 차이
# 성별 월급 차이는 연령대별로 다를까?

sex_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income=mean(income))
sex_income

# 그래프 만들기
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))
# 보기 힘드니 막대 분리  "dodge"
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 나이및 성별 월급 차이 분석하기
# 성별 연령별 월급 평균표 만들기
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

# 그래프 만들기
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + 
  geom_line()

#####################################################################
#6.직업별 월급 차이 - “어떤 직업이 월급을 가장 많이 받을까?”
class(welfare$code_job)
table(welfare$code_job)
library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)

head(list_job)
dim(list_job)

#3)left_join()으로 job 변수를 welfare에 결합합니다.
#welfare와 list_job에 공통으로 들어 있는 code_job 변수를 기준으로 결합하면 됩니다.
#결합이 완료되면 welfare의 code_job, job 변수 일부를 출력해 잘 결합됐는지 확인하겠습니다.


welfare <- left_join(welfare, list_job, id = "code_job")

## Joining, by = "code_job"
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)


#)직업별 월급 평균표 만들기
#직업별 월급 평균을 구하겠습니다. 
#직업이 없거나 월급이 없는 사람은 분석 대상이 아니므로 제외합니다.
job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

# 상위 10개 추출
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

# 그래프 만들기
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()    # 옆으로 그리기



# 하위 10위 추출
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)



# 그래프 만들기
ggplot(data = bottom10, aes(x = reorder(job, -mean_income),
                            y = mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0,850)


# 남성 직업 빈도 상위 10개 추출
job_male <- welfare %>% 
  filter(!is.na(job)&sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male


# 여성 직업 빈도 상위 10개 추출
job_female <- welfare %>% 
  filter(!is.na(job)&sex == "female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female


# 남성 직업 빈도 상위 10개 직업 그래프 만들기
ggplot(data=job_male, aes(x = reorder(job,n), y=n)) +
  geom_col() +
  coord_flip()

# 여성 직업 빈도 상위 10개 직업 그래프 만들기
ggplot(data = job_female, aes(x = reorder(job,n), y = n)) +
  geom_col() +
  coord_flip()

#8.종교 유무에 따른 이혼율 - “종교가 있는 사람들이 이혼을 덜 할까?”
class(welfare$religion)
table(welfare$religion)

# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)

qplot(welfare$religion)

#혼인 상태 변수 검토 및 전처리하기
class(welfare$marriage)
table(welfare$marriage)

#2)파생변수 만들기 - 이혼 여부
# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)

table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

#1)종교 유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

#1)연령대별 이혼율 표 만들기
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_marriage

# count 를 이용해서 만들기
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  count(ageg, group_marriage) %>% 
  group_by(ageg) %>% 
  mutate(pct = round(n/sum(n)*100, 1))

ageg_marriage


# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>% 
  filter(ageg !="young" & group_marriage == "divorce") %>% 
  select(ageg,pct)

ageg_divorce

#그래프 만들기
ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()


# 연령대, 종교 유무, 결혼 상태별 비율표 만들기
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)& ageg != "young") %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_religion_marriage

# count를 이용하여 코딩
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  count(ageg, religion, group_marriage) %>% 
  group_by(ageg, religion) %>% 
  mutate(pct = round(n/sum(n)*100, 1))

ageg_religion_marriage

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)

df_divorce

#)연령대 및 종교 유무에 따른 이혼율 그래프 만들기
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = "dodge")



#지역별 연령대 비율 - “노년층이 많은 지역은 어디일까?”
class(welfare$code_region)
table(welfare$code_region)

# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

list_region

# 지역명 변수 추가
welfare <- left_join(welfare, list_region, id = "code_region")

## Joining, by = "code_region"
welfare %>% 
  select(code_region, region) %>% 
  head

#1)지역별 연령대 비율표 만들기
region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)

#COUNT를 이용하여 MUTATE 사용
region_ageg <- welfare %>% 
  count(region, ageg) %>% 
  group_by(region) %>% 
  mutate(pct = round(n/sum(n)*100, 2))

head(region_ageg)

#그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()

#노년층 비율 높은 순으로 막대 정렬하기
# 노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>% 
  filter(ageg == "old") %>% 
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region

order

#지역명이 노년층 비율 순으로 정렬된 order 변수를 활용해 그래프
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()+
  scale_x_discrete(limits = order)

#연령대 순으로 막대 색깔 
class(region_ageg$ageg)
levels(region_ageg$ageg)

#actor()를 이용해 ageg 변수를 factor 타입으로 변환하고, 
#level 파라미터를 이용해 순서를 지정
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))
class(region_ageg$ageg)

levels(region_ageg$ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()+
  scale_x_discrete(limits = order)












