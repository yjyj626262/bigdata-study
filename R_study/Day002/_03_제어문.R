# if 조건문
## 조건문은 주어진 조건이 참일때 실행할 문장을 제어할 때 사용하는 문장

x <- runif(1) # 0~1사이의 난수
x

## x가 0보다 크면 절대값을 추출하는 조건문
if(x > 0) print(abs(x))

## x가 0.5보다 작으면 1 - x를 출력하고, 그렇지 않으면 x가 출력되는 조건문
if(x < 0.5) print(1-x) else print(x)

## 위와 동일, 삼항연산자
ifelse(x < 0.5, 1-x, x)

y <- -9
if(y %% 2 == 0) print('짝수') else print('홀수')

z <- -11
if(z %% 2 == 0){
  print(z)
  print('짝수입니다')
  print(abs(z))
}else{
  print(z)
  print('홀수입니다')
  print(abs(z))
}

## 양수, 음수, 0인지 판정하는 작업
data <- 0

ifelse(data > 0, '양수', ifelse(data <0,'음수', '0이다.'))

## 학점을 판정하는 프로그램
### 90점 이상이면 'A', 80점 이상이면 'B', 70점 이상이면 'C', 60점 이상이면 'D', 이외 'F
point <- 64

grade <- point %/%10 # 정수몫
grade 

# as.charcter(grade)
### switch ~ case
switch(as.character(grade),
       '10' = print('A학점'),
       '9' = print('A학점'),
       '8' = print('B학점'),
       '7' = print('C학점'),
       '6' = print('D학점'),
       print('F학점'
        )
       )

# 반복문 : 동일하거나 일정한 규칙을 가지고 있는 문장을 반복해서 처리
print(1)
print(1)
print(1)
print(1)
print(1)

# 개별변수 in 집합변수
total <- 0 # 누적변수의 초기값
sum <- 0
for(i in seq(10)){
  total = total + i
  sum = sum + total
}
print(total, sum)

i <- 1
while(i<11){
  print(i)
  i <- i+1
}

i <- 0
while(i<10){
  i <- i + 1
  print(i)
}

## 구구단 3단 출력
dan <- 3
for(i in 1:9){
  print(paste('3 x',i,'=',dan*i),quote=F)
}

dan <- 3
for(i in 1:9){
  cat(paste(dan, 'x', i, '=', dan*i, '\n'))
}