library(KoNLP)
library(dplyr)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)

setwd("C:/Busan-202202_R2")
#대통령 연설문
Data1 = readLines("Data_1.txt", encoding = "UTF-8")
Data2 = readLines("Data_2.txt", encoding = "UTF-8")
Data3 = readLines("Data_3.txt", encoding = "UTF-8")
Data4 = readLines("Data_4.txt", encoding = "UTF-8")
dir()
Data2

tot=c(Data1,Data2,Data3,Data4)

#특수문자 제거
tot = str_replace_all(tot, "\\W", " ")
tot

#명사 추출
nouns = extractNoun(tot)
nouns

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount = table(unlist(nouns))
wordcount

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 변수명 수정
df_word = rename(df_word,
                 word = Var1,
                 freq = Freq)
df_word

# 두 글자 이상 단어 추출
df_word = filter(df_word, nchar(word) >= 2)
df_word

top_20 = df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top_20

###워드 클라우드---------------------------------------------------

# Dark2 색상 목록에서 8개 색상 추출
pal <- brewer.pal(8,"Dark2")  

set.seed(1234)                   # 난수 고정
wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록
pal
