str (mtcars)
head (mtcars,3)
summary(mtcars)
plot(mtcars$mpg)
mtcars
names(summary(factor(mtcars$cyl)) )    #######factor , as.factor 같은거 끼리 묶기 
summary(factor(mtcars$cyl))            ######names 는 변수명 확인
levels (factor (mtcars$cyl))           #######  levels는 factor 일때만 가능 
unique(mtcars$cyl)                     #######   unique 는 변수가 제일위에있는거 부터 차례대로
tmp=summary(factor(mtcars$cyl))
tmp
names(tmp)=c('cyl:4','cyl:6','cyl:8')   ######names 4의 실제데이터는 11
str(tmp)
tmp[1]

###split(자료,기준) 작업하면 리스트화됨
split(mtcars,mtcars$cyl)
str(tmp)
split(tmp[[1]],tmp[[1]][9])
