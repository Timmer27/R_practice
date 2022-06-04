install.packages("dplyr")
install.packages("ggplot2")

#패키지 로드
library(dplyr)
library(ggplot2)

#데이터의 head를 추출
#즉, 데이터를 콘솔에 띄운다.
head(mpg)

#데이터행의 속성 설명.
#chr, num, int
str(mpg)

#데이터의 행열 표시
dim(mpg)

#모든 데이터의 요약 통계량을 구한다. 
#pandas DataFrame의 .describe와 같은 개념
summary(mpg)

#콘솔말고 화면에 DataFrame, 엑셀식으로 직접 볼 수 있음
View(mpg)

#회사별 연비 높은순 정렬
mpg %>%
  #group_by로 제조사별 그룹화 시킨 후
  group_by(manufacturer) %>%
  #연비의 평균값을 정리해서
  summarise(mean.hwy=mean(hwy)) %>%
  #desc, 즉 내림차 순으로 hwy, 연비를 정렬하여 출력
  arrange(desc(mean.hwy))


mpg %>%
  #필터를 ford라는 회사로만 지정
  filter(manufacturer=="ford") %>%
  #model을 그룹으로 묶어서 모델명 연비 조회
  group_by(model) %>%
  #모델명 연비 내림차순 출력
  arrange(desc(hwy))
  

#회귀분석, 배기량이 연비에 미치는 영향 회귀분석
#l은 소문자 엘
lm.mpg <- lm(data=mpg, hwy ~ displ)
summary(lm.mpg)

# 산점도 찍기
qplot(data = mpg, x=displ, y=hwy)

head(mpg)

#평균
mean(mpg$hwy)
#최대값
max(mpg$hwy)
#최소값
min(mpg$hwy)
#히스토그램 만들기
hist(mpg$hwy)

#변수 배정
a<-3
b<-2
c<-1.4

#연속형 변수 배정
aa <- c(1,2,3,4,5)
bb <- c(1:5)
cc <- seq(1, 5)
#2씩 증가하는 연속형 변수 배정
dd <- seq(1,15, by=2)

#지정된 연속형 변수에 연산 가능
aa+2
# 4 6 8 10 12
dd*3
# 3 9 15 21 27

#연속형 변수지만 length, 길이가 다르면 연산 불가
cc+dd
#길이가 같으므로 변수끼리 연산 가능
bb*cc

#변수에 글자 배정 가능
s <- 'a'
s2 <- 'text'
s3 <- 'hello world'

#문자열은 연산 불가
s+s2

#지정된 iterable변수의 평균 값 구하기
mean(aa)
#최대값
max(aa)
#최소값
min(aa)
#동일하게 c를 써주면 연속형 변수 생성 가능
ss <- c('a', 'a', 'c', 'c', 'd','d','d')
qplot(ss)

#연속 문자열 배정
ch <- c('Hello', 'world')
#paste를 활용하고 collapse, " " 공백을 줌으로써 문장 공백 추가하여 연결
paste(ch, collapse = " ")

#paste로 변경된 문자열을 다른 변수에 저장 
paste_ch <- paste(ch, collapse = " ")
paste_ch

#geom = 데이터를 표시하는 기준점, point를 사용했으니 .으로 표시
qplot(data = mpg, x = cty, y = hwy, geom = 'point')

#boxplot으로 표시, color로 색칠하기
qplot(data = mpg, x = drv, y = hwy, geom = 'boxplot', color=drv)

#함수사용법을 모를 때 가이드라인 확인하는법
?qplot











