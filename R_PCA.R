head(iris)

colSums(is.na(iris))

summary(iris)

boxplot(iris[,1:4])

#pca 함수 실행 - prcomp
#center와 scale을 T로 해줌으로써 데이터를 표준화 해주는 것
iris_pca <- prcomp(iris[1:4], center = T, scale. = T)
summary(iris_pca)


#각 주성분들의 표준편차 stdev 출력
#분산 비율, 
#누적 분산
iris_pca

#시각화
#main은 타이틀 이름 지정 파라미터
#영문자 l을 넣어서 screeplot의 차트를 선으로 변경
plot(iris_pca, type = 'l', main = 'Scree Plot ')

library(ggfortify)
install.packages('ggfortify')
autoplot(iris_pca, data = iris, colour='Species')

#차원축소 위한 사진 데이터 불러오기
install.packages('jpeg')
library(jpeg)
dog <- readJPEG('Data/dog.jpg')
#class 확인 - array
class(dog)

dim(dog)

#3차원 데이터 나누기
r <- dog[,,1]
g <- dog[,,2]
b <- dog[,,3]

#사진 축소를 하고 나서 데이터를 다시 만들어줘야되기 때문에 표준화를 생략한다
dog_Rpca <- prcomp(r, center = F)
dog_Gpca <- prcomp(g, center = F)
dog_Bpca <- prcomp(b, center = F)

#분석 결과를 rgb로 재 합침
rgb_pcd <- list(dog_Rpca, dog_Gpca, dog_Bpca)

#차원 축소하여 jpg로 재 저장
#축소할 차원 수를 연속 배열로 지정
pc = c(2,10,50,100,300)

#차원을 축소하여 이미지 축소차원별 저장
for (i in pc){
  #위의 rgb_pcd안 각각 데이터에 function을 적용하는 메서드가 sapply
  pca_img <- sapply(rgb_pcd, function(j){
    # %*%은 행렬곱을 의미 
    compressed_img <- j$x[,1:i] %*% t(j$rotation[,1:i])
  }, simplify = 'array')
  writeJPEG(pca_img, paste('dog_pca', i, '.jpg', sep = ''))
}


