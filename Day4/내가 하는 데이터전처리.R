df=read.csv("C:/Users/admin/Desktop/부성순강사님자료/data_r/cust_order_data.csv",sep='\t',encoding='ANSI'
,stringsAsFactors = TRUE)
df
#rm(list = ls())
str(df)
 head(df,3)
#CUST_SERIAL_NO = 고객번호 ,  SEX: 고객성별 ,REG_DATE= 상품등록날짜
#ORDER_DATE = 상품 주문날짜 , $ORDER_HOUR = 주로 주문하는 시 , ORDER_WEEKDAY = 주문하는 요일
#IS_WEEKEND = 주말T,평일F ,GOODS_CODE = 상품 번호,  LGROUP= , MGROUP =, SGROUP=,  
#DGROUP =, GOODS_NAME = 상품이름,  PRICE= 상품가격, QTY= ,  
# 
table(df$MGROUP)
str(df$LGROUP)
table(is.*(df$SEX))

table(df$SEX)
tmp=data.frame(table(df[,1]))
summary(tmp$Freq)
boxplot(tmp$Freq)
table(df$ORDER_DATE)   #2011-07-14    2012-08-08
boxplot(df[,16])

tmp[tmp=='#NAME?']=NA
tmp=tmp[complete.cases(tmp)]
str(tmp)

subset(tmp,tmp=='#NAME?')

tmp1 = as.factor(as.character(tmp))
str(tmp1)
tmp1
