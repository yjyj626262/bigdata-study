# R base 내장 데이터
data()
iris
## 데이터 표 형태로 데이터를 보여주는 View()
help(View)
View(iris)
## 데이터 구조 확인 str()
str(iris)

# 데이터 셋 목록 확인
library(help=datasets)

# 실제 데이터를 사용할 떄
data(mtcars)

## head()와 tail()
head(mtcars)
View(mtcars)

# 파일 입출력
## csv 파일 입출력 : read.csv(파일명, header=TRUE)
x <- read.csv('C:/k_digital/data/aaa.csv')
x
str(x)

x <- read.csv('C:/k_digital/data/bbb.csv')
x

names(x)

names(x) <- c('id','name','score')
x

x <- read.csv('C:/k_digital/data/bbb.csv',header=F)
x

str(x)
x$name <- as.factor(x$name)
x$name <- as.character(x$name)

?read.csv
x <- read.csv('C:/k_digital/data/bbb.csv', stringsAsFactors = F)
str(x)

x <- read.csv('C:/k_digital/data/aaa.csv', na.strings = 'NIL')
x
str(x)ss

is.na(x$score)

table(is.na(x$score))

# 데이터를 파일로 저장하는 방법
getwd()
write.csv(x, 'ccc.csv',row.names = F)

# R 객체를 그대로 파일로 저장하고 불러오는 함수, RData 확장자
x <- 1:5
y <- 6:10
save(x, y, file='xy.RData')
x
y

## 현재 메모리상에 있는 모든 객체를 삭제하는 작업
rm(list=ls())
x

load('xy.RData')

# 외부 데이터 가져오기 : 엑셀파일, read_excel()
## 별도의 새로운 패키지 설치
install.packages('readxl')
## 패키지 불러오기
library(readxl)

## 엑셀파일 불러오기
ex_data <- read_excel('C:/k_digital/data/ex_data.xlsx')
View(ex_data)

# rbind(), cbind() : 각각 행 또는 열 형태로 데이터를 합쳐서 행렬 또는 데이터프레임

rbind(c(1,2,3),c(4,5,6))

x <- data.frame(id=c(1,2), name=c('a','b'), stringsAsFactors = F)
x
str(x)

y <- rbind(x,c(3,'c'))
y

cbind(c(1,2,3),c(4,5,6))

y <- cbind(x, test = c('pass','fail'))
y

# apply 계열의 함수들 : 벡터, 행렬, 리스트, 데이터프레임에 반복적으로 적용하는 함수
## 종류 : appply, lapply, sapply, tapply
## apply(행렬, 방향) : 행 또는 열방향으로 특정 함수를 적용할 때 사용

?apply

sum(1:10)

d <- matrix(1:9, ncol =3)
d
#### 주어진 행렬의 행들의 합을 계산
apply(d, 1, sum) ## 1-행방향, 2-열방향

apply(d, 2, sum)

view(iris)
str(iris)

### iris 데이터의 각 컬럼(feature)이 합을 계산
apply(iris[, 1:4], 2, sum)

#### rowSums(), colSums(), rowMeans(), colMeans()
colSums(iris[,1:4])

## lapply(x, 함수), x - 벡터 또는 리스트
### 결과가 리스트로 반환된다.
result <- lapply(1:3,function(x){ x * 2})
result

### 리스트를 벡터로 변환하는 함수
unlist(result)

## 리스트 생성 : 키와 값을 쌍으로 관리하는 자료구조
x <- list(a = 1:3, b = 4:6)

lapply(x, mean)

lapply(iris[,1:4],mean)

colMeans(iris[,1:4])

### 리스트를 데이터 프레임으로 변환할 때
#### 1. unlist() 함수를 통해 리스트를 벡터로 변환
unlist(lapply(iris[,1:4], mean))
#### 2. matrix() 함수를 통해 벡터를 행렬로 변환
matrix(unlist(lapply(iris[,1:4], mean)),ncol = 4, byrow = T)
#### 3. as.data.frame() 함수를 이용해서 데이터프레임으로 변환
as.data.frame(matrix(unlist(lapply(iris[,1:4], mean)),ncol = 4, byrow = T))
#### 4. names() 함수를 이용해서 리스트로부터 컬럼명을 얻어와 데이터프레임에 부여
names(iris[,1:4])
d <- as.data.frame(matrix(unlist(lapply(iris[,1:4], mean)),ncol = 4, byrow = T))
names(d) <- names(iris[,1:4])
d

# sapply : lapply와 유사하지만 리스트대신 행렬, 벡터 등으로 결과가 반환된다.
## lris 컬럼별 평균 계산
lapply(iris[,1:4], mean)
sapply(iris[,1:4], mean)
class(sapply(iris[,1:4], mean))
x<- sapply(iris[,1:4], mean)

as.data.frame(t(x)) # t() - 전치행렬

sapply(iris, class)

result <- sapply(iris[,1:4], function(x){ x > 3})
result
head(result)

# tapply :  그룹별 처리를 위한 apply 함수
## tapply(데이터, 색인_어떤 그룹에 속하는지 표현하는 것, 함수)
tapply(1:10, rep(1,10), sum)

