install.packages("tree")
library(tree)
library(caret)

#구할 타겟의 이름 - Class
#.은 피쳐
#data는 학습에 필요한 데이터
treeRaw <- tree(Class~. , data = train)
#plot으로 배경을 그리고
plot(treeRaw)
#text로 각각의 노드 이름을 넣는다
text(treeRaw)

#cross validation을 하기위해 cv.tree로 지정하고
#가지치기를 하기위한 FUN에 prune.misclass(오분류기준)를 지정한다
cv_tree <- cv.tree(treeRaw, FUN = prune.misclass)
plot(cv_tree)

#가지치기
#best를 4로 지정함으로써 노드의 개수가 4개로 줄었다.
prune_tree <- prune.misclass(treeRaw, best = 5)
#가지치기를 완료하고 새로운 데이터로 시각화
plot(prune_tree)
#pretty는 0으로 지정할 시 분할 피쳐의 이름을 바꾸지 않는다는 의미
text(prune_tree, pretty = 0)

#예측하기
#predict에는 가지치기 이후 트리를 넣어주고 테스트 데이터로 예측값을 확인한 후 class데이터를 예측한다고 type에 명시한다.
pred <- predict(prune_tree, test, type = 'class')
confusionMatrix(pred, test$Class)










raw_data <- read.csv('Data/wine.csv')
data <- raw_data
str(data)

data$Class <- as.factor(data$Class)

set.seed(1234)
totaldata <- sort(sample(nrow(data), nrow(data)*0.7))
train <- data[totaldata,]
test <- data[-totaldata,]

train_x <- train[,1:13]
test_x <- test[,14]

train_y <- train[,1:13]
test_y <- test[,14]

library(tree)

tree_raw <- tree(Class~., data = train)
plot(tree_raw)
text(tree_raw)

cv_tree <- cv.tree(tree_raw, FUN = prune.misclass)
plot(cv_tree)     

prune_tree <- prune.misclass(tree_raw, best = 5)
plot(prune_tree)
text(prune_tree, pretty = 0)

pred <- predict(prune_tree, test, type = 'class')
confusionMatrix(pred, test$Class)








