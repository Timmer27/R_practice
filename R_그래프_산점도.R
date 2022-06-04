library(ggplot2)
library(dplyr)
#aes로 일단 축을 먼저 설정
#이 코드를 실행하면 배경이 먼저 만들어진다
ggplot(data = mpg, aes(x = displ, y = hwy))

# geom_point를 붙여서 점을 찍는다
# + 기호를 사용해서 옵션을 추가할 수 있다
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

#xlim = x축의 범위를 설정, 즉 범위를 제한한다.
#3부터 6까지 제한
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point()

ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)
