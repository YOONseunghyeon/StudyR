#산점도 만들기
library(ggplot2)

#배경설정하기 (x축 displ, y축 hwy로 지정해 배경생성)
ggplot(data=mpg, aes(x = displ, y= hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# x 축 범위 3~6 으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

# x 축 범위 3~6, y 축 범위 10~30 으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#ggplot() vs qplot()
#• qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
#• ggplot() : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능

#1번
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()


#2번
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)


##################################################
# 집단별 평균표 만들기
library(dplyr)
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
df_mpg
#rm(list=ls())

#2. 그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#3. 크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

#막대 그래프 2 - 빈도 막대 그래프
#• 값의 개수(빈도)로 막대의 길이를 표현한 그래프
# x 축 범주 변수, y 축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()


#1번
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
df
ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                      y = mean_cty)) + geom_col()
#2번
ggplot(data = mpg, aes(x = class)) + geom_bar()















