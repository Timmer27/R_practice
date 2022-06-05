library(caret)

#데이터 불러오기
raw_data <- read.csv('Data/wine.csv')
data <- raw_data

#데이터 종류 확인하기
str(data)

#범주형 데이터로 바꾸기
data$Class <- as.factor(data$Class)

#데이터 고정하기
set.seed(1234)

#데이터 학습/실습 분할하기
totaldata <- sort(sample(nrow(data), nrow(data)*0.7))
train <- data[totaldata,]
test <- data[-totaldata,]

train_X <- train[,1:13]
test_X <- test[1,13]

train_y <- train[,1:13]
test_y <- test[,14]

#데이터 모델링 후 학습
ctrl = trainControl(method = "repeatedcv", repeats = 5)
nbFit <- train(
            Class ~ .,
            data = train,
            method='naive_bayes',
            trControl=ctrl,
            preProcess=c("center", "scale"),
            metric="Accuracy")

nbFit
plot(nbFit)


#실제 test데이터로 예측
pred <- predict(nbFit, newdata =  test)
confusionMatrix(pred, test$Class)

#변수 중요도 출력 및 시각화
var_importance <- varImp(nbFit, scale = F)
plot(var_importance)

