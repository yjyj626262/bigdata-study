# 산술연산자
1+2
(11 + 54 * 2) / 3 - 10
9 %% 3
5 %/% 2
5 /2 
2**16

# 변수
x = 5
x
print(x)

# R에서 권장하는 대입연산자
x <- 10
x

# 대입과 출력을 동시에 할 수 있다.
(x<-2)
x

# 변수 삭제
rm(x)
x

x <- 2
y <- 3

# 현재 사용중인 변수의 목록을 출력
ls()

# 출력함수 : print()
help(print)

x <- "one"
y <- "two"
x
y

print(x,quote = F)

# 특수상수 NA
aaa <-  100
bbb <-  75
ccc <-  80
ddd <-  NA

stu <- c(aaa, bbb, ccc, ddd)
stu

# is.자료형() : 해당 자료형이 맞습니까? TRUE/FALSE
# as.자료형() : 해당 자료형으로 형변환하는 함수
is.na(ddd)

# 특수상수 NULL
x <- NULL
is.null(x)
is.null(1)
is.null(NA)

# vecotr 내장 함수
val <- 1:9
val

## summary() : 수치데이터의 기초 통계량을 한꺼번에 보여주는 함수
summary(val)

x <- 10 # 요소가 1개인 벡터로 취급한다.
x
10 + 20

x <- 1:5
x

xy <- rnorm(30) # 정규분포 난수를 생성하는 함수
xy

length(x)
range(x)
mean(x)
var(x)
sd(x)

# 벡터의 요소에 접근하는 방법 : 인덱스
## [인덱스]
x
# x의 두번째 요소엥 접근
x[2]
# 두번째 요소를 뺀 나머지
x[-2]
x[3] = 30

## [start:end]
x[2:4]
x[c(2, 4)]

# 벡터화 연산 : 벡터에 저장된 요소단위로 계산을 수행한다.
## 벡터 합치기 : append(a, b) - a,b 두개의 벡터를 연결하는 함수
## append(a,b, after_index)
x <- c(3, 6, 8, 12, 15)
y <- c(5, 10, 15, 20, 25)

z <- append(x,y)
z

w <- append(x,y,3)
w

c(1, 2) + c(4, 5)
c(1,2,3) + 1

v <- -5:5
v

# seq = sequence generation ,  seq(from, to, by)
q <- seq(1,5,0.5)
q
q <- seq(1,10,length=10)
q
qq <- seq(10)
qq

x <- c(1,2,3)
y <- c(4,2,8)
# 두 벡터의 비교연산자
x == y


# rep(벡터, times=반복횟수 or each=개별반복횟수)
(x <- rep(c('a','b','c'), times = 4))

# 중복값을 제거하고 대표값만 추출한는 함수
y <- unique(x)
y

xx <- c('a','b','c','d','d')
xx

## 문자를 결합하는 함수 paste
k <- paste(xx[1], xx[2])
k

## print('hello'+'world')
paste('hello','world')
cat(paste('hello', 'world'))

#sep : 구분기호, sep=' '
paste0('aaa', 'bbb', 'ccc')

# substring('문자열', 시작위치, 마지막위치) : 문자열의 일부분 추출
substring('abcdefghijklmn', 2, 5)

# 논리값 : TRUE(T), FALSE(F)
## 논리연산자 : and(&), or(|), not(!)
TRUE & TRUE
T & F
T | F

!TRUE
!F

c(T,T) & c(T,F)

# factor < vector
gender <- factor('M', c('M','F'))
gender

nlevels(gender)

levels(gender)[1]

levels(gender) <- c('male', 'female')
gender

help(factor)

ordered(c('a','b','c'))   # a < b < c

factor(c('a','b','c'), ordered = TRUE)

# 행렬(matrix)
help(matrix)

matrix(1:9,3,3)

# matrix(data,행 nrow=수,열 ncol=수, byrow=T or F, dimnames = list())
# 이때 dimnames는 리스트타입으로 지정을 해줘야하며 항은 (c(행,열))

matrix(1:9, nrow = 3, dimnames = list(c('item1', 'item2', 'item3'),c('att1','att2','att3')))

## 행렬의 데이터에 접근하는 방법 : [행인덱스, 열인덱스]
x <- matrix(1:9, 3)
x

x[1,1]
x[1,2]
x[-0,]
x[-4,]
x[-0,-0]
x[0,]
x[.0]
x[,0]
x[2.0]
x[2]
x[6]
x0
x[0]
x[-3]
x[-3,]

x[c(1,3),c(1,3)]

y <- matrix(1:9, nrow = 3, dimnames = list(c('item1', 'item2', 'item3'),c('att1','att2','att3')))

y['item1',]

x
x * 2
x +y
x**y
x%*%y

# 전치행렬
t(x)

help(array)
matrix(1:12, ncol=4)
array(1:12, dim = c(3,4))
y=array(1:12, dim = c(2,2,3))
x=array(1:900, dim = c(3,3,100))

dim(x)

x[1,1,1]
y[1,2,3]
y[1,1,0]

# 리스트(list)
x <- list(name = '홍길동', height = 170)
x

# 이 때 나오는 $는 인덱스를 의미한다
x$name
x <- list(name = '홍길동', height = c(170, 187, 163))
x

x$name
x$height
x$height[2]

list(a=list(val=c(1,2,3),b=list(val=c(1,2,3,4))))

# 리스트 내 데이터에 접근하는 방법 : $
## 리스트명$변수명$키 or 리스트[[인덱스]]
x <- list(name = '홍길동', height = c(1, 3, 5))
x
x$name
x$height
x[[1]]
x[1]
x[[2]][2]
x[1]
x[1,1]
x[1]
x[2][1]

# 데이터 프레임(Data Frame)
d <- data.frame(x = c(1,2,3,4,5), y = c(2,4,6,8,10))
d

d2 <- data.frame(x = 1:5, y = c(2, 4, 6, 8 ,10), z = c('M','F','M','F','M'))
d2

## 기존의 데이터프레임에 특정 컬럼 추가
d2$v <- c(3,6,9,12,15)
d2

d2$x
d2[2,1]
d2[0,]

d2[, c('x','y')]
d2[,'x',drop =T]

str(d2)

# 타입(data type) 확인
## mode(), typeof(), class() <자료구조 타입>
class(c(1,2))
class(matrix(c(1,2)))

class(list(c(1),(2)))

class(data.frame(x=c(1,2)))

str(matrix(c(1,2)))

# is.factor(), is.matrix(), is data.frame(), is.charcter()
is.matrix(c(1,2,3))

is.matrix(matrix(c(1,2)))

# 형변환 : as.*
x <- c('m','f')
as.factor(x)
as.numeric(as.factor(x))
