library(jpeg)
#데이터 불러오고
img <- readJPEG('Data/dog.jpg')
class(img)

#이제 rgb가 비슷한 데이터끼리 묶어줌

imgdim <- as.vector(dim(img))
#3차원 데이터 개수 파악 -dimension 파악
imgdim

#데이터 프레임 생성
imgRGB <- data.frame(
  #1부터 640까지 425번 반복
  x = rep(1:imgdim[2], each = imgdim[1]),
  #425부터 1까지 640번 반복
  y = rep(imgdim[1]:1, imgdim[2]),
  R = as.vector(img[,,1]),
  G = as.vector(img[,,2]),
  B = as.vector(img[,,3])
)

head(imgRGB)
tail(imgRGB)


#색상 개수 축소
#축소할 색상 클러스터 개수
kclusters <-c(3,5,10,15,30,50)
#데이터 축소해서 저장
for (i in kclusters){
  img_kmeans <- kmeans(imgRGB[, c("R", "G", "B")], centers = i)
  img_result <- img_kmeans$centers[img_kmeans$cluster,]
  img_array <- array(img_result, dim = imgdim)
  writeJPEG(img_array, paste('kmeans_', i, 'clusters.jpg', sep = ''))
}














