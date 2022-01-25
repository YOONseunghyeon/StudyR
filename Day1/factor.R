# 스크립트창에서 작성한 코드는 
# 커서를그 줄에두고 ctrl+R , f5


# 파이썬에서는 직업명=[' ' , ' '], 파이썬에서는 초기화 => 직업명=[]
# R에서는 작엽명=c(' ', ' '), R에서는 리스트 초가화는 => 직업명=C()
직업명=c('데이터과학자','엔지니어','엔지니어','세금관라지','분석관리자')
채용수=c(4184,2725,2599,3317,1958)
평균급여=c(110,110,106,110,112)
직업만족도=c(4,4,4,0,4,3,4,0,4,1)
str(직업명)
summary(직업명)
summary(평균급여)
plot(평균급여)
plot(직업만족도)
직업명fa=as.factor (직업명)
직업명fa
summary(직업명fa)
plot(직업명fa)
#pie(직업명fa)
data=data.frame(직업명,채용수,평균급여,직업만족도)
data
str(data)
plot(data)
data$직업명

#strsplit(변수, 글자를 나눌 기준)
a= c('파이선,데이터분석가,인공지능',
     'R,데이터분석가,빅데이터')
tmp= strsplit(a,"/")
tmp
summary(tmp)
tmp1
tmp1= unlist(tmp)
tmp2 = as.factor(tmp1)
summary(tmp2)
plot(tmp2)
strsplit(tmp2, 'ㅡ')   #factor는 strsplit안됨
strsplit(as.character(tmp),'ㅡ')


bt = c('A','B','B','O','AB','A')
bt.new= factor(bt)
bt
bt.new
bt[5]
bt.new[5]
levels(bt.new)
as.integer(bt.new)
bt.new[7]='B'
bt.new[8]='C'
bt.new






?

?



