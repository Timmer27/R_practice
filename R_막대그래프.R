library(ggplot2)
library(dplyr)

#필요한 데이터를 group by와 summarise를 통해 전처리 한 후
#아래에서 사용
df_mpg <- mpg %>%
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

#산점도와 만드는 개념은 같다. geom을 col로 바꿔서 입력하면 끝
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#x를 내림차순으로 정렬할 때 reorder를 사용하고 기준점에 -를 붙인다.
#오름차순이면 -를 제거한다
ggplot(data = df_mpg, aes(reorder(x = drv, -mean_hwy), y = mean_hwy)) + geom_col()

#막대그래프, 데이터의 빈도수 막대그래프를 만든다
#빈도수 그래프를 그릴때는 geom_bar사용
#y축 지정 불필요
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

m <- mpg %>%
  group_by(manufacturer) %>%
  filter(class == 'suv') %>% 
  summarise(cty_mean = mean(cty)) %>%
  arrange(desc(cty_mean)) %>% 
  head(5)

ggplot(data = m, aes(reorder(x = manufacturer, -cty_mean), y = cty_mean)) + geom_col()


ggplot(data = mpg, aes(x = class)) + geom_bar()
#선그래프, 시계열데이터를 사용해서 그래프를 그린다.
#위의 그래프 그리는 것과 개념은 동일하고 마지막의 그래프 옵션에서 geom_line()으로 변경하여 그린다
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line()


#박스그래프 그리기
#집단 간 분포 차이를 표현할 떄 박스플롯을 사용한다.
#데이터 분포 차이를 확인하고 이상치를 확인할 때 좋음
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


mpg_df <- mpg %>%
  filter(class %in% c('compact', 'subcompact', 'suv')) %>%
  select('class', 'cty')

ggplot(data = mpg_df, aes(x = class, y = cty)) + geom_boxplot()

  
