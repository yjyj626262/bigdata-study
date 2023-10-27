# 데이터 불러오기 : 클립보드 데이터를 데이터 프레임으로 변환
apple_df <- read.table(file='clipboard', header=T, sep='\t',stringsAsFactors=T)

summary(apple_df)

# 품종에 따른 무게의 분포 시각화
boxplot(weight ~ model, data=apple_df, ylab = '무게')

# 품종별 당도의 분포 시각화
boxplot(sugar ~ model, data=apple_df, ylab = '당도')

# 품종별 산도의 분포 시각화
boxplot(acid ~ model, data=apple_df, ylab = '산도')

# 훈련데이터 분리(전체 데이터의 80%) : apple_train_idx
apple_df2 <- cbind(model = apple_df$model, as.data.frame(scale(apple_df[2:4])),color = apple_df$color)
p2 <- princomp(apple_df2[,2:4], cor=T)
summary(p2)
apple_df2
plot(p2,type='l')
# 훈련 데이터
levels(apple_df2$model)
apple_row_idx <- createDataPartition(apple_df2$model, p=0.8, list=F)
apple_train <- apple_df2[apple_row_idx,]
apple_train

# 테스트 데이터
apple_test <- apple_df2[-apple_row_idx,]

# 훈련 데이터를 기반으로 분류 모델 생성 : rpart
model <- rpart(model ~ ., data=apple_train, control=rpart.control(minsplit=2))
model

model$cptable
# rpart.plot 시각화
model_prune <- prune(model, cp = 0.0100)
rpart.plot(model_prune)

# 실제값과 예측값을 한 눈에 비교할 수 있는 데이터프레임
predict(model, newdata=apple_test, type='class')
actual <- apple_train$model
expect <- predict(model, newdata = apple_test, type='class')

result_df <- data.frame(actual, expect)
result_df
# 혼동행렬

# 정확도출력