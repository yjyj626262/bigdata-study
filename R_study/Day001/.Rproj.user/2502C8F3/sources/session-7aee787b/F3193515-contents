# R의 자료구조
## 변수 => 벡터 => 행렬 => 배열  (확장의 의미)
## 행렬 => 데이터프레임 => 리스트
## 데이터분석에 특화된 자료구조 => 데이터프레임

# 행렬(matrix) : 벡터의 확장
## 행과 열로 구성된 2차원 배열
## 행렬(matrix)은 2차원만 가능하고, 배열(array)은 N차원이 가능한 자료구조
## cbind(열단위), rbind(행단위)는 기존 벡터를 묶어 배열을 생성할 때 사용한다.

help(matrix)

# 3행 3열 행렬 생성
## nrow = 행의 수, ncol = 열의 수
matrix(1:9, nrow = 3)
## matrix 참조[행의위치, 열의위치]
matrix(1:9, nrow = 3, byrow = TRUE)

## 행렬의 이름을 부여하는 함수 dimnames
dimnamex = list(c('r1','r2','r3'),c('c1','c2','c3'))
x = matrix(1:9, nrow = 3, byrow = TRUE , dimnames = dimnamex)
x

## 행렬의 요소 추출 : 인덱스[행위치, 열위치]
x[2,2]

x[1:2,2:3]
x[1,]
x[,3]

x[1:2,]
x[c(1,2),]
x[2:3,2:3]

x[-3,]

x[,'c2']
x['r3',]

x[c(1,3),c(1,3)]

y = matrix(1:9, nrow= 3)
y

y+2
y /2

a = matrix(1:4, nrow = 2)
b = matrix(5:8, nrow = 2)
a+b
a*b

a
b
a %*% a
a %*% b

## 전치행렬 : 행과 열의 위치를 바꿔주는 함수
t(a)

nrow(a)

xx = matrix(1:6, ncol = 3)
nrow(xx)
ncol(xx)
xx

cbind(a,b)
rbind(a,b)

## 배열 : array(벡터형데이터, dim=c(행, 열))
## 3행 4열짜리 2차원 배열을 생성
x=array(1:12, dim = c(3,4))
x
x

dim(x)

# 2행2열짜리 행렬 3개를 생성하시오.
yy = array(1:12, dim = c(2, 2, 3))
yy

yy[1, 1, 1]
yy[1,2,3]

# 행렬 연산 apply(행렬데이터, 방향, 연산함수)
## 방향 : 1(행단위), 2(열단위)
z = array(1:12,c(3,4))
z

sum(z)
mean(z)

apply(z, 1, sum)
apply(z, 2, mean)
apply(yy, 3, sum)

# sample() : 벡터나 배열에서 샘플을 추출할 때 사용
w = array(1:12, c(3,4))
w

help(sample)
sample(w, 10)
sample(1:45,6)
sample(1:15, 20, replace = T)
