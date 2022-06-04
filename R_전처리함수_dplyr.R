library(dplyr)
library(readxl)

filter() #행 추출
select() #열(변수) 추출
arrange() #정렬 - sort
mutate() #변수 추가
summarise() #통계치 산출
group_by() #집단별로 나누기
left_join() #데이터 합치기 - left니까 열
bind_rows() #데이터 합치기 - 행

d <- read.csv('csv_exam.csv')
d

d %>% filter(class == 1)
d %>% filter(class ==2)
d %>% filter(class != 1)
d %>% filter(math > 100 | english > 60)
d %>% filter(math > 60 & english > 60)
d %>% filter(class %in% c(1,2,3))

mpg_dis1 <- mpg %>% filter(displ <= 4)
mpg_dis2 <- mpg %>% filter(displ >= 5)
mean(mpg_dis1$hwy)
mean(mpg_dis2$hwy)

mean((mpg %>% filter(manufacturer == 'audi'))$cty)
mean((mpg %>% filter(manufacturer == 'toyota'))$cty)

d <- mpg %>% filter(manufacturer %in% c('chevrolet', 'ford', 'honda'))
mean(d$displ)


#math라는 열 전체 출력
d %>% select(math)
#다중 출력도 가능
d %>% select('math', 'english')
#특정 열 제외하고 출력
d %>% select(-'math')
#특정 열 다중 제외 가능
d %>% select(-'math', -'english')

#위에서 배운 filter와 select 혼용 사용 가능
d %>% filter(class == 1) %>% select('english')

#가독성 있게 위의 코드 변경
d %>%
  filter(class == 1) %>%
  select('english')

d %>% 
  select('english', 'math') %>% 
  head(10)


mpg_new <- mpg %>% select('class', 'cty')

mpg_car <- mpg %>%
  select('class', 'cty') %>% 
  filter(class == 'compact' | class == 'suv')
mpg_car1 <- mpg_car %>% filter(class == 'compact')
mpg_car2 <- mpg_car %>% filter(class == 'suv')
mean(mpg_car1$cty)  
mean(mpg_car2$cty)  

#오름차순 정렬
#class와 math의 오름차순 정렬
d %>% arrange(class, math)
#내림차순 정렬
d %>% arrange(desc(class), desc(math))

mpg %>%
  filter(manufacturer=='audi') %>% 
  select('hwy') %>%
  arrange(desc(hwy)) %>%
  head(5)

 

d %>% mutate(total=math+english+science,
             mean=(math+english+science)/3,
             result=ifelse(math>60, "pass", "fail")
             ) %>% 
  #따로 할당을 안해도 바로 뒤에서 받아다가 재사용이 가능한 장점
  arrange(desc(total)) %>% 
  head(10)


mpg_dp = mpg
mpg_dp %>% mutate(sum = cty + hwy,
                  mean = sum/2
                  ) %>% 
  arrange(desc(mean)) %>% 
  head(3)


#전체 수학점수 평균 summarise
d %>%  summarise(mean_math = mean(math))

#클래스 별로 그룹화시킨 후 각각의 수학 평균값 구하기
d %>% group_by(class) %>% 
  summarise(mean_math = mean(math),
            max_math = max(math),
            #median = 중앙값
            median_math = median(math),
            #빈도 수 = n, 각각의 행의 개수
            #이 케이스는 총 학생의 수를 셌다고 보면 됨
            n = n())
#여러 객체별로 쪼갤때는 arrange와 같이 순서대로 나열된 대로 쪼개진다.
mpg %>% group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

#주로 사용되는 요약통계량 함수
mean() #평균
sd() #표준편차
sum() #합계
median() #중앙값
min() #최소값
max() #최대값
n() #빈도


mpg %>% group_by(class) %>% 
  summarize(mean_cty = mean(cty))

mpg %>% group_by(class) %>% 
  summarise(hwy_m = mean(hwy)) %>% 
  arrange(desc(hwy_m))

mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% group_by(manufacturer) %>% 
  filter(class == 'compact') %>% 
  summarise(count = n()) %>%
  arrange(desc(count)) %>% 
  head(3)



#데이터 합치기
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

#id 기준으로, 즉 열인 좌우로 붙이기
total <- left_join(test1, test2, by='id')
total

name <- data.frame(class=c(1,2,3,4,5),
                    final = c('kim','lee','park','choi','jung'))

left_join(total, name, by = 'class')

#행으로 합쳐버리기
bind_rows(test1, test2)


fuel <- data.frame(fl = c("c","d","e","p","r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F
                   )
fuel

mpg_fuel <- left_join(mpg, fuel, by = 'fl')
mpg_fuel$price_fl

mpg_fuel %>%
  select('model', 'fl', 'price_fl') %>% 
  head(5)


library(ggplot2)
midwest

mutate(adults_per = (popadults/poptotal) / poptotal)

mid <- midwest %>% mutate(per = (((poptotal-popadults)/poptotal)))

mid %>% arrange(desc(per)) %>% 
  head(5)

mid <- mid %>%
  mutate(grade = ifelse(per >= 0.4, "large",
                 ifelse(per >=0.3, "middle", "small"))) 

mid %>% group_by(grade) %>% 
  summarise(count_n = n())
table(mid$grade)

mid %>% mutate(asian_per = ((popasian)/poptotal)*100) %>%
  select('state', 'county', 'asian_per') %>% 
  tail(10)

mid$popasian



