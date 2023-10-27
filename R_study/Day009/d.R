# 보스턴 집값 예측 : 회귀분석(선형회귀)

data(Boston)
# 해당 데이터셋을 파일로 저장
write.csv(Boston, file= 'boston.csv', row.names =T)

df <- read.csv('boston.csv', header = T, stringsAsFactors = F)
?Boston
# 종속변수에 해당하는 medv(집값)을 제외하고 데이터 추출
df <- df[, ]

# 변수의 의미
## crim : 1인당 범죄율
## zn : 25,000 초과하는 거주지역의 비율
## indus : 비상업지역이 점유하고 있는 토지의 비율
## chas : 찰스강 경계 1, 아니면 0
## nox : 10PPM당 일산화질소
## rm : 평균 방의 개수
## age : 1940년 이전에 건축된 소유주택의 비율
## dis : 직업센터까지의 접근성의 지수
## rad : 방사형 도로까지의 접근성 지수 - 도시고속도로
## tax : 재산세율
## ptratio : 학생과 교사의 비율
## black : 흑인의 비율
## lstat : 저소득층 비율
## medv : 주택가격(단위 1,000)

# 기술통계량
install.packages('Hmisc')
library(Hmisc)
describe(df)
summary(medv~crim+zn, data= df)

# 데이터 전처리
## 결측치 확인
apply(df, 2, function(x)sum(is.na(x)))

df[complete.cases(df),] # 결측치가 없으면 TRUE

head(df, 10)

# 결측치 삭제
df <- na.omit(df)

# 결측치삭제
df$crim[is.na(df$crim)] <- 0

mean_crim <- mean(df$crim)

# 데이터 분할 - 학습, 성능평가
nrow(df)
## 랜덤 샘플링 : train(70%), test(30%)
df_idx <- sample(1:506, 300)
df_train <- df[df_idx,]
df_test <- df[-df_idx,]

nrow(df_train)
nrow(df_test)

# 다중회귀분석
result <- lm(medv ~ ., data=df_train)
summary(result)
## Adjusted R-squared(설명력) : 집값예측을 했을 때 맞출확률이 70퍼센트정도 된다.
## 여러개의 변수를 가지고 회귀분석을 할 때에는 다중공선성을 생각해야함
## 다중공선성 : 독립변수들 간에 지나친 상관관계가 존재한다면 그 데이터의 신뢰성은 떨어짐
### 팽창지수가 일반적으로 10이넘으면 다중공선성이 발생한다.
install.packages('car')
library(car)
vif(result) # 다중공선성 체크 사람에따라 5이상도 다중공선성이 발생했다고 본다.

# 이상치 분석
outlierTest(result)

# 상관관계 - 시각화, 통계량(cor)
vif(result)
cor(df)[,"medv"]
a <- c(10,11)
df2 <- df[,-a]
names(df)
library(caret)
df_idx <- createDataPartition(df$medv, p=0.8, list = F)
df2_train <- df2[df_idx,]
df2_test <- df2[-df_idx,]

result2 <- lm(medv~.,df2_train)
# 회귀분석 결과 - 요약보고서
summary(result2)
vif(result2)

# 변수선택
## 전진 선택법(forward selection) : 절편만 있는 모델에서 가장 많이 개선시키는 변수를 차례로 추가하는 방법
## 변수 소거법(backward elimination) : 모든 변수가 포함된 모델에서 기준 통계치에 가장 도움이되지 않는 변수를 하나씩 제거하는 방법
## 단계적 방법(stepwise selection) : 모든 변수가 포함된 모델에서 시작하여 기준 통계치에 가장 도움이 되지 않는 변수를 삭제하거나 모델에서 빠져있는 변수 중에서 기준 통계치를 가장 개선시키는 변수 추가하는 방법

model <- lm(medv ~., df_train)
model2 <- step(model, direction = 'both') # step(단계적 변수선택)
# AIC : 통계 모델 간의 적합성을 비교하는 모델 지표
# AIC 는 작을 수록 더 좋은 모델을 의미한다.
model3 <- lm(medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + black + lstat, df_train)
summary(model3)
summary(model2)
summary(model)

df_test <- df_test[,-15]
expect <- predict(model2, newdata=df_test)
df_test <- df[-df_idx,]
actual <- df_test$medv
result_df <- data.frame(actual, expect)
result_df

t.test(result_df)

## 혼동행렬 4가지 지표 accurate, f1score, 
## 일반적으로 rms2라는 평가지표를 쓴다.
## 두번째로 많이 쓰는 회귀 random forest, 이후 로지스틱 알고리즘
## 기본평균오차 ms2 와  rms2