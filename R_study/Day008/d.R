# pacakges install

# load data
bike <- read.csv('C:/k_digital/data/SeoulBikeData.csv')
summary(bike)
head(bike)

# 회귀 - 예측
names(bike)

## Date : 대여일(년-월-일)
## Rented_Bike_Count : 대여 자전거 수
## Hour : 대여 시간
## Tempearture : 온도
## Humidity : 습도(%)
## windspeed : 풍속(m/s)
## Visibility : 가시성(10m)
## Dew_point_temperature : 이슬점
## Solar_Radiation : 일사량(MJ/m2)
## Rainfall : 강우량
## Snowfall : 적설량
## Seasopns : 계절
## Holiday : 공휴일/주말
## Functioning_Day : 비근무시간(NoFunc), 근무시간(Fun)


# scatter plot : 온도와 자전거 대여수의 상관성
plot(x=bike$Temperature,y=bike$Rented_Bike_Count)

# 선형 회구분석
## 회귀방정식 y = ax + b
model <- lm(Rented_Bike_Count ~ Temperature, bike)
model

summary(model)

## 예측 y=ax+b
## a = 29.08
## b = 329.95
temp_temperature = 23
a = 29.08
b = 329.95

y= a*temp_temperature + b
y

# 회귀선 추가
plot(x=bike$Temperature, y=bike$Rented_Bike_Count)
abline(a=b, b=a, col='red')

# 여러개의 값을 이용한 예측
temperature_list = c(-10, 0, 10, 20, 30, 40)
new <- data.frame(Temperature = temperature_list)
pred_list <- predict(model, newdata = new)

data.frame(Temperature=temperature_list, pred_bike_count= pred_list)
