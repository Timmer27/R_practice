library(caret)


#선형 - svmLinear
#데이터가 있을 때 선형으로 직선을 그어서 데이터 분리를 함

#비선형 -svmPoly
#말그대로 직선이 아닌 곡선모양으로 데이터를 분리

#선형 서포트 벡터 머신
#실습
rawdata <- read.csv('Data/wine.csv')
data <- rawdata
data$Class <- as.factor(data$Class)
str(data)

#데이터 분할
set.seed(1234)
totaldata <- sort(sample(nrow(data), nrow(data)*0.7))
train <- data[totaldata,]
test <- data[-totaldata,]

train_x <- train[,1:13]
test_x <- test[,14]

train_y <- train[,1:13]
test_y <- test[,14]

ctrl <- trainControl(method = "repeatedcv", repeats = 5)
svm_ploy_fit <- train(
  Class~.,
  data = train,
  method = "svmPoly",
  trControl = ctrl,
  preProcess = c("center", "scale"),
  metric = "Accuracy"
)

svm_ploy_fit
plot(svm_ploy_fit)
#결과값 : 97.6%
pred <- predict(svm_ploy_fit, test)
confusionMatrix(pred, test$Class)

var_importance <- varImp(svm_ploy_fit, scale = F)
var_importance
plot(var_importance)




















