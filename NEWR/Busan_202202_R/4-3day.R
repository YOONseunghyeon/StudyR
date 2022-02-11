###미국 주별 강력 범죄율 단계 구분도 만들기-----------------------
install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)

head(USArrests)   #지역명이 인덱스로 잡혀있음.

library(tibble)

# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime = rownames_to_column(USArrests, var = "state")

# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state = tolower(crime$state)

# 미국 주 지도 데이터 준비하기
library(ggplot2)
states_map = map_data("state")
str(states_maps)

# 단계 구분도 만들기

ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,    # 지도 데이터
                 interactive = T)

# 대한민국 시도별 인구 단계 구분도 만들기
# 패키지 준비하기
install.packages("stringi")
library(stringi)
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(DT)
library(kormaps2014)
korpop1_temp = korpop1
head(korpop1_temp)

str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1, pop = 총인구_명, name = 행정구역별_읍면동)

str(changeCode(korpop1))


korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")


library(ggplot2)
ggChoropleth(data = korpop1,      # 지도에 표현할 데이터
             aes(fill = ,      # 색깔로 표현할 변수
                 map_id = code,   # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1,       # 지도 데이터
             interactive = T)     # 인터랙티브
str(changeCode(tbc))

tbc$name <- iconv(tbc$name, "UTF-8", "CP949")

ggChoropleth(data = tbc,          # 지도에 표현할 데이터
             aes(fill = NewPts,   # 색깔로 표현할 변수
                 map_id = code,   # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1,       # 지도 데이터
             interactive = T)     # 인터랙티브

str(korpop1)

korpop1$비주거비율 = (korpop1$비거주용_건물내_주택_호 / korpop1$주택_계_호)*100

korpop1$주택_계_호 = 

str(tbc$year)
str(changeCode(tbc))
tbc$year
tbc$NewPts
tbc$NewPts=is.na(tbc$NewPts)
tbc$NewPts=as.numeric(tbc$NewPts)

