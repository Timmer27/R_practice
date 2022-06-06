raw_data <- read.csv('Data/Wholesale customers data.csv')
data <- raw_data

data$Channel <- as.factor(data$Channel)
data$Region <- as.factor(data$Region)

#신선식품 구매 리스트 데이터
str(data)

#결측치 확인
colSums(is.na(data))
#기본 통계 확인
summary(data)

#통계자료 시각화
#전체 열의 개수 가져옴 - ncol, 즉 3:8
#option으로 아라비아 숫자로 변경
options(scipen = 100)
boxplot(data[,3:ncol(data)])

library(dplyr)

#오름차순으로 정렬, decreasing T.
#가장 큰 값 5개 추출하여 tmp변수에 저장한 후 출력
tmp <- NULL
for (i in 3:ncol(data)){
  tmp <- rbind(tmp, data[order(data[,i], decreasing = T),] %>%
                 slice(1:5))
}

#중복제거
tmp <- distinct(tmp)
#추출된 중복 제거된 데이터를 원본에서 제외하고 다른 이름에 객체화
data_rm_outlier <- anti_join(data, tmp)

#par을 사용하여 현재 보여줄 시각화 데이터를 2개를 한화면에 보여줌
par(mfrow = c(1,2))
boxplot(data[,3:ncol(data)])
boxplot(data_rm_outlier[,3:ncol(data)])


#K means 군집 개수 설정 (Elbow method)

#3개의 방식을 기준
#사전지식
#elbow
#실루엣

#elbow 사용 시작
install.packages('factoextra')
library(factoextra)

#데이터 추출 난수 고정
set.seed(1234)
#k.max = 최대 15개까지 군집을 생성
fviz_nbclust(data_rm_outlier[,3:ncol(data)], kmeans, method = "wss", k.max = 15) +
  #차트의 배경 테마 설정 및 타이틀 설정
  theme_minimal() +
  ggtitle("Elbow Method")

#결과물 해석
#그래프가 눕게되늦 지점에서 군집개수 설정
#즉 그래프를 보게 된 결과 5개로 판명

#실루엣 방식 사용
#위의 설정과 동일하고 방식만 silhouette으로 변경

#데이터 추출 난수 고정
set.seed(1234)
#k.max = 최대 15개까지 군집을 생성
fviz_nbclust(data_rm_outlier[,3:ncol(data)], kmeans, method = "silhouette", k.max = 15) +
  #차트의 배경 테마 설정 및 타이틀 설정
  theme_minimal() +
  ggtitle("Silhouette Method")

#실루엣의 결과로는 k가 3개로 판명
#위의 결과물이 5와 3이 다른데 이럴 때는 주관적인 방법이 필요함
#데이터가 구매고객 데이터이므로 3개보단 5개가 고객을 세밀하게 분석할 수 있으므로 5개로 설정


#개수도 구했으니 이제 kmeans 모델 생성
data_kmeans <- kmeans(data_rm_outlier[,3:ncol(data)], centers = 5, iter.max = 1000)
#ceter에 구한 군집개수 넣고
#iter.max는 재군집화의 반복 개수
data_kmeans

#만들어진 결과값 시각화
dev.off() #설정했던 par 초기화
barplot(t(data_kmeans$centers), beside = T, col = 1:6)
#colnames = 범례 항목 지정
#fill 색깔을 6개로
#cex 범례의 크기 지정
legend("topleft", colnames(data[,3:8]), fill = 1:6, cex = 0.8)

#위의 시각화를 통해 그룹의 군집화로 어떤 고객들이 어떤 분야의 음식을 사는지 확인할 수 있음
#군집화를 통해 비슷한 그룹끼리 뭉쳐있으므로 그 그룹이 어떤 분야의 음식을 자주 구매하는 지 알 수 있고, 이러한 데이터를 통해 음악추천이나 같이구마하면 좋은 음식을 추천해줄 수 있는 비지도러닝

#나온 클러스터를 이상치가 제거된 데이터에 결합시켜 재사용
data_rm_outlier$cluster <- data_kmeans$cluster
head(data_rm_outlier)

#여기서 나온 클러스터의 개수는 군집화의 개수이고 이 개수가 많은 4번의 경우 많은 사람들이 식료품과 우유를 같이 사는 것을 볼 수가 있다.






























































