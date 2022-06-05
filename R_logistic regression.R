library(caret)

#데이터 확인
raw_data <- read.csv('Data/heart.csv')
str(raw_data)

#원본데이터 보존
data <- raw_data

#target 데이터 범주형으로 변환
data$target <- as.factor(data$target)
#데이터 set화. 유일한 값 추출
unique(data$target)
#나머지 데이터도 한꺼번에 범주화
#lapply활용
factor_var <- c('sex','cp','fbs','restecg',
                'exang','ca','thal')
data[,factor_var] <- lapply(data[,factor_var], factor)
str(data)

#연속형 독립변수 표준화
data$age <- scale(data$age)
data$trestbps <- scale(data$trestbps)
data$chol <- scale(data$chol)
data$thalach <- scale(data$thalach)
data$oldpeak <- scale(data$oldpeak)
data$slope <- scale(data$slope)


#데이터 나누기
set.seed(1234)

datatotal <- sort(sample(nrow(data), nrow(data)*0.7))
train <- data[datatotal,]
test <- dta[-datatotal,]

train_x <- train[,1:12]
train_x
test_x <- test[,13]

train_y <- train[, 1:12]
test_y <- test[, 13]

#데이터 모델링
ctrl <- trainControl(method = "repeatedcv",
                    repeats = 5
                     )
logitFit <- train(target ~.,
                  data=train,
                  method='LogitBoost',
                  trControl=ctrl,
                  metric='Accuracy'
                  )
plot(logitFit)

#만들어진 모델로 실제 데이터 테스트
pred_test <- predict(logitFit, newdata = test)
confusionMatrix(pred_test, test$target)

#머신러닝에 주어진 변수 중요성 파악 및 시각화
var_importance <- varImp(logitFit, scale = F)
var_importance
plot(var_importance)














