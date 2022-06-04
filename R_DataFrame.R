a <- c(90, 80, 60, 70)
b <- c(50, 60, 100, 20)
c <- c(1, 1, 2, 2)
#데이터프레임 만들기
df <- data.frame(a, b, c)

#각각의 행에 접근하기 $를 사용
df$a
df$b
df$c

#행의 평균 구하기
mean(df$a)

#엑셀파일 불러오기
install.packages('readxl')
library(readxl)

#sheet = 1 첫번째 시트 가져오고
#col_names = T의 의미는 Columns이름까지 가져올 것을 결정
#T = True, F = False
df_finalexam <- read_excel('finalexam.xlsx', sheet = 1, col_names = T)
df_finalexam

#점수들의 평균
mean(df_finalexam$math)
mean(df_finalexam$history)
mean(df_finalexam$english)

#read.csv 는 내장함수. 설치 불필요
#col_names대신 header를 사용
exam <- read.csv('csv_exam.csv', header = T)

#변수로 할당했던 파일 csv파일로 저장
write.csv(df_csvexam, file = 'output_test.csv')

head(exam)
#앞 부분에서 6까지 출력
head(exam, 6)

#뒤부터 6까지 출력
tail(exam)
#뒤부터 지정행까지 출력
tail(exam, 10)
str(exam)
summary(exam)

#::의 의미는 특정 패키지 안의 특정 데이터를 지칭
#즉 ggplot2의안의 mpg데이터를
#as.data.frame, as가 붙으면 특정 지칭 데이터(mpg)를 특정 포맷으로 변경해달라는 의미
#즉, mpg데이터를 data.frame형태로 변환시켜달라는 의미
mpg <- as.data.frame(ggplot2::mpg)
summary(mpg)
str(mpg)
head(mpg)

library(dplyr)

#데이터프레임 변수명을 data.frame자체 내에 선언하여 최적화
df <- data.frame(var1 = seq(1,3), var2=seq(1,3))
#백업파일
df_new <- df
#rename 사용
#여기서 트릭은 v2 즉 새이름을 먼저 쓰고 그 뒤에 옛날 이름을 씀
df_new <- rename(df_new, v2=var1)
df_new

df_raw <- as.data.frame(ggplot2::mpg)
df_new <- df_raw
str(df_new)
df_new <- rename(df_new, city=cty)
df_new <- rename(df_new, highway=hwy)
head(df_new,3)


library(ggplot2)
df2 <- read.csv('output_test.csv', header = T)
qplot(data = df2, x=df2$test)
?ggplot

df <- data.frame(v1 = c(1:5),
           v2 = c(1:5))

df$sum <-  (df$v1+df$v2)/2
df
d <- read.csv('output_test.csv')
d <- data.frame(d$test)
d$
hist(d$test)

mpg$total <- (mpg$cty + mpg$hwy)/2
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg$test)
head(mpg, 10)

table(mpg$test)
qplot(mpg$test)

mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))
mpg$grade

table(mpg$grade)
qplot(mpg$grade)

library(dplyr)

df <- data.frame(midwest)
dff <- rename(df, total = poptotal, asian=popasian)

dff$percent <- dff$asian / dff$total
dff$percent

library(ggplot2)

hist(dff$percent)

mean_asian = mean(dff$percent)
dff$size <- ifelse(dff$percent > mean_asian, "large", "small")

qplot(dff$size)