## 홀수별, 짝수별로 묶어서 합계를 구하시오.
tapply(1:10, 1:10 %% 2 == 1, sum)


### 행렬(행-계절, 열-성별)
m <- matrix(1:8, ncol=2, dimnames=list(c('spring','summmer','fall','winter'),c('male','female')))
m

#### 분기별 남성과 여성의 합계를 구하시오.
#### 상반기(봄, 여름), 하반기(가을, 겨울)
#### 상반기 남성(1+2), 여성(5+6), 하반기 남성(3+4), 여성(7+8)

tapply(m, list(c(1,1,2,2,1,1,2,2), c(1,1,1,1,2,2,2,2)),sum)

# doBy 패키지
## summaryBY(), orderBy(), splitBy(), sampleBy():

### summmary() : 수치데이터의 기초통계량을 나타내는 함수
summary(iris)

install.packages('doBy')
library(doBy)
# 사분위수를 추출
quantile(iris$Sepal.Length) # 0%, 25%, 50%, 75%, 100%
quantile(iris$Sepal.Length, seq(0, 1, by=0.1))
## formula식 : 독립변수 ~ 종속변수, 독립변수1+독립변수2 ~ 종속변수
summaryBy(Sepal.Length + Sepal.Width ~ Species, iris)
## formula식 .(all)
orderBy( ~ Sepal.Width, iris)

order(iris$Sepal.Width)


iris[order(iris$Sepal.Width),]

sample(1:10, 5)
sample(1:10, 5, replace = T) #중복허용
sample(1:10, 20, replace = T)

## 데이터를 무작위로 섞어내는 역할을 사용한다.
## iris 데이터를 무작위로 섞는 작업
iris[sample(NROW(iris),NROW(iris)),]
### 랜덤샘플링
sampleBy(~ Species, frac = 0.1, data=iris)

## split(데이터, 분리조건) - 리스트로 반환된다.
split(iris, iris$Species)

lapply(iris[,1:4], mean)

lapply(split(iris$Sepal.Length,iris$Species), mean)

# subset() : 소개
subset(iris, Species ==  'setosa')

subset(iris, Species ==  'setosa' & Sepal.Length > 5.0)

subset(iris, select = c(Sepal.Length, Species))

subset(iris, select = -c(Sepal.Length, Species))

# merge() : join과 같은 역할을 수행하는 함수
x <- data.frame(name = c('a','b','c'), math = c(1,2,3))
x

y <- data.frame(name = c('c','b','a'), kor = c(4,5,6))
y

cbind(x, y)
merge(x,y, all=T) # full output join, 일치하지 않더라도 조인(NA)

# sort(), order() : 데이터를 정렬하는 함수

x <- c(20,11,33,50,43)
x

sort(x) #정렬옵션, decreasing = T, 내림차순
sort(x, decreasing = T)

order(x) # 정렬후 인덱스  반환
order(-x)

x[order(x)]

# with(), within()
mean(iris$Sepal.Length)
print(mean(iris$Sepal.Length))
print(mean(iris$Sepal.Width))
with(iris, mean(Sepal.Length))
with(iris, {
  print(mean(iris$Sepal.Length))
  print(mean(iris$Sepal.Width))
})
x <- data.frame(val = c(1,2,3,4,NA,5,NA))
x

mean(x$val)
is.na(x$val)
mean(is.na(x$val))
mean(x$val, na.rm = T)

## ifelse(조건식, 참일때, 거짓일때)

## 수치데이터의 결측값을 보간하는 방법 : 평균값 or 최빈값
x <- within(x, {
  val <- ifelse(is.na(val), median(val, na.rm=T), val)
})

x$val[is.na(x$val)] <- median(x$val, na.rm=T)
x

iris[1,1] <- NA
head(iris)

## 결측값이 존재하는 해당 품종의 중앙값으로 대체하는 작업
### step1. setosa 품종의 Sepal.Length에 중앙값을 구한다.
rs <- sapply(split(iris$Sepal.Length, iris$Species), median,na.rm=T)
rs
### step2. 해당 중앙값으로 결측값을 채운다.
iris <- within(iris, {
  Sepal.Length <- ifelse(is.na(Sepal.Length), rs[Species], Sepal.Length)
})

head(iris)
# attach(), detach()
iris$Sepal.Length
attach(iris)
Sepal.Length
detach(iris)


#which(),which.max(), which.min()
## which 함수는 벡터나 배열에서 주어진 조건에 만족하는 값이 있는 인덱스 반환
x <- c(2,4,6,7,10)

x %% 2

which(x %% 2 == 0)
x[which(x %% 2 == 0)]

which.max(x)
which.min(x)

sort(x)[1] # which.min()
-sort(-x)[1] # which.max()

# aggregate() : 그룹별 연산을 수행하는 함수
## aggregate(데이터, 그룹조건, 함수) or aggregate(formula, 데이터, 함수)

### iris 데이터에서 품종별로 Sepal.Width의 평균 계산
aggregate(Sepal.Width ~ Species, iris, mean)



 