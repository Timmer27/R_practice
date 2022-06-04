library(dplyr)
df <- data.frame(gender = c(1, 2, 3, NA, 5),
                 score = c(5, 4, NA, 2, 1)
                 )

df
table(is.na(df$gender))
is.na(df)

#filter를 사용하고 !를 사용하여 결측치가 아닌 열만 남기기
df %>% filter(!is.na(score))

#연산자도 사용가능
df %>% filter(!is.na(score) & !is.na(gender))

#만약 결측치 행이 100개가 있다면 너무 불편하므로 na.omit이란 함수를 대신 사용
#이 함수는 각각의 행에 하나라도 결측치가 있다면 그 행을 전부 제외해주고 출력해준다
#단 데이터손실이 많기 때문에 잘 쓰지는 않음
na.omit(df)

#알아서 결측치를 제외하고 연산을 해주는 na.rm
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)


d <- read.csv('csv_exam.csv')
#d 데이터에 maht행 3, 8, 15열에 결측치 추가
d[c(3, 8, 15), 'math'] <- NA

#평균으로 대체하기 위한 평균값
d_mean <- mean(d$math, na.rm = T)
#ifelse를 활용한 결측치를 평균값으로 대체
d$math <- ifelse(is.na(d$math), d_mean, d$math)
d

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212), "hwy"] <- NA
mpg$hwy

table(is.na(mpg$hwy))
table(is.na(mpg$drv))

library(dplyr)
mpg %>%
  filter(!is.na(mpg$hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_drv = mean(hwy))
  
