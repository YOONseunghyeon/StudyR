#   csv파일 불러오기  , 데이터 수집단계 (1단계)
library(dplyr)
library(readxl)
data= read.csv("./전라남도_목포시_장애인_복지시설_20210802.csv", header = T,
               fileEncoding="EUC-KR")
str(data)
##############################################################################
#  데이터 전처리 단계
# 웹 스크레핑 (크롤링)
install.packages("rvest")         # 웹 스크래핑 패키지
install.packages("stringr")       # 문자열 처리 패키지\
library(rvest)
library(stringr)
# 웹 스크레핑 순서
#1. 웹 스크래핑 대상 URL 할당
#2. 웹 문서 가져오기
#3. 특정 태그의 데이터 추출
#4. 데이터 정제
#5. 데이터 프레임 만들기

#1. 웹 스크래핑 대상 URL 할당
url1= "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"
url1

#2. 웹 문서 가져오기
usedCar = read_html(url1)
usedCar

#3. 특정 태그의 데이터 추출
# 가져온 usedCar에서 css가 ".product-item"인 것을찾음.
carInfos = html_nodes(usedCar, css=".product-item")
head(carInfos)



# 차량 명칭 추출

title_tmp = html_nodes(carInfos, css=".tit.ellipsis")
title_tmp

title = html_text(title_tmp)
title

title = str_trim(title)  #공백제거
title
#title = str_replace(title, '\r', '') #문자열 변경 (\n을 스페이스로 변경)

#차량 연식 추출
year_tmp = html_node(carInfos, css=".mode-cell.year")
year_tmp

year = html_text(year_tmp)
year

year = str_trim(year)  #공백제거
year

#연료 구분
fuel_tmp = html_node(carInfos, css=".mode-cell.fuel")
fuel_tmp

fuel = html_text(fuel_tmp)
fuel

fuel = str_trim(fuel)  #공백제거
fuel

#주행거리 추출
km_tmp = html_node(carInfos, css=".mode-cell.km")
km_tmp

km = html_text(km_tmp)
km

km = str_trim(km)  #공백제거
km

#판매가격 추출
price_tmp = html_node(carInfos, css=".mode-cell.price")
price_tmp

price = html_text(price_tmp)
price

price = str_trim(price)  #공백제거
price

price = str_replace(price, '\n', '') #문자열 변경 (\n을 스페이스로 변경)
price

maker = c()
maker
title

for(i in 1 : length(title)){
  maker = c(maker, unlist(str_split(title[i],' '))[1])
}
maker

#. 데이터 프레임 만들기
usedcars= data.frame(title,year, fuel, km,price,maker)
View(usedcars)

#############################################################################
# 데이터 정제
# km 자료 숫자로 변경
usedcars$km = gsub("만km","0000",usedcars$km) # 문자열 변환 ("만km" -> "0000")
usedcars$km = gsub("천km","000",usedcars$km)
usedcars$km = gsub("km","",usedcars$km)
usedcars$km = gsub("미등록","",usedcars$km)
usedcars$km = as.numeric(usedcars$km) # 숫자형으로 변경

usedcars$km

# price 자료 숫자로 변경
usedcars$price

usedcars$price = gsub("만원","", usedcars$price)
usedcars$price = gsub("계약","", usedcars$price)
usedcars$price = gsub("팔림","", usedcars$price)
usedcars$price = gsub("금융리스","", usedcars$price)
usedcars$price = gsub(",","", usedcars$price)
usedcars$price = as.numeric(usedcars$price)

usedcars$price

#지금까지한거 파일로 저장
write.csv(usedcars, "usedcars_new.csv")

##########################################################################
#URL 데이터 불러오기
install.packages('XML')
library(XML)



# 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"

# 승인 받은 KEY 등록
service_Key <- "U1PvCspLab%2BwSUDRHuNwq6wxQnNngRv27tCUcvoEniqqlCOKsAPKkwrozQwI7amVp8AwWlQeLtVJvI6rgQCneA%3D%3D"	

# 요청변수 등록
numOfRows = "30"
sidoName = "경기"

sidoName = URLencode(iconv(sidoName, to = "UTF-8"))
sidoName

searchCondition = "DAILY"

# 오픈 API URL
# paste 와 paste() 의 차이
paste("a","b","c")
#paste("a","b","c", sep =" ")
#paste("a","b","c", sep = "/")
paste0("a","b","c")

# URL 주소를 공백없이 모두 묶기
open_api_url = paste0(api_url,"?serviceKey=",service_key,
                      "&numOfRows=",numOfRows,
                      "&sidoName=",sidoName,
                      "&searchCondition=",searchCondition)

open_api_url

# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data = xmlTreeParse(open_api_url,
                        useInternalNodes = TRUE,
                        encoding = "utf-8")

raw.data

# XML 형식의 자료를 데이터 프레임으로 변경하기
# </item> 태그 별로 데이터 구분하기
air_pollution = xmlToDataFrame(getNodeSet(raw.data,"//item"))

air_pollution

View(air_pollution)

# sunset() : 데이터프레임 내에세 검색 조건 (select)에 맞는  
#             항목 (컬럼)들만 가지고 오기..

air_pollution = subset(air_pollution,
                       select = c (dataTime,
                                   stationName,
                                   so2Value,
                                   coValue,
                                   o3Value,
                                   no2Value,
                                   pm10Value))

View(air_pollution)


# 오픈 API 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(air_pollution, "air_pollution_new.csv")






