#패키지 설치 및 불러오기
install.packages("caret", dependencies = T)
library(caret)

#데이터 불러오기
raw_data <- read.csv("Data/wine.csv")
data <- raw_data
str(data)

#데이터 나누기
data$Class <- as.factor(data$Class)

totaldata <- sort(sample(nrow(data), nrow(data)*0.7))
train <- data[totaldata,]
test <- data[-totaldata,]

train_x <- train[,1:13]
test_x <- test[,14]

train_y <- train[,1:13]
test_y <- test[,14]

#데이터 모델링
#randomforest이므로 method에 rf 대입
ctrl <- trainControl(method = "repeatedcv", repeats = 5)
rfFit <- train(Class~.,
               data=train,
               method='rf',
               tfControl=ctrl,
               preProcess=c('center', 'scale'),
               metric="Accuracy"
               )
rfFit
plot(rfFit)




pred <- predict(rfFit, test)
confusionMatrix(pred, test$Class)












