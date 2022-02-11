install.packages("RJDBC")
library(RJDBC)


# 오라클 드라이버 연결 경로 설정
driver= JDBC("oracle.jdbc.OracleDriver",
             classPath = "C:/Users/admin/Desktop/ojdbc8.jar")
driver
# 오라클 접속하기
conn = dbConnect(driver,
                 "jdbc:oracle:thin:@//localhost:1521/orcl",
                 "busan","dbdb")

conn

sql_in = paste(" Insert into test",
              " (AA, BB ,CC) ",
              " values('a1','b1','c1')")
sql_in

in_stat = dbSendQuery(conn, sql_in)
in_stat

dbClearResult(in_stat)

######### 데이터 조건 [조회]하기
sql_sel = "Select*From test where AA = 'a1' "
sql_sel

getData = dbGetQuery(conn, sql_sel)
getData

getData$AA
str(getData)
# 접속해제제
dbDisconnect(conn)
