# 데이터 프레임의 내용에 접근
## [인덱스], [행인덱스, 열인덱스], [행인덱스, 열인덱스, 면인덱스]
## [조건식]

### 팬시인덱스 : 조건에 의해 원하는 값을 추출
x <- c(FALSE, TRUE, FALSE, FALSE, TRUE)
y <- c(1, 2, 3, 4, 5)
x
mode(x)
typeof(x)
class(x)

y
y[c(2,5)]

a <- matrix(1:9, nrow = 3)
a

# [행조건식, 열조건식]

a[, 2] > 4  # FALSE TRUE FALSE

a[행조건식, 열조건식]

a[a[,2]>4,]

x=1:3
a[ x %% 2 == 1, ]

# 데이터프레임
d <- data.frame(x = c(1, 2, 3, 4, 5), y = c(2, 4, 6, 8, 10))
d

d$x

d[,'x', drop = F]

# 데이터 프레임의 열이름(colnames) = names() , 행 이름(rownames)
colnames(d)
names(d)
rownames(d);

# 여러 개의 벡터를 이용하여 데이터프레임을 생성
name = c('홍길동', '장보고', '유관순', '이순신', '강감찬')
age = c(20, 25, 19, 22, 31)
gender = factor(c('M', 'F', 'F', 'M', 'F'))
blood.type = factor(c('A', 'O', 'AB', 'B', 'O'))

p <- data.frame(name, age, gender, blood.type)
p
p2 <- data.frame(name = c('홍길동', '장보고', '유관순', '이순신', '강감찬'),
                 age = c(20, 25, 19, 22, 31),
                 gender = factor(c('M', 'F', 'F', 'M', 'F')),
                 blood.type = factor(c('A', 'O', 'AB', 'B', 'O'))
)

p2

p$name
p[1,]
p[, 2, drop=F]

## 유관순 정보만 추출
p[3, ]
p[name== '유관순',]
p[p$name == '유관순', ]

## 이순신의 나이와 혈액형만 추출
p[p$name == '이순신',c('age','blood.type')]

#데이터프레임에 유용한 함수
## R에서 내장된 데이터셋
data()
#자동차의 속도와 제동거리의 상관관계를 분석하기 위해 수집된 데이터 셋
cars
str(cars) #구조확인

##데이터 프레임의 속성명을 변수명으로 사용
##attach - 설정, detach - 해제

attach(cars)
speed

detach(cars)
speed

#with함수
with(cars,mean(speed))

#데이터 프레임의 일부분 추출
head(cars)
tail(cars)

#subset(데이터프레임, 조건식, select)
##cars 데이터셋에서 속도가 20을 초과하는 데이터만 추출
cars[cars$speed > 20,]

subset(cars, speed>20) #이게 위의 코드랑 같은거다

##속도가 20이상 23이하인 거리만 추출
subset(cars, speed>=20 & speed <=23, dist)

cars[cars$speed >=20 & 23 >= cars$speed, 'dist', drop=F] #위의 코드와 같다




plot(speed, dist, xlab='속도', ylab='거리')
