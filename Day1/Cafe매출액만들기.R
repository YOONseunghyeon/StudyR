cafe=list(espresso=c(4,5,3,6,5,4,7),
americano=c(63,68,64,68,72,89,94),
latte=c(61,70,59,71,71,92,88),
price=c(2.0,2.5,3.0),
menu=c('espresso','americano','latte'))

cafe
cafe[[5]]
str(cafe)
summary(cafe)

cafe$menu=factor(cafe$menu)
names(cafe$price)=cafe$menu
cafe$menu   # levels = 범주형 변수에서 나올수있고,수준으로 구성된 백터
str(cafe)

cafe$menu=names(cafe$price)
names(cafe$price)
str(cafe)
cafe$price[2]
cafe$price[3]

sale.espresso = cafe$price['espresso']*cafe$espresso
sale.americano = cafe$price['americano']*cafe$americano
sale.latte = cafe$price['latte']*cafe$latte
