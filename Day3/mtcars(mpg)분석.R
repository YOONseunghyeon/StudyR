par(mfrow=c(2,1))
boxplot(mtcars$mpg~mtcars$gear)
#기어 4개인게 연비가 가장좋음.
plot(mtcars$mpg~mtcars$am)
plot(mtcars$mpg,mtcars$am)
cor(mtcars$mpg,mtcars$am)

boxplot(mtcars)