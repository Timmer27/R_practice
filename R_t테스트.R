library(dplyr)
library(ggplot2)

r <-read.csv('Data/htest01.csv', header = T)
a <- r %>% filter(group == 'A')
a <- r %>% filter(group == 'B')
#반으로 쪼개기
#1:2의 의미는 1부터 2행까지 추출
a <- r[r$group=='A',1:2]
b <- r[r$group=='B',1:2] 

#평균을 구하는데 [,2]의 의미는 2행의 전체데이터 가져오기
mean(a[,2])
mean(b[,2])

#정규성 검사
shapiro.test(b[,2])
qqnorm(a[,2])
qqline(a[,2])
 

#분산 동질성 검사
var.test(a[,2], b[,2])

#t test 시행
#alternative는 대립가설 기준으로 B그룹보다 A그룹의 평균키가 작다는 뜻 만약 크다면 greater를 입력
#var.equal = 분산이 동일하다는 의미 만약 아니라면 False를 대입
t.test(a[,2], b[,2], alternative = 'less', var.equal = T)

rr <- read.csv('Data/htest02.csv', header = T)

a <- rr[rr$group=='A',1:2]
b <- rr[rr$group=='B',1:2]

mean(a$height)
mean(b[,2])
shapiro.test(a[,2])
qqline(a[,2])
qqnorm(a[,2])

var.test(a[,2], b[,2])
t.test(a[,2], b[,2], alternative = 'less', var.equal = F)


