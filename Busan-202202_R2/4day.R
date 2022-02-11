getwd()

install.packages("usethis")
usethis::edit_r_environ()
#PATH = "${RTOOLS40_HOME}\usr\bin;${PATH}"
Sys.which("make")

install.packages("rJava")

install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)

text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다."
extractNoun(text)


# 패키지 로드
library(KoNLP)
library(dplyr)



useNIADic()


txt <- readLines("./Data/hiphop.txt", encoding="UTF-8")
txt

install.packages("stringr")
library(stringr)

# 특수문자 제거
txt <- str_replace_all(txt, "[\\W]", " ")
txt

## -------------------------------------------------------------------- ##
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
# 가사에서 명사추출
nouns <- extractNoun(txt)
nouns

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
wordcount

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)
df_word

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20


## -------------------------------------------------------------------- ##
# 패키지 설치
install.packages("wordcloud")

# 패키지 로드
library(wordcloud)
library(RColorBrewer)

pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8개 색상 추출
pal

set.seed(1234)

wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,            # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(4, 0.3),       # 단어 크기 범위
          colors = pal)            # 색상 목록


#### 10-2 ####

## -------------------------------------------------------------------- ##
# 데이터 로드

twitter <- read.csv("./Data/twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

head(twitter)

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용,)
head(twitter)
twitter$tw

# 특수문자 제거 --> 한글깨짐 오류 미확인..
#twitter$tw <- str_replace_all(twitter$tw, '\\W', " ")


library(KoNLP)

# 트윗에서 명사추출 : 오류가 나더라도, 그대로 진행
# 오류가 있는 부분을 제외하고 추출합니다.
# csv 데이터가 깨끗한 편이 아님..
nouns <- extractNoun(twitter$tw)
nouns

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
wordcount

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word

# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)
df_word

library(dplyr)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20

library(ggplot2)

order <- arrange(top20, freq)$word               # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +  
  ylim(0, 2500) +
  geom_col() + 
  coord_flip() +
  scale_x_discrete(limit = order) +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시

pal <- brewer.pal(8,"Dark2")       # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록


