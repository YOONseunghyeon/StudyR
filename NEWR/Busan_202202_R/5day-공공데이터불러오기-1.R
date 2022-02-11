install.packages('XML')
library(XML)

#rm(list=ls()) 

# 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/1160100/service/GetStocDiviInfoService/getDiviInfo"

# 승인 받은 KEY 등록
service_Key <- "tqaHOjolEWMqqx6nqNdF5a80L2eJX7Zk4HlasaV6BVxTO6nVLhe7q77Frs09Rtftgv7vn1J%2FV9RXX5Dei6iCbg%3D%3D"	

# 요청변수 등록
numOfRows = "30"
stckIssuCmpyNm = "동남합성"

stckIssuCmpyNm = URLencode(iconv(stckIssuCmpyNm, to = "UTF-8"))
stckIssuCmpyNm

searchCondition = "DAILY"

# 오픈 API URL
# paste 와 paste() 의 차이
paste("a","b","c")
#paste("a","b","c", sep =" ")
#paste("a","b","c", sep = "/")
paste0("a","b","c")

# URL 주소를 공백없이 모두 묶기
open_api_url = paste0(api_url,"?serviceKey=",service_Key,
                      "&numOfRows=",numOfRows,
                      "&stckIssuCmpyNm=",stckIssuCmpyNm,
                      "&searchCondition=",searchCondition)

open_api_url

# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data = xmlTreeParse(open_api_url,
                        useInternalNodes = TRUE,
                        encoding = "utf-8")

raw.data

# XML 형식의 자료를 데이터 프레임으로 변경하기
# </item> 태그 별로 데이터 구분하기
stock = xmlToDataFrame(getNodeSet(raw.data,"//item"))

stock

View(stock)

# subset() : 데이터프레임 내에세 검색 조건 (select)에 맞는  
#             항목 (컬럼)들만 가지고 오기..

stock= subset(stock,
                       select = c (basDt,
                                   cashDvdnPayDt,
                                   isinCdNm,
                                   scrsItmsKcdNm,
                                   stckDvdnRcdNm,
                                   trsnmDptyDcdNm))
                                  

View(stock)


# 오픈 API 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(stock, "stock_new.csv")
