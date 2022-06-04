#대응표본 t 검정이란 특정한 사람이 두 그룹에 모두 속하는 경우
#예시로 중간고사와 기말고사의 시험 결과를 본 학생이 있을 수 있다.
#두 결과가 모두 같은 사람에게서 나왔기 때문
#before, after 개념

#t검정과의 차이는 대응표본 t검정같은 경우 before, after의 차이를 계산한다

r <- read.csv('Data/htest02d.csv', header = T)
r
a <-r[,1] 
b <- r[,2]

mean(a)
mean(b)

#두개의 차이를 구한다
d = a - b

shapiro.test(d)
qqnorm(d)
qqline(d)

shapiro.test(b)
qqnorm(b)
qqline(b)

#대응표본 t 검정이므로 paired를 사용
t.test(a, b, alternative = 'less', paired = T)



