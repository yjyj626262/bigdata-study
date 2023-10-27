# classfication과 classifier / 분류 - 분류(지도학습)와 군집(비지도학습)

# 필요 패키지 설치 및 로딩
library(ggplot2)
library(dplyr)

# 데이터 불러오기와 데이터 확인하는 과정
install.packages('readr') # read_csv
install.packages('descr')

library(readr)
library(descr)

# 데이터 불러오기
train <- readr::read_csv('C:/k_digital/data/titanic/train.csv')
test <- readr::read_csv('C:/k_digital/data/titanic/test.csv')

head(train)
head(test)

str(train)

full <- dplyr::bind_rows(train,test) # rbind와 cbind
tail(full)
head(test)

# 변수의 의미 파악
names(train)
names(test)
## PassengerId
## Survived 생존여부 0(사망), 1(생존)
## Pclass 선실의 등급 1, 2, 3
## Name
## Sex
## Age
## Sibsp 동반가족수(형제 또는 배우자)
## Parch 동반가족수(부모 또는 자녀)
## Fare 승선비
## Cabin 선실
## Embarked 승선항 C, Q, S

# 사본 titanic
val <- c('Survived', 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Embarked')
titanic <- train[, c('Survived', 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Embarked')]

# 변수 속성 변경
table(titanic$Survived)
table(titanic$Pclass)
  titanic <- titanic %>% 
    mutate(Sex = as.factor(Sex), Embarked = as.factor(Embarked),
           Pclass = as.factor(Pclass))

titanic$Embarked
str(titanic)
table(titanic)
summary(titanic)
as.data.frame(titanic)

# 문제정의
## 전처리 : 결측치와 이상치의 처리
### 결측값 확인
table(is.na(titanic$Age))
table(is.na(titanic$Embarked))

sapply(titanic, function(x){sum(is.na(x))})

# 결측치 비율
titanic %>% 
  summarise_all(is.na())

### 결측치 대체 - 보간법
#### Age : 연속적인 수치형, 평균값
age_mean <- mean(titanic$Age, na.rm=T)

titanic$Age <- ifelse(is.na(titanic$Age), age_mean, titanic$Age)

#### Embarked : 범주형 데이터, 최빈값
levels(titanic$Embarked)[which.max(table(titanic$Embarked))]
titanic$Embarked[is.na(titanic$Embarked)] <- 
  titanic$Embarked[which.max(table(titanic$Embarked))]
sum(is.na(titanic$Embarked))

## 1. 생존비율 - 사망과 생존의 비율
titanic$Survived
mean(titanic$Survived)
as.factor(titanic$Survived)
table(titanic$Survived)
as.numeric(titanic$Survived)

## 2. 성별에따른 생존비율
titanic %>% 
  group_by(Sex) %>% 
  summarise(mean = mean(Survived))

gender <- ggplot(train, aes(x=Survived, fill=Sex, width = .8)) +geom_bar()
gender

## 3. 선실등급에 따른 생존여부
c <- titanic %>% 
  group_by(Pclass) %>% 
    summarise(mean = mean(Survived))
pie(c$mean)

## 4. 동반가족수에 따른 생존여부
num <- titanic$SibSp + titanic$Parch
titanic$num <- num

as.factor(num)

b <- titanic %>% 
  group_by(num) %>% 
  summarise(mean = mean(Survived))
pie(b$mean)

## 5. 승선항에 따른 생존여부
a <- as.data.frame(titanic %>% 
  group_by(Embarked) %>% 
  summarise(mean = mean(Survived)))

ggplot(a,aes(x=a$Embarked,y=a$mean)) + geom_col()

# 분류분석(Classfication Analysis)
## 학습을 통해 분류 모델을 학습하고 이를 통해 분류 예측하는 분석 기법
## 의사결정트리(Decision Tree), 나이브 베이스 분류, 신경망(ANN), 서포트 벡터(SVM)

