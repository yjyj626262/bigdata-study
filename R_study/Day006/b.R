# 변수
# 벡터(Vector) : 1차원 배열
## c(), start:end, seq(from, to, by), rep(vector, times or each)
x <- c(1,2,3,4,5)

a <- c("1", "2", "3", c(4, 5,6))
a
a[5]

# 접근방법 : [index], [condition], [-index]

a%%2
x%%2
NROW(x[x%%2 ==0])

yy <- c('a','b','c')

# 벡터의 각 요소에 이름을 부여
names(yy)

names(yy) <- c('kim','lee','park')
yy

names(yy)[2]

# 벡터의 길이 : length() or NROW() - 대문자임을 주의!
x <- c('a','b','c')
length(x)
NROW(x)

# 벡터 연산
'a' %in% x

# 리스트(List) : 파이썬의 딕셔너리(사전) 자료형과 동일
## 키 = 값의 형태로 데이터를 관리한다.
## 키는 중복불가, 값은 중복가능
x <- list(name = 'foo', height = 70)
x

x$name
x$height

x[[1]]
x[[2]]

## 리스트를 구성하고있는 각 요소는 크기와 자료형이 달라도 가능하다.
x <- list(name='foo', height = c(1,2,3))
x
x$name[[2]]
x$height[2]
x[[2]]
x[2]
x[[2]]
x[[[2]]]
x[[2]][2]

y <- list(a = list(val = c(1,2,3)), b= list(val=c(1,2,3,4)))
y
a[[[2]]]
a[[2]]
a[2]

# 행렬 : 여러 개의 벡터가 결합되어 있는 형태
## matrix(data, nrow, ncol, byrow=T)
matrix(1:9, nrow=3, byrow=T)

abc <- data %>% 
  mutate_all(function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))  # 결측값을 해당 칼럼의 평균으로 채웁니다.

## 행렬에 행과 열에 이름을 부여 dimnames(list())
matrix(1:9, nrow=3, byrow=T, dimnames=list(c('행1','행2','행3'),c('열1','열2','열3')))

## 행렬에 접근 : [행인덱스, 열인덱스] or [행조건, 열조건]
matrix(1:9, nrow=3, byrow=T, dimnames=list(c('행1','행2','행3'),c('열1','열2','열3'))) ->m
m
### 1,2행 추출
m[-3,]
### 3행 제외
m[-3,]
### 1행, 3행, 1열, 3열 추출
m[c(1,3), c(1,3)]
