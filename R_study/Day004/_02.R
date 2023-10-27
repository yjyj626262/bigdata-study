# 데이터 정제 : 이상치와 결측치 처리
## 결측치(missing value) : 누락된 값
### is.na()
### na.omit() : NA 결측값이 존재하는 행을 제거
### na.rm = T or F

str(airquality)
head(is.na(airquality))

apply(airquality,2,function(x){sum(is.na(x))})

apply(airquality,2,mean, na.rm=T)

## Ozone에 결측값이 아닌 관측데이터만 추출
air_narm <- airquality[!is.na(airquality$Ozone), ]
mean(air_narm$Ozone)
head(air_narm)

air_omit <- na.omit(airquality)
mean(air_omit$Ozone)

mean(airquality$Ozone, na.rm=T)

## 이상치(outlier)
patients <- data.frame(name=c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age = c(22, 30, 41, 27, 38),
                       gender = factor(c('M', 'F', 'M', 'K', 'F')),
                       bloode.type = factor(c('A', 'O', 'B', 'AB', 'C')))
patients
str(patients)

### 성별에서 이상치를 제거하고 추출
patients_omit <- patients[patients$gender == 'M' | patients$gender == 'F',]
patients_omit

### patients에서 성별과 혈액형에 이상치를 제거하고제출
patients_outlier <- patients[(patients$gender == 'M' | patients$gender == 'F') & (patients$bloode.type == 'O'),]

patients1 <- data.frame(name=c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age = c(22, 30, 41, 27, 38),
                       gender = c(1,2,1,3,2),
                       bloode.type = c(1,3,2,4,5))
patients1

## 성별의 이상치를 결측치 처리

patients1$gender <- ifelse(patients1$gender > 2, NA, patients1$gender)

## 혈액형의 이상치를 결측치 처리
patients1$bloode.type <- ifelse(patients1$bloode.type > 4, NA, patients1$bloode.type)

patients1


## 이상치를 판단하기 어려운 데이터의 처리
boxplot(airquality[,1:4])$stats

## Ozone 컬럼에 이상치를 찾아 결측처리
air <- airquality
str(air)
air$Ozone <- ifelse(air$Ozone < 1 | air$Ozone > 122, NA, air$Ozone)
table(is.na(air$Ozone))

## cars 데이터셋의 dist의 이상치를 제거한 후 dist의 평균을 계산하시오.
### 단, 이상치의 판단은 boxplot을 이용할 것
car = cars
boxplot(car)$stats
car$dist <- ifelse(car$dist < 2 | car$dist > 93, NA, car$dist)

## ChickWeight 데이터에서 병아리 무게(weight)의 이상치를 제거한 후 평균 무게를 구하시오.
### 단, 이상치의 판단은 boxplot을 이용할 것
chick <-  ChickWeight
boxplot(ChickWeight)$stats
chick$weight <- ifelse(chick$weight < 35 | chick$weight > 309, NA, chick$weight)
mean(chick$weight, na.rm=T)

