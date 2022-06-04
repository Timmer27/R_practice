install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)

raw_welfare <- read.spss("data_spss_Koweps2014.sav", to.data.frame = T)

#데이티 카피 
welfare <- raw_welfare
head(welfare, 1)

#데이터 정보 확인
dim(welfare)
str(welfare)
table(welfare)
summary(welfare)
View(welfare)

#데이터 행 이름 바꾸기
welfare <- rename(welfare,
                  gender = h0901_4,
                  birth = h0901_5,
                  income = h09_din)

boxplot(welfare$income)$stats
summary(welfare$income)

#데이터 타입 확인
class(welfare$gender)
summary(welfare$gender)
table(welfare$gender)

welfare$gender <- ifelse(welfare$gender == 1, "남", "여")

qplot(welfare$gender)
qplot(welfare$income) + xlim(0, 10000)

#성별 소득 평균표 생성
gender_income <- welfare %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income))

ggplot(data = gender_income, aes(x = gender, y = mean_income)) + geom_col()


#나이와 소득의 관계
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

welfare$age <- 2022 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

#나이별 소득 평균
mean_income <- welfare %>% 
  group_by(age) %>% 
  summarise(income_mean = mean(income))

welfare$income_mean
welfare
mean_income
welfare$age

ggplot(data = mean_income, aes(x = age, y = income_mean)) + geom_point()

welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "초년", ifelse(
    age <= 59, "중년", "노년"
  )))
table(welfare$ageg)

qplot(welfare$ageg)

#초년은 빈도가 작으므로 제외 
mean_income <-welfare %>% 
  filter(ageg != '초년') %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ggplot(data = mean_income, aes(x = ageg, y = mean_income)) + geom_col()


gender_income <- welfare %>% 
  filter(ageg != '초년') %>% 
  group_by(ageg, gender) %>% 
  summarise(mean_income = mean(income))
gender_income

ggplot(data = gender_income, aes(x = ageg, y = mean_income, fill = gender)) + geom_col(position = "dodge")
