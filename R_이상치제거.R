library(dplyr)
#데이터프레임 예시
outlier <- data.frame(gender = c(1,2,3,1,2,3),
                      score = c(3,4,5,6,1,2))

#이상치를 제거하기 위한 NA 변환
outlier$gender <-  ifelse(outlier$gender == 3, NA, outlier$gender)

outlier$score <- ifelse(outlier$score>5, NA, outlier$s)

#추가된 결측치를 제외하고 평균값 산출
outlier %>% 
  filter(!is.na(score) & !is.na(gender)) %>% 
  group_by(gender) %>% 
  summarise(mean_scr = mean(score))
  


outlier %>% group_by(gender) %>% 
  summarise(count = n())

#예시 데이터 할당
mpg <- as.data.frame(ggplot2::mpg)

boxplot(mpg$hwy)$stats


mpg$hwy <- ifelse(mpg$hwy > 37 | mpg$hwy < 12, NA, mpg$hwy)
table(is.na(mpg$hwy))

#결측치를 na.rm으로 제거하고 평균 구하기
mpg %>%
  group_by(drv) %>% 
  summarise(hwy_mean = mean(hwy, na.rm = T))


mpg[c(10,14,58,93),"drv"] <- "K"
mpg[c(29,43,129,203), "cty"] <- c(3,4,39,42)

table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% 'K', NA, mpg$drv)
table(is.na(mpg$drv))

boxplot(mpg$cty)$stats

mpg$cty <- ifelse(mpg$cty > 26 | mpg$cty < 9, NA, mpg$cty)

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(cty_mean = mean(cty, na.rm = T))

